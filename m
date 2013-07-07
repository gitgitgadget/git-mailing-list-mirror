From: Kyle McKay <mackyle@gmail.com>
Subject: Re: [PATCH] prompt: do not double-discriminate detached HEAD
Date: Sun, 7 Jul 2013 11:32:02 -0700
Message-ID: <D6C71A23-A3AE-49F3-9D3A-B92483E7D247@gmail.com>
References: <1373201565-14030-1-git-send-email-artagnon@gmail.com> <CAEBDL5UfHpR3GNeqbDf9X3Ya+Spcpx0Byq5MZPMMsE=a3y2jhg@mail.gmail.com> <7vppuu45q8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: John Szakmeister <john@szakmeister.net>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Eduardo R. D'Avila" <erdavila@gmail.com>,
	=?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 07 20:32:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvtkp-0004Ow-FY
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 20:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753014Ab3GGScI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 14:32:08 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:50881 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752955Ab3GGScG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 14:32:06 -0400
Received: by mail-pa0-f44.google.com with SMTP id lj1so3653533pab.17
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 11:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mailer;
        bh=R4xVfQYBpH2XQrgEaTvBAjwjrqUe7GwrZ1tQIjuHvSw=;
        b=Nc7fMbHuWqAH00YvOM5xrjKpmqkrzc/dY30sryqMr3o6x26Yy89dawysgAl5v+DURP
         I6xF2rwrP47e7hLkoZyEn+P435PzFvZYZFFoA7RNbxWF5/zSm7Bx10lCAqK1c6CJKboF
         PHFg4jgV+nOiLtrL57wswcO4mvkxhwBQyt6QxrXccarUxH0vVl7Pcno3VPkGn/l+kOf+
         3QR2YbIKRUMxy6jNeF/VeKOoQdeE1m73slwHQ3wvcjHcU6XwP38uAvco7GLzmZeEq9lA
         dgtWRIUeqcHwJeYOITq2tzqEwWLy+kNnaVDjLT7g0a7kaJmpkRMFNi0fbAfyoB4xd37c
         Su/Q==
X-Received: by 10.66.233.168 with SMTP id tx8mr19420162pac.80.1373221925600;
        Sun, 07 Jul 2013 11:32:05 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id ne6sm13740458pbc.28.2013.07.07.11.32.04
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 07 Jul 2013 11:32:05 -0700 (PDT)
In-Reply-To: <7vppuu45q8.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229796>

On Jul 7, 2013, at 10:53, Junio C Hamano wrote:
> John Szakmeister <john@szakmeister.net> writes:
>
>> On Sun, Jul 7, 2013 at 8:52 AM, Ramkumar Ramachandra <artagnon@gmail.com 
>> > wrote:
>>> When GIT_PS1_SHOWCOLORHINTS is turned on, there is no need to put a
>>> detached HEAD within parenthesis: the color can be used to  
>>> discriminate
>>> the detached HEAD.
>>>
>>> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
>>> ---
>>> For cuteness :)
>>
>> Personally, I'd rather see the parens kept.  Not everyone sees red
>> very well--I know several people who can't see it at all, and it  
>> keeps
>> it consistent with non-colored output.
>
> +1; I find red on many terminal emulators to be too dark to tell,
> especially in a small font, from black myself.

+1; me too for the same reason.
