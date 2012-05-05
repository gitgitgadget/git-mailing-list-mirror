From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: broken bash completion
Date: Sat, 5 May 2012 16:26:18 +0200
Message-ID: <CAMP44s0HtcO0S-Vjq=XkiB7VLZq-LWr2tf2MF_HMpj=1C=LKSQ@mail.gmail.com>
References: <4FA14016.8050503@rolf.leggewie.biz>
	<20120504233213.GF2164@goldbirke>
	<4FA4AB86.8020108@rolf.leggewie.biz>
	<20120505121319.GG2164@goldbirke>
	<CAMP44s0q_zeVwzhgeda1=9+Psjr5PaO1QtHT1QC0RwyCpfd=rg@mail.gmail.com>
	<CADVrmKRjw6VFQAnQruBmc1OhOaswpOtzb+E8G_KooYiz6SuStA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Rolf Leggewie <foss@rolf.leggewie.biz>, git@vger.kernel.org
To: fREW Schmidt <frioux@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 05 16:27:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQfwn-0001BJ-Sc
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 16:26:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755215Ab2EEO0V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 May 2012 10:26:21 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:39670 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755082Ab2EEO0U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 May 2012 10:26:20 -0400
Received: by eekc41 with SMTP id c41so1065455eek.19
        for <git@vger.kernel.org>; Sat, 05 May 2012 07:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=XA7trNE6G+aJg1wrm3EmzsqEeG1/9nPbX0MX1o567zo=;
        b=zTeVo+nkBjXONe2w8OZloXGWZ+vHUWcC5JX6vGSr50nmWLGif/9ZoCwl1riwzG/Lhy
         KzT1PUFaIL8w3pugk4quGZ/KKSpgHlYo+R4YjX8e2ONesVwDRDCElJSkqiZ1fH0ZEC31
         BikNhIdTBOs/ZWGddbtxXqA/yA2MGbvEB/Nbi1zXTVZ20sB8rCbGzXOOHSOWm3je27gc
         pT9t4oMH9OUXAW0fgc2YXmaSvYqzFm3wZ2YFk4g+TsUASgSc2iLv4MHUf7T+zvcT7zFy
         Wye7hiLl0o4iGDWEG44D1ThIumLf1vxSOBO+LoFQDPj9cmWbs1CvzjlNpX7pJso4dFxt
         9y2Q==
Received: by 10.213.19.200 with SMTP id c8mr1767358ebb.113.1336227979301; Sat,
 05 May 2012 07:26:19 -0700 (PDT)
Received: by 10.213.103.18 with HTTP; Sat, 5 May 2012 07:26:18 -0700 (PDT)
In-Reply-To: <CADVrmKRjw6VFQAnQruBmc1OhOaswpOtzb+E8G_KooYiz6SuStA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197115>

On Sat, May 5, 2012 at 3:57 PM, fREW Schmidt <frioux@gmail.com> wrote:
> On Sat, May 5, 2012 at 8:11 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>>
>> On Sat, May 5, 2012 at 2:13 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de=
> wrote:
>>
>> The reason I started to use the bash completion in zsh is that the z=
sh
>> completion goes for 100% correctness, that means 'git checkout <TAB>=
'
>> took literally *minutes* in my machine on the Linux kernel repo. The
>> zsh developers said that was OK, and my patch to solve the problem w=
as
>> not, because it would make the result less than 100% correct.
>
> Could you elaborate on how you did that? =C2=A0I'm suffering from the=
 same
> thing and don't see an obvious way to use bash-completion in zsh.

Just source the bash script:
http://git.kernel.org/?p=3Dgit/git.git;a=3Dblob;f=3Dcontrib/completion/=
git-completion.bash

Alternatively you can use my wrapper that works better than zsh's bash
completion[1], but you still need the bash script anyway.

Cheers.

[1] https://github.com/felipec/git-zsh/blob/master/git-completion.zsh

--=20
=46elipe Contreras
