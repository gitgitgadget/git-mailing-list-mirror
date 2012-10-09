From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] MALLOC_CHECK: Allow checking to be disabled from config.mak
Date: Tue, 9 Oct 2012 14:33:15 +0200
Message-ID: <CAP8UFD2k9HjAKq-1WrRpk3NtqWnewDmqT0dqKfN9vYDk9fnBQg@mail.gmail.com>
References: <50706B54.8090004@ramsay1.demon.co.uk>
	<7vbogfquc8.fsf@alter.siamese.dyndns.org>
	<CA+EOSBnKqkQ_nLyEKzxsMYnB04X9ABMp3P3CuDy3ohfcoEbQtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 09 14:33:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLZ04-000548-Ey
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 14:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753071Ab2JIMdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 08:33:19 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:62023 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889Ab2JIMdR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 08:33:17 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so4696823wgb.1
        for <git@vger.kernel.org>; Tue, 09 Oct 2012 05:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=n+fb+NIwG1JMrdd+JJ94gYHIyJs4kOxE5fRSCnjaUFE=;
        b=GTwkVowOW+UW/paYF9C/XNMOg6WLt9CIXUEa2uRgYIaqZ48QzALT4uzGCg9p3xJ7NB
         /w9Lsd3POa4Gr1ATU5OI00udPj4eGT7cqawR0bwn0j7IW45SbdKnROxMWGE+J4Aamzmr
         +yfOnrbOD0Hvnypt0wcXafCdp3Adt+nilJxpEgBF8N7AfUlkS9fGfQ3SyUVosKDgO2AT
         n7rK9V+aznrFz3hMPmQftoYpdULyqJi9jbuVZhmFXJgliAIA/8xSWi4zxjGOe+GFbLW/
         XhZeXug+/DgmhcYMXPTqoJtKwkfsQErFNezuZkay0XOKtqH+dq6GTEd7kM7VdnWHW59s
         CmBg==
Received: by 10.216.133.91 with SMTP id p69mr11032166wei.111.1349785995902;
 Tue, 09 Oct 2012 05:33:15 -0700 (PDT)
Received: by 10.223.97.10 with HTTP; Tue, 9 Oct 2012 05:33:15 -0700 (PDT)
In-Reply-To: <CA+EOSBnKqkQ_nLyEKzxsMYnB04X9ABMp3P3CuDy3ohfcoEbQtA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207318>

Hi,

On Mon, Oct 8, 2012 at 3:19 PM, Elia Pinto <gitter.spiros@gmail.com> wrote:
> Ok. I have found. For me this is not a problem any more these days.
> Was fixed in glibc 2.8.90-9 2008
>
> * Wed Jul 16 2008 Jakub Jelinek <jakub@redhat.com> 2.8.90-9
> - update from trunk
>   - fix unbuffered vfprintf if writing to the stream fails (#455360)
>   - remove useless "malloc: using debugging hooks" message (#455355)
>   - nscd fixes
> (from glibc rpm changelog)
>
> This is the bugzilla filled and closed
> https://bugzilla.redhat.com/show_bug.cgi?id=455355
>
> Ramsay, what version of glibc you have and in what distro? thanks

I have the same problem on a RHEL 5.3 (2.6.18-128.el5 #1 SMP Wed Dec
17 11:41:38 EST 2008 x86_64 x86_64 x86_64 GNU/Linux) with
glibc-2.5-34.

Best,
Christian.
