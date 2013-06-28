From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug on OS X...
Date: Fri, 28 Jun 2013 13:51:19 -0700
Message-ID: <7vmwqam01k.fsf@alter.siamese.dyndns.org>
References: <CAEBDL5VeE7dyo_A7904SBNSvf834xdGyyuk=vE44wXoRVJ-nkg@mail.gmail.com>
	<9DD46E0F-FA9C-4C60-A1CE-03EAAD823967@quendi.de>
	<CAEBDL5V3eAJGs-CTVZd8wVxKV3b+Gbk26E1rFaKjk-xBhSu31Q@mail.gmail.com>
	<7vwqpep3ab.fsf@alter.siamese.dyndns.org>
	<CAEBDL5UmYXXTds9vYumXY9hYBwJLsJq3CN6FRZm6c8SkjPxazQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Max Horn <max@quendi.de>, git@vger.kernel.org
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Fri Jun 28 22:51:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Usfde-0005WE-Op
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 22:51:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124Ab3F1UvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 16:51:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47105 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751010Ab3F1UvW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 16:51:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 892D12C6BB;
	Fri, 28 Jun 2013 20:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3nTMOcSVbAM/ky6Q7MpxE1XnFgk=; b=gtfx7/
	s7YVljSPFYAy8lte591fmqXlrUkFKWbDUcAFuvhUyMVuO5Ez/IMoa87mvu9aOsCI
	NhgD7alx29j8DlBm4HYehcnSIRydtRQF+dMTW9hQ1wX4CL21tx3eT0cCgbM78yAy
	NbWZwOtFEzAQXxoUgA3INFwUJsKmtOHBNCGQY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SUAKWWXRh6dVr/8RO2GB1SJVB1R5pGSP
	wM0OmIZfb6TccZ0xdijtKYaTEbkR4l4D4rJKOxY5JHWb7l1T/SIF9iZgjAZOmlNF
	we1KpuJ85rT4yDsdQuzUU6jAffbNtAHyXlIi3h9ca9gLF5T4eBhKdtAESFnWr2eW
	wsnBjK0QSqM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E72F2C6BA;
	Fri, 28 Jun 2013 20:51:21 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 025272C6B9;
	Fri, 28 Jun 2013 20:51:20 +0000 (UTC)
In-Reply-To: <CAEBDL5UmYXXTds9vYumXY9hYBwJLsJq3CN6FRZm6c8SkjPxazQ@mail.gmail.com>
	(John Szakmeister's message of "Fri, 28 Jun 2013 16:38:02 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7CBC9B5A-E034-11E2-853E-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229238>

John Szakmeister <john@szakmeister.net> writes:

> On Fri, Jun 28, 2013 at 1:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> An early part of nd/clone-connectivity-shortcut topic contains the
>> said commit, and I do not mind merging it to the maintenance track,
>> but I suspect that there is something else going on on your OS X
>> box, if you saw differences between platforms.
>>
>> Perhaps on your OS X box you have {transfer,fetch}.fsckobjects set
>> to true while on others it is set to false, or something?
>
> Good suggestion!  ....  Turning on transfer.fsckObjects did indeed
> cause the issue to appear on Linux as well.

Good.
