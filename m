From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] shorten_unambiguous_ref(): Allow shortening refs/remotes/origin/HEAD to origin
Date: Tue, 07 May 2013 14:03:30 -0700
Message-ID: <7v61yujye5.fsf@alter.siamese.dyndns.org>
References: <1367711749-8812-1-git-send-email-johan@herland.net>
	<1367711749-8812-2-git-send-email-johan@herland.net>
	<7vy5bsq9m9.fsf@alter.siamese.dyndns.org>
	<CALKQrgcoz-+5Kb-Y1Ui9LhE=+pvcRUdAS+iRWXAfsYnV6+k34w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue May 07 23:03:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZp2w-0001rx-LY
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 23:03:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757892Ab3EGVDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 17:03:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60896 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752536Ab3EGVDd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 17:03:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4C211C013;
	Tue,  7 May 2013 21:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nVNWBjRdZLYrk+o9h1eYkpPC+Jw=; b=JWowYP
	+S8VyVB9ed4IQqs8OIBKFeOIcC/zigH4fe6+9BC0iGk3xhHCBPNxDJ90onLW/xfS
	RUX/+RWxoikKbFmYKTU/IvuKR4cKOOs/nN4VuvcPwyJmx9KmESf92cwamDxGMyLW
	dWyGbNpGoG+yCbuUjd0p2o7hUC/1FF2yPpIMo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XdFDyHdspGoVzGzvyG5OO73k4uOssNUO
	OSerneW3kZhewQuuh9GkebgqiuKhyrUG78J4bXmbQrT8u02CYe0m5WCn6bhCuDZ0
	FBD9Q0Wo3fVsU0UjoHMAuzrmHs3IeebmLfmbHY2mcGbzaWCKRBJh23yV4KnQo34L
	hTIPd9RmaTo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A96181C012;
	Tue,  7 May 2013 21:03:32 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2A6791C011;
	Tue,  7 May 2013 21:03:32 +0000 (UTC)
In-Reply-To: <CALKQrgcoz-+5Kb-Y1Ui9LhE=+pvcRUdAS+iRWXAfsYnV6+k34w@mail.gmail.com>
	(Johan Herland's message of "Tue, 7 May 2013 20:49:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 93105AA8-B759-11E2-AE07-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223602>

Johan Herland <johan@herland.net> writes:

> New version coming up. I'm going to rip this patch out of the
> surrounding series, since it doesn't really belong there anyway.

Thanks; will queue.
