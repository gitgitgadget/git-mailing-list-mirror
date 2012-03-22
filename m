From: PJ Weisberg <pj@irregularexpressions.net>
Subject: Re: [PATCH] Demonstrate failure of 'core.ignorecase = true'
Date: Thu, 22 Mar 2012 13:40:50 -0700
Message-ID: <CAJsNXT=YEida53nV7kj6a3cw2GibYJab4n2PucNO6inUR3HPRQ@mail.gmail.com>
References: <1332370222-5123-1-git-send-email-pj@irregularexpressions.net>
	<7vmx79zeui.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 21:41:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAooe-00031U-Ni
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 21:41:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759841Ab2CVUkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 16:40:53 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:65047 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759778Ab2CVUkv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 16:40:51 -0400
Received: by wibhr17 with SMTP id hr17so1136098wib.1
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 13:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=+J2+Lzo1lev+DHA8ZuwqJRk8UzwP557mbbnSisbgiZc=;
        b=QOu5fnWnOaZVsSZWc6SH2X5s0lJqbtsYD+EQGBsCUthALb9/yMjbwjrQvEvCmYzYfx
         J/PMVXPHz2gdSg85eQ4FulYo9s2rDpuakTLOBj76CxnFReQaN151DS204dYLO3UoLNbf
         bowZKZ+icUkXIU3fo8gLDMSYNKr4dIZdtPqH94uwdwb4uH+tbmBFt1x9v1JNTdF5fUO6
         3WwxH0RzxHIO/281XVUeBlMCqJ649t5HT2miGFS+hiq3b2l7uxmVwoSb2nMd7EIrUNt4
         sWOFNrKK8Spamc4eYoebODHmwGcYNmxQ7sN+uXaHxBFPazcwPTviCtc16yCTpIqJjWbc
         EyVA==
Received: by 10.180.104.230 with SMTP id gh6mr557908wib.22.1332448850426; Thu,
 22 Mar 2012 13:40:50 -0700 (PDT)
Received: by 10.223.160.1 with HTTP; Thu, 22 Mar 2012 13:40:50 -0700 (PDT)
In-Reply-To: <7vmx79zeui.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: EaYzf6YuF2av-gPGfu5ItvO4GH4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193714>

As you've probably deduced, I simply failed to RTFM.  I'm not sure
you'll gain much by changing the description on the man page, since I
thought the name 'ignorecase' was self-explanatory and barely even
looked at it.  :-/

On Wed, Mar 21, 2012 at 4:58 PM, Junio C Hamano <gitster@pobox.com> wrote:

> underlying system calls like open("foo") will *not* magically start
> returning a file descriptor opened for "FOO" if your filesystem is not
> case insensitive.

No, but magic_open("foo") might, if someone had put forth the effort
to write a function called magic_open.  But the more I think about it,
the more it seems that doing everything you would need to do to make
ignorecase work the way I thought it did is almost certainly not worth
the effort.


-PJ

Gehm's Corollary to Clark's Law: Any technology distinguishable from
magic is insufficiently advanced.
