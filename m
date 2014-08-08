From: Mike Stump <mikestump@comcast.net>
Subject: Re: Rebase safely (Re: cherry picking and merge)
Date: Fri, 8 Aug 2014 10:34:43 -0700
Message-ID: <894B9D26-F8C5-4C82-B04C-3B31094C2293@comcast.net>
References: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net> <20140801024329.GA28914@vauxhall.crustytoothpaste.net> <53DBBFE8.8060607@gmail.com> <5AF18A76-DD3B-4B9A-BF70-EFE4BB852C3D@comcast.net> <53DBF4C9.2090905@vilain.net> <4E372CD5-33CA-4AF5-8647-F6BBC64BABA8@comcast.net> <CAK3OfOiG8kzKYRUGZJW90t-DyjWf775MfMDxzin0gw94ATS7nw@mail.gmail.com> <96B703A6-58B0-458A-8A2D-699EA8F1941B@comcast.net> <20140806194457.GD23449@localhost> <A769B84E-42D1-44AC-B0A8-0F4E68AB71FB@comcast.net> <20140807051129.GJ23449@localhost>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>
To: Nico Williams <nico@cryptonector.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 19:35:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFo4b-0000BL-Sa
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 19:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbaHHRfW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Aug 2014 13:35:22 -0400
Received: from qmta03.emeryville.ca.mail.comcast.net ([76.96.30.32]:50306 "EHLO
	qmta03.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750969AbaHHRfV convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Aug 2014 13:35:21 -0400
Received: from omta19.emeryville.ca.mail.comcast.net ([76.96.30.76])
	by qmta03.emeryville.ca.mail.comcast.net with comcast
	id cGbE1o0071eYJf8A3HbM0B; Fri, 08 Aug 2014 17:35:21 +0000
Received: from [IPv6:2001:558:6045:a4:40c6:7199:cd03:b02d] ([IPv6:2001:558:6045:a4:40c6:7199:cd03:b02d])
	by omta19.emeryville.ca.mail.comcast.net with comcast
	id cHbL1o00B2ztT3H01HbLXG; Fri, 08 Aug 2014 17:35:20 +0000
In-Reply-To: <20140807051129.GJ23449@localhost>
X-Mailer: Apple Mail (2.1878.6)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1407519321;
	bh=Pj6tYmI6f46cVip0X3T2siYmHG5RO9ISlcPD66lpzYs=;
	h=Received:Received:Content-Type:Mime-Version:Subject:From:Date:
	 Message-Id:To;
	b=jsTViETWLPoipvCwaMHXO0Gk6s9ujPGCYnVTcnjRYmkbOEUh8i8Yv0zyLRngH/d6i
	 6GW5Gyq+UOz/bW65EsqC41x/iEltiP17PRtZqw/BcsXEPJFCk+YxYot5PeR2+0Z/vI
	 GqtIaVFQaP9wZK7eR5mKtrwM72oX5/QOW5EpJqP/HQq03a3voODLf1CRC7w1ZlbVPp
	 yopYr4w88IEdEJWZSK65zj/POZwvxgDGjsROWvo59ndlvdliMgeppchw/EQcq7XiG7
	 TLMcEIX4aTVU1+ksyqvhumEQrVl507OKksKrwPrISoEREXGjVxpAvm03juDlKWBfAH
	 12ebuSz3ye7SQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255058>

On Aug 6, 2014, at 10:11 PM, Nico Williams <nico@cryptonector.com> wrot=
e:
> Nah.  Sun managed this for decades without a hitch, and for products
> much larger than GCC.  See above.

Ok.  Ah, ok, perfect.  I see how that method of working would cure the =
cherry-pick and merge don=92t work problem mentioned at the top of the =
thread.

> Do some experiments based on the above hardcopy.  If that doesn't
> convince you that it works, oh well, I'll have given it a good try.

Thank you for taking the time to diagram that as it appears to violate =
everyones how to use git guide.   I see the workflow does an onto, whic=
h was the =91fix=92 people talked about on stack overflow, and I see ju=
st how things would work.

If the old master branches are deleted and gc is run, then all the old =
references go away, and then the refs from email and bugzilla then don=92=
t work.  Did you guys ever remove them and then prune (or gc)?

Now, the biggest issue, if that is recognized as `fixing=92 the cherry-=
pick problem, then certainly the problem is understood to be a problem.=
  If one recognized it as a problem, then one can envision cherry-pick =
and merge working together so that the problem doesn=92t need fixing in=
 the first place.  And, if it doesn=92t need fixing, then the cost of t=
he solution isn=92t needed either.  The biggest problem with git, is th=
at two features don=92t work nicely together when they could; in this c=
ase, cherry-pick and merge).  Because they don=92t, it makes it hard fo=
r people to predict what will happen when they use it.  This makes it m=
ore expensive to use and less suitable than a system that is more predi=
ctable.  You improve git, by fixing the problem and making the features=
 work nicely together and making it predicable.

I still favor fixing the underlying problem with cherry-pick and merge =
not working.  :-)  That said, I see how to work around the bug with reb=
ase, if I need to.

I wish the top google hit were your guide and I wish I never saw all th=
e other pages=85  I see now your position, and I see why all the guides=
 are wrong, if you know just how to use rebase.  I wish the git documen=
tation were improved to say as the first sentence under cherry-pick, th=
is feature sucks and doesn=92t really work well, it can cause excess me=
rge conflicts.  rebase can be used to work around the bugs in cherry-pi=
ck for now.  And under rebase, instead of saying what it said now, that=
 how one can can trivially and effortlessly use git, instead of saying,=
 Do not rebase commits that you have pushed to a public repository whic=
h I now see is wrong.