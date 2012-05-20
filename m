From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [1.8.0] use 'stage' term consistently
Date: Sun, 20 May 2012 13:06:06 -0500
Message-ID: <20120520180606.GC3000@burratino>
References: <CAMP44s1qqpTxRvjEH32MNqzUeNhgZ1gB+fu=cgvxnSbMB6oBGA@mail.gmail.com>
 <vpqehqxmwpj.fsf@bauges.imag.fr>
 <CAMP44s2DU_3UnHxhgwsTVT59KjLi0+=iW7utuofEyis+_06jGA@mail.gmail.com>
 <CACBZZX4_wjFG4D4_2w8UcvbRwBmJ583QpoP_n-tq+dNds3Bi7Q@mail.gmail.com>
 <7v1umv7ub0.fsf@alter.siamese.dyndns.org>
 <CAHREChgTHZL0sNJ3TkZOL7x4k9x=4GRhrZ6Gm0W+Ai_UnX2FEg@mail.gmail.com>
 <20120519060031.GB23799@burratino>
 <20120519063208.GA24556@burratino>
 <CAMP44s2bbJLgqOdi49jS34E79EvNtRifpCbDE_bQUys+3xrs3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Lodato <lodatom@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Scott Chacon <schacon@gmail.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 20 20:06:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWAWo-0003Se-Ks
	for gcvg-git-2@plane.gmane.org; Sun, 20 May 2012 20:06:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756648Ab2ETSGP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 May 2012 14:06:15 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:45153 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755476Ab2ETSGO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 May 2012 14:06:14 -0400
Received: by yenm10 with SMTP id m10so3837130yen.19
        for <git@vger.kernel.org>; Sun, 20 May 2012 11:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=otDjMezO5IJO2+/BVhKkU7hVpQc5Lh2vpd3ejx2U3zA=;
        b=OhGfGIJzv87Byt+6Mgrdu9o7zLLqN/sJHqg+6yF/R17WoeJdGa1bkTSWsYQlNw14g4
         96FP4Cjr2uFBRa0SI//4zH4P5RpsG1Ku/j7I3bqcP6X4gV7nq2Ujutn1AoPz/Kyx3BgN
         yqtae65XaNy/kchXJFDWMBDvMqCFyPuleCYb+jq3wyECNkXr1ZfP7H3CnItxgLhoipTY
         sK4U3NugvSdqnfWtzAjglIRyz1uvb9sQijjemAfvQVlOSUylW9gE3UY+k9Smn5Jb+vQU
         oelEOBWR59dfShkhRzgt06zxwm3qPY/DA9jtrlq0ODX5B1/pqHUrs+QycnJeBnQNbPlO
         P/wg==
Received: by 10.42.141.133 with SMTP id o5mr10938543icu.13.1337537174045;
        Sun, 20 May 2012 11:06:14 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id gw4sm9834116igb.6.2012.05.20.11.06.08
        (version=SSLv3 cipher=OTHER);
        Sun, 20 May 2012 11:06:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s2bbJLgqOdi49jS34E79EvNtRifpCbDE_bQUys+3xrs3w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198066>

=46elipe Contreras wrote:
> On Sat, May 19, 2012 at 8:32 AM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:

>> =C2=A0 =C2=A0 =C2=A0 =C2=A0git stage --add <paths>; # stage an addit=
ion
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0git stage --remove <paths>; # stage a rem=
oval
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0git stage --edit <paths>; # edit the stag=
ed content
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0git stage --apply <patch>; # stage the de=
scribed change
>>
>> These would be commands that modify the index without touching the
>> worktree.
>
> If they are commands, why do they start with --?

They are commands because they are passed on the command line.  I don't
care strongly about the details --- I was giving an idea for people to
pick up or not pick up.

[...]
>> Maybe:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0git apply --index=3D(yes | no | only)
[...]
> 'index'? That goes contrary to this request; the term 'index' should
> be avoided in porcelain commands. s/index/stage/ and the proposal
> seems sensible, but I fail to see how --stage=3Dno could be helpful

It is 'index' because the command already has an option with that
name, which makes this more discoverable and less confusing to
existing users.  You can like or not like that choice.

How do you negate the "also stage this change for the next commit"
option passed earlier on the command line?

I also don't care about the details here and wish you had phrased your
critique in terms of an alternate proposal instead of asking me to
defend mine.  The only part I actually care about is that a person
should think carefully about individual changes, in isolation, that
improve git and move towards a more pleasant and consistent interface.

I don't see any reason for a flag day.

Hope that helps,
Jonathan
