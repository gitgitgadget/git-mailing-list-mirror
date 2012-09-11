From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Should GIT_AUTHOR_{NAME,EMAIL} set the tagger name/email?
Date: Tue, 11 Sep 2012 16:56:27 +0200
Message-ID: <CACBZZX61pfus=coO4bh8LwKb578nrnL-gQqa_xQH__uqSe9fJA@mail.gmail.com>
References: <CACBZZX7Ud8Xx225ss6SYqZFXyW0FG2XJimBWdvW_NuMqn8yOnA@mail.gmail.com>
 <m2ehmlwxb2.fsf@igel.home> <CACBZZX4Egrx_vrKNV68pL8DL4xkLd5j8o-1t4+fA7+Ai758-9g@mail.gmail.com>
 <m2a9x9wwma.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Sep 11 16:57:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBRtZ-00017f-7o
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 16:56:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758653Ab2IKO4t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Sep 2012 10:56:49 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:58714 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756166Ab2IKO4s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Sep 2012 10:56:48 -0400
Received: by obbuo13 with SMTP id uo13so867013obb.19
        for <git@vger.kernel.org>; Tue, 11 Sep 2012 07:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=NIy4uMTKPQ6NiGaSvmyRfbwOH+zc+Hp/FTWXuijBw68=;
        b=f5sSMdhXyAN9+UwNu6BTs0D3ffzoy1LnSvhpIBhjiNktt+aV6jRtZXvG/9oorJG5fP
         lnNKSPNZ53snf9sZKrlZT+m0zhf4V4jL0hsK7BAob1J482MRdrR5Bfr4a0ZMnhdgeNMx
         717caNMclwmnDMxZbgWR984fjJv7FrXRgnaYE4nezq7YJ/Ba8PSZcKEbJzK0n2WMjDd5
         XQTEfZanwKZO5VMeNlyO+ASuRTy7Op7ZOeRAXyBx/BYFxjW+iK8b0b4QH1p++Xpp8Shn
         DIBoy/+rN2wTu8xByKnBMd45Nc8QlzTpFljvaBc97ZHSCgIaJMua1cMBa20HMwG3b5JM
         La+Q==
Received: by 10.60.29.134 with SMTP id k6mr18183514oeh.5.1347375407510; Tue,
 11 Sep 2012 07:56:47 -0700 (PDT)
Received: by 10.60.16.34 with HTTP; Tue, 11 Sep 2012 07:56:27 -0700 (PDT)
In-Reply-To: <m2a9x9wwma.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205234>

On Sat, Sep 1, 2012 at 6:12 PM, Andreas Schwab <schwab@linux-m68k.org> =
wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> I don't get what you mean, what committer info?
>
> GIT_COMMITTER_{NAME,EMAIL}.  A tagger isn't really an author.

Ah, am I the only one that finds that a bit counterintuitive to the
point of wanting to submit a patch to change it?

If you've created a tag you're the *author* of that tag, the
author/committer distinction for commit objects is there for e.g.
rebases and applying commits via e.g. git-am.

We don't have a similar facility for tags (you have to push them
around directly), but we *could* and in that case having a
Tag-Committer as well well as a Tagger would make sense.

Junio, what do you think?
