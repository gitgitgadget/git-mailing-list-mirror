From: Tong Sun <suntong@cpan.org>
Subject: Re: Recommended work flow with git to send in patches
Date: Tue, 27 Jul 2010 15:48:37 -0400
Message-ID: <AANLkTi=psuiq-GP9zV=pY6swNAUF-MwJt6COrNDVDLqu@mail.gmail.com>
References: <AANLkTiksAOpFG3vGVGcbeZ0NcpQ5FbDjnZ7yDxUsAY_r@mail.gmail.com>
	<m3y6cwkew7.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 21:48:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odq8r-0002Xv-7F
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 21:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447Ab0G0Tsj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 15:48:39 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38620 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331Ab0G0Tsi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 15:48:38 -0400
Received: by pzk26 with SMTP id 26so1537086pzk.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 12:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        bh=kJ5YK6GidZThCbUIUfKHYUUaj+kdxu1o9dt4kXAb5Wc=;
        b=Job2de8BRdkuPTYQs9wUs8f0kmeoQw/3llvD5oHQ/Tr95I16FHAuJ10aiT0ddl2dJd
         rsWYQaA9OyoXr5pjCXXO8a9xGfKm6OJjUQcX5xJABQ8A7WKR0M96jt2s/fk83Xx+oyzX
         ad8G3naA+6ZFkW4+irbw407bWdPknSIq5DLvE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=RQfZgHEvRWep9s19DLx79QbEJ/5/zcuSjiYd5qg/P486wHSM2f3pX963cjE5CgkyzB
         beR9mKwvVv4kKEY7t+8w/tQNEQqmgvx5eTEr3vBufgwKTCEXVQX7BvTbgM32P3NOlEtU
         Qa4UlqVX75QI6bB7HzMiYNjMFT3uDvFMOVZds=
Received: by 10.114.109.14 with SMTP id h14mr11343123wac.4.1280260117796; Tue, 
	27 Jul 2010 12:48:37 -0700 (PDT)
Received: by 10.114.130.11 with HTTP; Tue, 27 Jul 2010 12:48:37 -0700 (PDT)
In-Reply-To: <m3y6cwkew7.fsf@localhost.localdomain>
X-Google-Sender-Auth: I9NmpZZzjnS299iT0UuWDs3FBJ4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151977>

On Tue, Jul 27, 2010 at 1:35 PM, Jakub Narebski <jnareb@gmail.com> wrote:

> Doesn't GRML have web page / wiki page for developers?

Yes, http://grml.org/git/, but it is kind of reference book style,
doesn't cover much on the work flow, especially on the topic of
no-writing-privilege user contributing back.

>> - do initial git pull into grml-debootstrap
>>
>>   git pull git://git.grml.org/grml-debootstrap master
>
> Why not git-clone (possibly shallow, if you are working on one-shot
> patch or patch series)?

Ok, to explain it, I have to touch upon my "life long story" of using
git. Long story short on this, the recommended work flow that I
searched and found from the Inet was to do 'git clone' from web then
'git clone' a local working copy. Here is my trying log:

# Download the latest version of the repository without downloading all the
history, using "shallow checkouts".

  git clone --depth 1 git://git.grml.org/grml-debootstrap.git

create working repo:

  $ git-clone --depth 1 grml-debootstrap grml-debootstrap.working
  Initialized empty Git repository in
/export/repositories/gitwork/grml/grml-debootstrap.working/.git/
  fatal: attempt to fetch/clone from a shallow repository
  ^^^^^^^^^^^^^^^

Seeing that fatal error, and not knowing where to get help from, I
just gave up the 'git clone' approach. Please be specific (with git
commands), how would I use 'git clone' for working on one-shot patch
or patch series.

Got to run, will comment on the rest later.

thanks
