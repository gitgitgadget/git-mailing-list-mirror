From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: I need a `git format-patch --attach-complete' for RT
Date: Thu, 29 Apr 2010 09:25:25 +0200
Message-ID: <4BD93465.60507@gnu.org>
References: <q2j51dd1af81004210522ze6062110j2033788601e17ce8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 30 22:21:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7wiG-0001B9-FC
	for gcvg-git-2@lo.gmane.org; Fri, 30 Apr 2010 22:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932588Ab0D3UVV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Apr 2010 16:21:21 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:30601 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932520Ab0D3UVT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Apr 2010 16:21:19 -0400
Received: by ey-out-2122.google.com with SMTP id d26so38990eyd.19
        for <git@vger.kernel.org>; Fri, 30 Apr 2010 13:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=pM1884LMXzxbVs2cpJgbnURVvDiMiBfLrs+7EBUV0nA=;
        b=eL8NTKSUbDq/L8PIgbpB2sm0sIb6UbcAcGEu9dM98S6pBRXHqv1NvbWohJ9RP7bnmX
         A8majDR8E4M43IPi5e0xfdoMo4SyQ9cHbVfnqvCSWQI0S+dSjEpfztsCVq5RM1iajp6K
         8Buzu0tiaAjuG93LJrEv4Lx3w5nR2CLcTXgNY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=T6qUo3gCi2UPGtTfYPDpFlDnNndd6I5qGdbtpVGArkRLVYxMV9TK/toRjULGcxFkFX
         UoV8gp+5owYsXzGIJ2yfwXHpZ0tgLvuJZIsZZ+NOkFkkuO9U4uNvYGZ1M6Rqw+ZCRncm
         WrgG4++QAb9sr64x0lkzBbH/Wa2n17to4kgcM=
Received: by 10.213.49.204 with SMTP id w12mr1424403ebf.22.1272525930155;
        Thu, 29 Apr 2010 00:25:30 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-brq-t.redhat.com [209.132.186.34])
        by mx.google.com with ESMTPS id 15sm362759ewy.12.2010.04.29.00.25.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Apr 2010 00:25:27 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.8) Gecko/20100301 Fedora/3.0.3-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.3
In-Reply-To: <q2j51dd1af81004210522ze6062110j2033788601e17ce8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146062>

On 04/21/2010 02:22 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> I'm working with a system that doesn't play nice with git-format-patc=
h
> / git-send-email. When you send mail to RT (e.g. http://rt.perl.org/)
> it'll always munge the original E-Mail, so inline patches won't
> work. [...]It would be nicer if I could instead:
>
>      git format-patch --attach-complete origin..
>      git send-email *.patch

This is a bit underspecified.  What should the subject be?  Do you want=
=20
to have something like --cover-letter but placing the messages after=20
00/NN in an attachment?

It seems easiest to write a small filter in Perl, but it could be added=
=20
as an option to git-format-patch, maybe something like=20
--cover-letter=3Dattach-all.

Paolo
