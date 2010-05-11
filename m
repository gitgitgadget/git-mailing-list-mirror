From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git branch descriptions
Date: Tue, 11 May 2010 09:44:31 +0200
Message-ID: <4BE90ADF.7020503@drmicha.warpmail.net>
References: <657A681BEF27534399890012B8C8E50E1AD63D1FEA@lcs-exchange01.Lantekcs.com> <20100510232612.GA6890@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joel Reed <jreed@lantekcs.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 11 09:44:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBk8n-0008Gi-Db
	for gcvg-git-2@lo.gmane.org; Tue, 11 May 2010 09:44:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647Ab0EKHo2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 May 2010 03:44:28 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57877 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751657Ab0EKHo1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 May 2010 03:44:27 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7A7E6F3897;
	Tue, 11 May 2010 03:44:27 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 11 May 2010 03:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=A49HwhYOdEEHRkfyt73xLdpnPG8=; b=OHX60+G6mWlYjld+GdRD33FyK8uBOtrtkfBf/Qg6PbHsp6zjHfZMfMW1mg8zXaX4nt6DlITz00aIUvgLvajWBxRV2jqGNtkfFs5qV8BgbO/aBuxi46O3H/nUKkL3EMat4//Fn+jZH346pQJ1YMClwR5IDoVVQUJNpj4hXT303T4=
X-Sasl-enc: Ov5B8mo9oU1PB+Iq2SKvYyVCy4n/OysdwGw0FtbSF2vm 1273563867
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8082A49A0;
	Tue, 11 May 2010 03:44:26 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100503 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <20100510232612.GA6890@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146878>

Jonathan Nieder venit, vidit, dixit 11.05.2010 01:26:
> Hi,
>=20
> Joel Reed wrote:
>=20
>> Working on a wide range of topics/branches from week to week and
>> project to project, it's sometimes difficult to quickly remember
>> what each branch is about, without doing a git diff master <branch>.
>>  I like to keep branch names short so they're easy to switch to and
>> from, but being able to attach a description that would display when
>> doing a "git branch" would be a huge help.
>=20
> I think the closest thing we have now is =E2=80=98git branch -v=E2=80=
=99, which tells
> the subject of the commit at the tip of the branch.  =E2=80=98git not=
es=E2=80=99
> annotates commits rather than branches, so it occupies a different
> niche.
>=20
> Your request is a reasonable one, and it has come up a few times in
> different forms over the years:
>=20
>  . per-branch descriptions in .git/description[1]
>  . per-branch descriptions in .git/config[2][3]
>  . README branch whose files describe the branches[4]
>=20
> Number [2] is my preferred choice (and comes with code!), for what
> it=E2=80=99s worth.
>=20
> That doesn=E2=80=99t address the problem of how to _share_ branch
> descriptions.  That could be dealt with by extending the wire protoco=
l
> as in [1], I think.  Just sharing a list of branch descriptions is a
> bad idea imho, since related repositories need to be able to name
> their branches independently to avoid painful coordination problems.

I have a mostly working idea (working when done "manually") on how to
use notes for that. As we, know, we can share notes without overriding
our own notes (and improving the merge/combine facilities would benefit
all note users). I'll try to come up with a proof-of-concept patch, but
probably not before next week.

Michael
