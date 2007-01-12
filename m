From: Stelian Pop <stelian@popies.net>
Subject: Re: [PATCH] Add hg-to-git conversion utility.
Date: Sat, 13 Jan 2007 00:00:56 +0100
Message-ID: <45A81328.9030109@popies.net>
References: <1168537766.22649.19.camel@localhost.localdomain> <eo8ngk$ja$1@sea.gmane.org> <1168632860.29218.5.camel@voyager.dsnet> <1168639023.13640.2.camel@localhost.localdomain> <20070112221525.GA20956@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 13 00:01:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5VOR-0001Nm-Ct
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 00:01:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161162AbXALXBA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 12 Jan 2007 18:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161161AbXALXBA
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 18:01:00 -0500
Received: from sd291.sivit.org ([194.146.225.122]:1807 "EHLO sd291.sivit.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161162AbXALXA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 18:00:59 -0500
Received: from [192.168.6.104] (deep-space-9.popies.net [82.225.86.56])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sd291.sivit.org (Postfix) with ESMTP id 03B2658122;
	Sat, 13 Jan 2007 00:00:57 +0100 (CET)
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070112221525.GA20956@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36724>

Shawn O. Pearce a =E9crit :
> Stelian Pop <stelian@popies.net> wrote:
>> hg-to-git.py  is able to convert a Mercurial repository into a git o=
ne,
>> and preserves the branches in the process (unlike tailor)
>=20
> Cool!
>=20
> You've already written the converter, but you may want to look at
> using git-fast-import as the backend interface to Git.  I think
> your code may come out shorter, be clearer, and will run faster.
[...]
> Post 1.5.0 I'm going to nudge Junio to get gfi added to the main
> git.git repository.  (Right now I don't want to distract him from
> the release.)

Rebasing hg-to-git.py on gfi will probably be a very good idea once gfi=
=20
is in the tree.

But I wrote this since I had a need for it, and once my repositories=20
converted to git I'm not sure I'll need it again :) So don't count too=20
much on me to do this rebasing :)

But who knows, on a cold rainy day...

--=20
Stelian Pop <stelian@popies.net>
