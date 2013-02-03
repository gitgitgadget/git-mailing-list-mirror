From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] branch: show rebase/bisect info when possible instead
 of "(no branch)"
Date: Sun, 03 Feb 2013 14:00:03 -0800
Message-ID: <7vwqup6ot8.fsf@alter.siamese.dyndns.org>
References: <1359461574-24529-1-git-send-email-pclouds@gmail.com>
 <1359870520-22644-1-git-send-email-pclouds@gmail.com>
 <vpqpq0hnlb1.fsf@grenoble-inp.fr> <7v1ucx83fz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Feb 03 23:00:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U27c1-0004Zv-I1
	for gcvg-git-2@plane.gmane.org; Sun, 03 Feb 2013 23:00:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753834Ab3BCWAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 17:00:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41929 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753670Ab3BCWAK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 17:00:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A390C457;
	Sun,  3 Feb 2013 17:00:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LQwChSDs46/IWBCkTJ4+xPRxAOk=; b=dBL/uZ
	XmuLXshuut5KhM0xr8+ZWC+HB/oSQzaFk57WnimrkyBYEe2bVoFRADAl5zIAXSfQ
	Id19xIiUD0Xzg4Jz6aDLGd88/bvIXq8hL04raaaObP0HUiC27jRH3s3eCN95kIfF
	OtQtRF4UI3+IyCmXyGcynWkWbpv1dp+iahFT0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n7cVy5HTGfI2+VUxybWfIVMzUwkWSjbH
	fWnT3bqhTTIWFt8cyyx4GTGPepCgbOq62vkVt2t7Eb8LUHoQHt/qBgcfs39w6+Jq
	wp63SI+yXdqNIm/8bQR2M/1cWe1RZTvXraEGn7jVZg/UPFvhnA1NJB87jdNpwjBT
	/+GKno1Us7o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FBC1C456;
	Sun,  3 Feb 2013 17:00:09 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 60CEDC450; Sun,  3 Feb 2013
 17:00:08 -0500 (EST)
In-Reply-To: <7v1ucx83fz.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 03 Feb 2013 13:58:40 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 12F3C706-6E4D-11E2-BC1C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215338>

Junio C Hamano <gitster@pobox.com> writes:

> Yeah, I do not think "bisecting other" alone makes much sense.
>
> What does "other" refer to when you start your bisection at a
> detached head?  I personally think "other" has _any_ value in that

s/_any_/_no_/; obviously ;-)

> message, because "(no branch, bisecting)" gives the same amount of
> information, especially because "other" does not say which branch it
> refers to at all.
