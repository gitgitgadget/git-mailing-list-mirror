From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH RESEND] spec: add missing build dependency
Date: Fri, 6 Apr 2012 15:33:45 +0300
Message-ID: <CAMP44s0K6vK4aMBS7=oUbqXiYaGF+m-jBf9yySs8G9OHJd8hNA@mail.gmail.com>
References: <1333714950-22212-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Pavel Roskin <proski@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 06 14:33:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SG8MR-0004sX-6a
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 14:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756968Ab2DFMdr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 08:33:47 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:50333 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754839Ab2DFMdq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 08:33:46 -0400
Received: by wejx9 with SMTP id x9so1435022wej.19
        for <git@vger.kernel.org>; Fri, 06 Apr 2012 05:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fbeWY0o1ryMuQQH02wUmhc3v9HxiAIX3ucVqb9PhNlk=;
        b=K1Qq+QXdduZ38xsQNj7eHg3hjlAKnXZBA+kDTk6fGr35ceaQY9NVUSxYEumCpLie3r
         T1Pw+sywCN30z3i5huY6gyuexliECKOXfB6XuYo1jFsAPhBh3KmRXBefetF0U1v/VJ4B
         HK4qFKdmYDkFhxUN9bII63eNKJPpmjiUxUD5nKVJXKmBpO9v8DZKgGdC5GMsm8hwPc79
         B0B+XVDiMtdQmYpgaRpGL9zRUv7kJwoeug+VDgt4MCZ3SV5zv+wDff0UHNSIIYkZbU07
         s4H/TwHZqgeyMxjOfa3ri6UsZZrt+q9ZmpxCIvlyp7kltIMQkN79Mi5auda+Do+In3Ob
         mIbg==
Received: by 10.180.96.168 with SMTP id dt8mr11364770wib.18.1333715625212;
 Fri, 06 Apr 2012 05:33:45 -0700 (PDT)
Received: by 10.216.70.4 with HTTP; Fri, 6 Apr 2012 05:33:45 -0700 (PDT)
In-Reply-To: <1333714950-22212-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194871>

2012/4/6 Felipe Contreras <felipe.contreras@gmail.com>:
> Otherwise:
>
> /usr/bin/perl Makefile.PL PREFIX='/opt/git' INSTALL_BASE=''
> Can't locate ExtUtils/MakeMaker.pm in @INC (@INC contains: /usr/local/lib/perl5 /usr/local/share/perl5 /usr/lib/perl5/vendor_perl /usr/share/perl5/vendor_perl /usr/lib/perl5 /usr/share/perl5 .) at Makefile.PL line 1.
> BEGIN failed--compilation aborted at Makefile.PL line 1.
> make[1]: *** [perl.mak] Error 2
> make: *** [perl/perl.mak] Error 2
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

You might want to reply to this message to avoid non-existing
recipient warnings.

Cheers.

-- 
Felipe Contreras
