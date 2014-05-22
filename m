From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 0/2] format-patch --signature-file <file>
Date: Thu, 22 May 2014 12:00:39 -0700
Message-ID: <xmqqy4xtmyeg.fsf@gitster.dls.corp.google.com>
References: <1400723589-8975-1-git-send-email-jmmahler@gmail.com>
	<20140522142332.GA15095@hudson.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 22 21:00:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnYET-0005lM-Vn
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 21:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbaEVTAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 15:00:46 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55496 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750760AbaEVTAp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 15:00:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1CC6419C28;
	Thu, 22 May 2014 15:00:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Cii0FoWvB5RW55/cQbUZEkwifn0=; b=xX6C54
	Cnemz3Z9ccfZZAfe6ZmBsqwkoqFPIuZL04kSkZQW8H5GoFIwDxBty17+HFL7hpcj
	nTraNSGLI7vFNGsFd24mgRXPHEvnhVB5AbH2qDFrollyFd5XIqT7VtfwgJYyGto0
	D+eb0tNOE7zCeySPRH4df0L6KJNwLj2vyz1aA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kRI7EhKzA4S0o3bk35ufwYK/gIGAr97a
	OXWwpN/xwxfgubnENSRdFT2DXbe+/+yl/DG1dpt/Hnwc4Ce5uhy0T8Fn5BGQympg
	ttDdwY6ZMv39xfHVCa0CCiSfXJnHqxi/VPB1v1jz/XoUxml/4L4cIZ20bIGjDvpe
	kBqxm/0FtJU=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 139CE19C27;
	Thu, 22 May 2014 15:00:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1AA6019C18;
	Thu, 22 May 2014 15:00:41 -0400 (EDT)
In-Reply-To: <20140522142332.GA15095@hudson.localdomain> (Jeremiah Mahler's
	message of "Thu, 22 May 2014 07:23:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5E8ABC78-E1E3-11E3-AEB8-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249933>

Jeremiah Mahler <jmmahler@gmail.com> writes:

> I just notice that my patch is in 'pu'.
> But it is version 7 instead of the improved version 8.

Yeah, I know.  In a distributed environment, multiple people work
independently and a sequence of event can go like this:

 - I read v7, comment, and queue it only so that I won't forget;
 - I attend to other topics;
 - I start the day's integration cycle, merging topics to the
   integration branches, maint, master, next and pu;
 - You reroll v8 and post it;
 - I may not notice v8, or I may notice v8 but think it is not
   worth to discard the integration work so far only to replace
   v7 with v8.
 - The integration result is pushed out.

A reminder is very much appreciated, but on the other hand it is not
something unusual.  It happens all the time, and I usually am aware
of it ;-)

Thanks.
