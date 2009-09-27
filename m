From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 7/9] removing eclipse project files
Date: Sun, 27 Sep 2009 21:52:32 +0200
Message-ID: <200909272152.33224.robin.rosenberg.lists@dewire.com>
References: <892492.1652.qm@web27801.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: MatthiasSohn <matthias.sohn@sap.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"spearce@spearce.org" <spearce@spearce.org>
To: Mark Struberg <struberg@yahoo.de>
X-From: git-owner@vger.kernel.org Sun Sep 27 21:52:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mrznd-0005MW-OP
	for gcvg-git-2@lo.gmane.org; Sun, 27 Sep 2009 21:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293AbZI0Twd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Sep 2009 15:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752221AbZI0Twd
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Sep 2009 15:52:33 -0400
Received: from mail.dewire.com ([83.140.172.130]:19772 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751610AbZI0Twc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Sep 2009 15:52:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 08600147D583;
	Sun, 27 Sep 2009 21:52:34 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5ug157d9abM7; Sun, 27 Sep 2009 21:52:34 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 46666147D521;
	Sun, 27 Sep 2009 21:52:34 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <892492.1652.qm@web27801.mail.ukl.yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129219>

l=F6rdag 26 september 2009 22:10:16 skrev Mark Struberg <struberg@yahoo=
=2Ede>:
>=20
> As you already pointed to: we have to clearly separate between settin=
gs stored in the project itself and settings stored in the workspace. T=
he first are by far not all settings needed, the 2nd are not checked in=
 to git anyway. Maybe I didn't  find it yet, but is there an ability to=
 set formatter settings for XML (e.g. Tabs vs spaces policy)? I was onl=
y able to specify this for the whole workspace and not on a per project=
 basis.

Those are workspace settings in the 3.4, not checked 3.,5 yet. You coul=
d add
it to bugzilla as a feature request. All settings should be available a=
s project settings I think.

> And there is a lot more which imho cannot be set for a project. So ch=
ecking in the xml sounds like it is way more powerful isn't? And we wou=
ld have this=20

=46or JGit, not really. Everything that is not project settings should =
be left as the default. The only reason is tool constraints. I'm not we=
ll versed
enough to tell what neatbeans does here.

> feature for a lot non-Eclipse users too (e.g. for Jonas who hacks the=
 nbgit NetBeans plugin based on JGit (again: EGit is a different story!=
)).

I'm not sure keeping netbeans settings would be a problem, but that is
about how much we could do

>=20
> >=20
> > We use 3.3 (well I think the last user dropped it
> > recently), 3.4 and 3.5. I often have to fix up new projects
> > but that is typically a one-time per eclipse project
> > problem. (typically the JRE gets bound to a specific install
> > location).
> >=20
> > The .launch files is another story since they change format
> > all the time.
>=20
> And the profiler settings, and and and. It's sad, but the list is lon=
g :(

Yep...

> We can also let the eclipse settings files checked in currently if yo=
u like. But I'd be happy if we continue collecting information and then=
 make a decision.

I definitely think we should keep them until we find an alternate solut=
ion. The
projects settings are way too useful to be thrown out.

-- robin
