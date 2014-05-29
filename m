From: Pasha Bolokhov <pasha.bolokhov@gmail.com>
Subject: Re: [PATCH v3] Add an explicit GIT_DIR to the list of excludes
Date: Wed, 28 May 2014 19:33:48 -0700
Message-ID: <CAKpPgvcMJCYS9jfq+XhfZzT6w4RgBvMypqo2BsAWK2XYt2BPBg@mail.gmail.com>
References: <1400866411-14584-1-git-send-email-pasha.bolokhov@gmail.com>
 <CACsJy8CDeTn8h8uUn_=6ek7BJueN_1i01TB_AeH03RKnf6tNSw@mail.gmail.com>
 <CAKpPgvfqTBxFXOaStEyyS7wAdR5aUsEOX_M2gPvGz4_dJYvTOA@mail.gmail.com> <5386309E.3070003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 29 04:34:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpqAZ-0000EL-TB
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 04:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755431AbaE2CeL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 May 2014 22:34:11 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:49980 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbaE2CeJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 May 2014 22:34:09 -0400
Received: by mail-ob0-f169.google.com with SMTP id vb8so11830782obc.0
        for <git@vger.kernel.org>; Wed, 28 May 2014 19:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ma/waQzHOsq+wdENnT73ECCbBXw58zzf0LjXypsO+2U=;
        b=PcPkNBXWVTlbOVAa4RSbE8Lve/3zxyTOEj7bKBVQxh97u2vDPE2ilK2EREWnCSRvE+
         HosY65Rc31qUygDha+IX5jGvBy9NjaFzMXgvX13smSvhPNOpAugrv01kMOBm2zXjZEzR
         bnAkE7eo4IsgLme6jQ2s65DiVv/q6cTb+cb6DzKuZO2uCB3PUWtBxs2TmNPv5Nx1zIxq
         fklEjxCoeo5lDGmii+TD001l8Fb8vav48x1s0u974q8VsyctULloP+AG/Tnqh+34QzRG
         wRV708p423mL0u91I2RmdqPF5QUhL2E3Rm5t/B6usC4BTTyPo+6DK7BhrrehkFWTJe89
         5kiw==
X-Received: by 10.182.115.232 with SMTP id jr8mr4354363obb.35.1401330849032;
 Wed, 28 May 2014 19:34:09 -0700 (PDT)
Received: by 10.60.16.8 with HTTP; Wed, 28 May 2014 19:33:48 -0700 (PDT)
In-Reply-To: <5386309E.3070003@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250352>

Agree, but "partial" here means... what? just a little doc?


On Wed, May 28, 2014 at 11:53 AM, Jakub Nar=C4=99bski <jnareb@gmail.com=
> wrote:
> W dniu 2014-05-27 19:16, Pasha Bolokhov pisze:
>
>>>> Add GIT_DIR to the list of excludes in setup_standard_excludes(),
>>>> while checking that GIT_DIR is not just '.git', in which case it
>>>> would be ignored by default, and that GIT_DIR is inside GIT_WORK_T=
REE
>>>>
>>> gives git-grep.txt and git-ls-files.txt. I don't know if we need to
>>> add something about this extra exclude rule to those .txt. If it's =
so
>>> obvious that this should be the expected behavior, then probably no=
t.
>>
>>
>>      I suggest this. There appears to be a notion of "standard
>> excludes" both in the code (dir.c) and in the man pages (git-grep,
>> git-ls-files). However, it doesn't actually appear to be defined
>> strictly speaking. So my suggestion is to define those "standard
>> excludes" in one place (say "gitignore(5)"), and make other man page=
s
>> (git-config, git-grip, git-ls-files) have references to that place
>> instead of explaining every time in detail what is being excluded.
>
>
> Or define those "standard excludes" in standard-excludes.txt "partial=
",
> and include said file from git-grep(1), git-ls-files(1), and perhaps
> gitignore(5).
>
> --
> Jakub Nar=C4=99bski
>
>
