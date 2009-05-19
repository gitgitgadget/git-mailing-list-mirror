From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH] tg-graph: print dependency graph like git log 
	--graph
Date: Tue, 19 May 2009 15:51:34 +0200
Message-ID: <36ca99e90905190651tfed03f9ha87ca32b3aee2599@mail.gmail.com>
References: <1242711875-25666-1-git-send-email-bert.wesarg@googlemail.com>
	 <20090519102742.GA28702@noris.de>
	 <36ca99e90905190337y63aeb98ag59ff37688f75ba96@mail.gmail.com>
	 <20090519110800.GB28702@noris.de>
	 <36ca99e90905190448k64ee18afw8abc49bd90ecb58f@mail.gmail.com>
	 <20090519131044.GD28702@noris.de>
	 <36ca99e90905190632q656a5855qe7624902ef82a3da@mail.gmail.com>
	 <20090519133947.GE28702@noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Adam Simpkins <adam@adamsimpkins.net>
To: Michael Radziej <mir@noris.de>
X-From: git-owner@vger.kernel.org Tue May 19 15:51:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6PjN-0007SY-Hu
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 15:51:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545AbZESNvh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 May 2009 09:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752108AbZESNvg
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 09:51:36 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:51449 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbZESNvg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 May 2009 09:51:36 -0400
Received: by fxm2 with SMTP id 2so3886126fxm.37
        for <git@vger.kernel.org>; Tue, 19 May 2009 06:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=umqK7c6AqO2m7juGV0odrQYivbagYdzid+gGsJ6U1H4=;
        b=MN4T1n3Awui1lHXM/5JobG5jJKMclJK4X78SFti8/nCai7KVq1CEPAsSbLN9LqpxRj
         qMHxYbG5VOZX+h8mKa2H+jJ1bTx6UUuTIEFXlj9sMXECHbIR5Ea9ZAXqScvkv7v4YN/G
         cD8lPx3ZJfw+WfbjFpEf/M5qcvueAzkCGSuQg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sVg1W/7zDcM+vGmGXtraKuVkSR7DsWSbNcCDoasbcJRAVezZF6P4DP9V9y7Sy9roLr
         HHID1nv12hOXP3fIAtgltmS2ia6+NhkftI0fnCZvQVwVHT6mD79ct0jyivwYgQy1WFvU
         elc1n54Mdh5jRnZvNWSNM4uLgxCejK6YYTcGs=
Received: by 10.204.50.195 with SMTP id a3mr77516bkg.94.1242741096156; Tue, 19 
	May 2009 06:51:36 -0700 (PDT)
In-Reply-To: <20090519133947.GE28702@noris.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119530>

On Tue, May 19, 2009 at 15:39, Michael Radziej <mir@noris.de> wrote:
> On Tue, May 19, Bert Wesarg wrote:
>
>> On Tue, May 19, 2009 at 15:10, Michael Radziej <mir@noris.de> wrote:
>> > On Tue, May 19, Bert Wesarg wrote:
>> >> And you see the error with all 3?
>> >
>> > Yes
>> >
>> >>
>> >> Can you send the output from 'tg summary --graphviz' too?
>> >
>> > # GraphViz output; pipe to:
>> > # =C2=A0 | dot -Tpng -o <ouput>
>> > # or
>> > # =C2=A0 | dot -Txlib
>> >
>> > digraph G {
>> >
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0graph [
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rankdir =3D=
 "TB"
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0label=3D"To=
pGit Layout\n\n\n"
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fontsize =3D=
 14
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0labelloc=3D=
top
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pad =3D "0.=
5,0.5"
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0];
>> >
>> > \t"t/conflicts" -> "master";
>> > \t"t/python" -> "master";
>> > \t"t/tg-graph" -> "master";
>> > }
>> can you remove the '\t' and pipe the resulting file into this comman=
d
>> inside your topgit work dir:
>>
>> cat "$file" | gvpr -f share/graph.gvpr
>
> Works:
>
> * t/conflicts
> | * t/python
> |/
> | * t/tg-graph
> |/
> * master
>
> (Wow, I had no idea graphviz can produce ASCII art!)
>
> Where's the '\t' from? Is it a result of the "t/" prefix I used for t=
he
> topic branches?
No its just a formating tab to make the output of summary --graphviz ni=
cer ;-)

As martin suggests, you can remove any "\t" from the 'echo' lines in
tg-summary or add a '-e' option to it.

I will probably post tomorrow an updated patch.

Bert
>
> Michael
