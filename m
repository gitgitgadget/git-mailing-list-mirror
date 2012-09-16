From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 01/12] git p4 test: remove bash-ism of combined
 export/assignment
Date: Sat, 15 Sep 2012 23:05:12 -0700
Message-ID: <7vfw6izenb.fsf@alter.siamese.dyndns.org>
References: <1347221773-12773-1-git-send-email-pw@padd.com>
 <1347221773-12773-2-git-send-email-pw@padd.com>
 <5054F22D.2020909@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sun Sep 16 08:05:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TD7z1-0008Qw-3h
	for gcvg-git-2@plane.gmane.org; Sun, 16 Sep 2012 08:05:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523Ab2IPGFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2012 02:05:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34790 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751480Ab2IPGFP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2012 02:05:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 305275E25;
	Sun, 16 Sep 2012 02:05:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZneO3LkJm2MS3nZGsSVpmIspEHo=; b=YRAN0c
	JhjQt4ovMsIf1vmmmfTKpNiqZNwk/7CqIF3tDXdfW9s3GZEqBj9OVEBsm21aFkRS
	n3QKj8Q7P1AkPbi9Thhj/vgCVk2VZaSSQzxcBieaPLCAzJYaaSQx1sr96ZdFEjNP
	DciFzi5QJxDHurz/W+HMhw8zJq7KfGsRogIjc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j4TVyYD0VuVtshOoesyL/yEVbuRrl6Bg
	OikACWGxYCJYfEF7ZweE0BNA1FqkIRIaib/W7oJ2iJnHCph1/1sMPpNX8iAaXHfz
	I299pUo30q3Vez/Q4LF0ZL5813eoFKZ23HrMjkT29+Y1NxGtrccvkEVvJG3IVanH
	9VfpbkWojqM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A3245E24;
	Sun, 16 Sep 2012 02:05:15 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 841135E22; Sun, 16 Sep 2012
 02:05:14 -0400 (EDT)
In-Reply-To: <5054F22D.2020909@diamand.org> (Luke Diamand's message of "Sat,
 15 Sep 2012 22:25:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7B524676-FFC4-11E1-B0D4-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205594>

Luke Diamand <luke@diamand.org> writes:

> Looks good to me, ack.

Thanks; is this an ack for the entire series, or are you expecting
further back-and-forth with Pete before the whole thing is ready?
