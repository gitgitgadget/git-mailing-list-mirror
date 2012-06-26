From: Kevin <ikke@ikke.info>
Subject: Re: Urgent: Issue with GIT ...
Date: Tue, 26 Jun 2012 08:08:26 +0200
Message-ID: <CAO54GHA=R1CyspFrC1n-JLVbm5eE+roXLBv6hFL5M1BHGAcVBA@mail.gmail.com>
References: <1340624980925-7562097.post@n2.nabble.com> <slrnjugobd.8ie.andy@atom.gently.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andy Hawkins <andy@gently.org.uk>
X-From: git-owner@vger.kernel.org Tue Jun 26 08:08:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjOxI-00012v-V7
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 08:08:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758058Ab2FZGIt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jun 2012 02:08:49 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:60443 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757942Ab2FZGIs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jun 2012 02:08:48 -0400
Received: by wgbdr13 with SMTP id dr13so4857074wgb.1
        for <git@vger.kernel.org>; Mon, 25 Jun 2012 23:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=R3BbSfMA0BMcFovykNJq1NcQKe8zz1XceD9CgufWxC4=;
        b=x9V3Kfc0omZjRcS8Oybf4uOhPxxnmeGsbw7t4QmAlZbpVudFQAjF1L8LboZTd+iBCL
         hzd0/DWzoeJCD4OtIOmrHq7wk3gTjOpJxTulQp1krlWmwPGEAk6nRyzDOXq3k6oq1aX+
         R4JBz6eNm59LMEnw7eE2t5fO/EuB90K/Q9U4XkIuEFA6nCxTNgfbxNmdJ/hNql4grnvU
         MbNA4mE7B+DYEVc0P8135Wc7fYoJ2auArSwAPEzJs7pxJw42RxNyl5dDAIXXkotKcVnm
         4iNuZdFKpJADrs1mftq8UR6n52kp9l54FVRRkQ371Hc9WmI8jtUMeVvnV2o5KAfK6xjE
         EZHA==
Received: by 10.216.143.195 with SMTP id l45mr7842280wej.49.1340690926981;
 Mon, 25 Jun 2012 23:08:46 -0700 (PDT)
Received: by 10.227.35.202 with HTTP; Mon, 25 Jun 2012 23:08:26 -0700 (PDT)
In-Reply-To: <slrnjugobd.8ie.andy@atom.gently.org.uk>
X-Google-Sender-Auth: _828HnDYRvh25UPYyLTpjk4Htyo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200632>

The difference between bare and non-bare repositories is explained here=
 [1].

In this setup, you should only pull from both repositories, not push to=
 the
other repository. If you want to push things, you should use a bare rep=
ository
that both repositories can access and push to.

[1]: http://bare-vs-nonbare.gitrecipes.de/



On Mon, Jun 25, 2012 at 3:02 PM, Andy Hawkins <andy@gently.org.uk> wrot=
e:
>
> Hi,
>
> In article <1340624980925-7562097.post@n2.nabble.com>,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 guruprasad<guruprasadkinI@gmail.co=
m> wrote:
> > 5) If i do some changes to files in B, commit and push to remote br=
anch,
> > I
> > am unable to pull the changes done and merge into A. I have set
> > "receive.denycurrentbranch=3Dignore" in git config.
>
> Sounds like you're trying to push into a remote non-bare repository.
>
> What I'd do is:
>
> 1. On 'A', create a bare repository.
> 2. Somewhere else on 'A', clone this repository. Work and push to the=
 bare
> in step 1 when necessary.
> 3. On 'B', also clone the repository from 1. Work and push to the bar=
e
> when
> necessary.
>
> I don't think it's a good idea to push to a repository that has check=
ed
> out
> files. I seem to remember this being mentioned in Pro Git.
>
> Andy
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
