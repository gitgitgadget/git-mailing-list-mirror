From: William Pursell <bill.pursell@gmail.com>
Subject: Re: permissions
Date: Tue, 08 Jun 2010 12:27:28 -1000
Message-ID: <4C0EC3D0.6060509@wpursell.net>
References: <4C0A19FE.1020802@wpursell.net> <m27hmdn704.fsf@igel.home> <4C0A9615.4090307@wpursell.net> <AANLkTileRHwUuJpvKJbivRiM9Prn9wJ0zH6abExBgcq0@mail.gmail.com> <4C0B6C32.1090700@wpursell.net> <7vvd9wvswy.fsf@alter.siamese.dyndns.org> <4C0E1AB1.2030702@wpursell.net> <AANLkTimAmSxq8dC-4bnpLsvN3JabQeTO6pDTh9ds7D0D@mail.gmail.com> <7vtypds09x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>,
	William Pursell <bill.pursell@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 09 00:27:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM7Gl-0005zm-4p
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 00:27:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756434Ab0FHW1d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 18:27:33 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:45723 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755791Ab0FHW1d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 18:27:33 -0400
Received: by pwj5 with SMTP id 5so1649018pwj.19
        for <git@vger.kernel.org>; Tue, 08 Jun 2010 15:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=0Po+gfhwJnUs7g9tAeIyeOfkyjJakTvXPxqsBfkRvWY=;
        b=YJvc6t6rItRPld9Qwpzh/AfWcglL1jKHbSJv4eNXVlrxSjd4sJt2f+Xm0paZCwJBlu
         71APdbRgBgpRHi/Bmn8j8wLR7qoXTcpRCAdidB/U8+sAHH4fhDnYlp7b8jFbjRTkhohv
         rRTEeXDGCBCJ8fBlxRpjx1L/33ar3sBZcbI6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=W5FDZSYQUkWm3vEwEUrIfaElwR1xA1wCchbSr4bCWfTE0FpzKQthM5t7ONCkori48A
         EJMLlAMIAs4X51icAP4VrfXkb/w+pQRllXJpv84ZsmyowVkub5j2hcRPqtfxF8Y4x9tO
         XU1kQ7NlzYYlgnKZSsLLacYjtq4Dfag/DJUbk=
Received: by 10.143.26.1 with SMTP id d1mr12481264wfj.311.1276036052514;
        Tue, 08 Jun 2010 15:27:32 -0700 (PDT)
Received: from clam.westell.com (udp278831uds.hawaiiantel.net [72.234.51.251])
        by mx.google.com with ESMTPS id b6sm55654650wam.9.2010.06.08.15.27.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Jun 2010 15:27:31 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.24 (Macintosh/20100228)
In-Reply-To: <7vtypds09x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148729>

Junio C Hamano wrote:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
>> On Tue, Jun 8, 2010 at 12:25, William Pursell <bill.pursell@gmail.com> wrote:
>>> Here's a patch.  This doesn't address the issue of a damaged
>>> repository, but just catches access errors and permissions.
>> The change looks fishy.
>>
>> The patch moves the function is_git_directory at the level of user
>> interface where it wasn't before: it now complains and die.
>> Not all callers of the function call it only to die if it fails.
> 
> Thanks for shooting it down before I had to look at it ;-)

The point of the patch is that it now complains and dies.
Perhaps I'm being obtuse, but can you describe a situation
in which this causes git to terminate inappropriately?



-- 
William Pursell
