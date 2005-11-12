From: Andreas Ericsson <ae@op5.se>
Subject: Re: Remove unneeded packs
Date: Sat, 12 Nov 2005 14:13:36 +0100
Message-ID: <4375EA80.7070405@op5.se>
References: <1131800663.29461.11.camel@blade>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Nov 12 14:15:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EavCY-0005Ul-Ix
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 14:13:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbVKLNNi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 12 Nov 2005 08:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbVKLNNi
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 08:13:38 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:25525 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932259AbVKLNNi
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2005 08:13:38 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id EB70D6BD02
	for <git@vger.kernel.org>; Sat, 12 Nov 2005 14:13:36 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <1131800663.29461.11.camel@blade>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11684>

Marcel Holtmann wrote:
> Hi guys,
>=20
> every time Linus re-creates the pack for his linux-2.6 tree, I end up
> with another pack. I use HTTP as transport and thus the new pack will=
 be
> download (which is almost 100 MB), but that is fine. However it seems
> that the old (previous) pack will never be deleted. For the no longer
> needed object files I can use git-prune-packed, but the old pack I ha=
ve
> to identify and delete by myself. Exists an easy and nice way to get =
rid
> of old unneeded packs? Can't git-prune-packed also do this job?
>=20

A patchset was posted to the list 2005-11-09 by Lukas Sandstr=F6m, addi=
ng=20
"git-pack-intersect" which was subsequently renamed to the more=20
appropriate "git-pack-redundant".

If I remember the commit messages and understand your question correctl=
y=20
it does what you want.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
