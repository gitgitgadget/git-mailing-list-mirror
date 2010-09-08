From: Chris Hoogendyk <hoogendyk@bio.umass.edu>
Subject: Re: building git on Solaris
Date: Wed, 08 Sep 2010 10:46:55 -0400
Message-ID: <4C87A1DF.1020706@bio.umass.edu>
References: <4C86A86B.1030107@bio.umass.edu> <AANLkTikvy-wUB-RFLegp7KJa_srqh97nLC03bdZDmru=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git mailing list <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 08 16:47:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtLvU-0001qI-I8
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 16:47:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682Ab0IHOq7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Sep 2010 10:46:59 -0400
Received: from marlin.bio.umass.edu ([128.119.55.19]:64387 "EHLO
	marlin.bio.umass.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486Ab0IHOq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 10:46:58 -0400
Received: from peredhil.bio.umass.edu (peredhil.bio.umass.edu [128.119.54.86])
	(authenticated bits=0)
	by marlin.bio.umass.edu (8.14.4/8.14.4) with ESMTP id o88EktCA018052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 8 Sep 2010 10:46:55 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.24 (Macintosh/20100228)
In-Reply-To: <AANLkTikvy-wUB-RFLegp7KJa_srqh97nLC03bdZDmru=@mail.gmail.com>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.6 (marlin.bio.umass.edu [128.119.55.19]); Wed, 08 Sep 2010 10:46:56 -0400 (EDT)
X-Scanned-By: MIMEDefang 2.68 on 128.119.55.19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155789>



=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Tue, Sep 7, 2010 at 21:02, Chris Hoogendyk <hoogendyk@bio.umass.ed=
u> wrote:
>  =20
>> Does anyone have any guidance or clues as to where I should look fro=
m here?
>> Or how to fix this?
>>    =20
>
> Call make as gmake?

magical.

I did an `ln -s /usr/local/bin/make /usr/local/bin/gmake` and then=20
referenced gmake rather than make. For some reason, that got over the=20
hump. I have no clue why calling make would initially work and later in=
=20
the process revert to /usr/ccs/bin/make, but calling the same code via=20
the symlink name gmake works.

Anyway, now I'm in the normal build debugging mode. Got all the way=20
through to building the Documentation, at which stage I now need to get=
=20
asciidoc and python. I don't really like bloating my minimal server=20
systems with python, but it seems I'm finally stuck, since I have=20
faculty who really want to use git.

Thanks for the clue.


--=20
---------------

Chris Hoogendyk

-
   O__  ---- Systems Administrator
  c/ /'_ --- Biology & Geology Departments
 (*) \(*) -- 140 Morrill Science Center
~~~~~~~~~~ - University of Massachusetts, Amherst=20

<hoogendyk@bio.umass.edu>

---------------=20

Erd=C3=B6s 4
