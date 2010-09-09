From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: git rebase --preserve-merges seems to not work
Date: Thu, 09 Sep 2010 00:26:42 -0600
Message-ID: <4C887E22.5050303@workspacewhiz.com>
References: <4C886DF3.8050903@workspacewhiz.com> <20100909055104.GA21004@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Steinert <hachi@kuiki.net>
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 09 08:26:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Otaaw-0001QA-IQ
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 08:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753311Ab0IIG0o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Sep 2010 02:26:44 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:47031 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058Ab0IIG0n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 02:26:43 -0400
Received: (qmail 25881 invoked by uid 399); 9 Sep 2010 00:26:43 -0600
Received: from unknown (HELO ?192.168.1.100?) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAM; 9 Sep 2010 00:26:43 -0600
X-Originating-IP: 76.27.116.215
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.8) Gecko/20100802 Lightning/1.0b2 Thunderbird/3.1.2
In-Reply-To: <20100909055104.GA21004@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155846>

  ----- Original Message -----
=46rom: Bj=F6rn Steinbrink
Date: 9/8/2010 11:51 PM
>> $ git lg --all
>> * 2c93a8a - (HEAD) c (11 seconds ago)
>> * 2b98bc6 - b (11 seconds ago)
>> * 6abf527 - (d) d (3 minutes ago)
>> | *   472fd93 - (bc-merge) Merge commit 'c' into HEAD (74 seconds ag=
o)
>> | |\
>> |/ /
>> | * d132c87 - (c) c (3 minutes ago)
>> | * 4a88fd1 - b (3 minutes ago)
>> |/
>> * b576660 - (a, master) a (4 minutes ago)
> What you actually wanted to replay is just the first-parent history,
> redoing the merges with their respective original second parent.
> Jonathan (Cc'ed) had the same problem about a month ago.
>
> The "first parent" thing isn't that well defined, criss-cross merges
> combined with some unfortunate fast-forwards will easily make the
> first-parent history become the one that you didn't mean (ask any
> git-svn users that dared to use "git merge" without fully understandi=
ng
> how git-svn uses the history ;-)), but it works in this special case.
> And with that special case in mind (and admittedly probably not think=
ing
> much further) I came up with this patch a few years ago:
>
> http://marc.info/?l=3Dgit&m=3D119379735525213&w=3D2
I hand merged your change in to my Git installation.  There is one part=
=20
of git-rebase--interactive that looks entirely different, so I would=20
need to look back through the history to determine how to properly appl=
y it.

The good news is the patch does exactly what I want in this simple=20
case.  I will have to try it on some more complicated hierarchies to se=
e=20
what the end result is.

It's curious... whenever I ask around about issue X or feature Y, a=20
previously submitted patch can generally be found in the list archives.=
  :)

Josh
