From: "George Dennie" <gdennie@pospeople.com>
Subject: RE: Hey - A Conceptual Simplication....
Date: Thu, 19 Nov 2009 15:12:35 -0500
Message-ID: <00d401ca6954$a29fa020$e7dee060$@com>
References: <005a01ca684e$71a1d710$54e58530$@com> <20091118142512.1313744e@perceptron> <008401ca6880$33d7e550$9b87aff0$@com> <m37htnd3kb.fsf@localhost.localdomain> <31e9dd080911181152h665d5d9dr5c0736c0ca3234c1@mail.gmail.com> <009401ca68bc$7e4b12b0$7ae13810$@com> <20091119074226.GA23304@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <B.Steinbrink@gmx.de>, "'Jason Sewall'" <jasonsewall@gmail.com>,
	"'Jakub Narebski'" <jnareb@gmail.com>,
	=?iso-8859-1?Q?'Jan_Kr=FCger'?= <jk@jk.gs>, <torvalds@osdl.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 19 21:12:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBDMw-0002mn-0A
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 21:12:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754411AbZKSUMb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Nov 2009 15:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754203AbZKSUMa
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 15:12:30 -0500
Received: from smtp107.rog.mail.re2.yahoo.com ([68.142.225.205]:30216 "HELO
	smtp107.rog.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754083AbZKSUMa convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 15:12:30 -0500
Received: (qmail 71454 invoked from network); 19 Nov 2009 20:12:35 -0000
Received: from CPE001cf04d66c9-CM0012c9a0913a.cpe.net.cable.rogers.com (gdennie@99.244.179.211 with login)
        by smtp107.rog.mail.re2.yahoo.com with SMTP; 19 Nov 2009 12:12:35 -0800 PST
X-Yahoo-SMTP: zge3jO.swBAK2Pj1ZBh8nVciRpiiK2CUUeAJch.zCNP5zAk-
X-YMail-OSG: ElDR7NUVM1k_ge6MsVpdl_apbe.hpS73tbg06ze7WQgnWM3_SYRcltSVMHZ7rUasJg--
X-Yahoo-Newman-Property: ymail-3
In-Reply-To: <20091119074226.GA23304@atjola.homenet>
X-Mailer: Microsoft Office Outlook 12.0
thread-index: Acpo76blr9W/aHqeTcmq62gpDZzGiAAH2n+w
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133253>

Thanks Jakub Narebski and Bj=F6rn Steinbrink...Nice description Bj=F6rn=
=2E

I think an important piece of conceptual information missing from the d=
ocs
is a concise list of the conceptual properties defining the context of =
the
working tree, index, and repository during normal use. This itemization
would go far in explaining the synergies between the various commands.=20

=46unctionally, all the commands merely manipulate these properties. If=
 these
properties were summarize in context one would expect that would repres=
ent a
very complete functional model of Git. A user could review the descript=
ion
figure what they wanted to do and then find the command(s) to accomplis=
h it.


Presently this knowledge is accreted over time as oppose to merely bein=
g
read and in the space of a few minutes "groked" (of course it could be =
that
I am particularly limited :).

=46or example, towards a functional model, is this close? (note: all
properties can be blank/empty)...

REPOSITORIES
	Collection of Commits
	Collection of Branches
		-- collection of commits without children
		-- as a result each commits either augments
		-- and existing branch or creates a new one
	Master Branch
		-- typically the publishable development history

INDEX
	Collections of Parent/Merge Commits
		-- the commit will use all these as its parent

	Staged Commit=20
		-- these changes are shown relative to the working tree

	Default Branch
		-- the history the staged commit is suppose to augment

	Collection of Stashes
		-- these are not copies of the working tree since they
		-- only contain "versioned" files/folders and so is not
		-- a backup

WORKING_TREE
	Collection of Files and Folders
=09

As far as I can tell, the working tree is not suppose to be stateful, b=
ut it
seems the commands treat it as such.

What is interesting is that branches serve to encourage a serialized vi=
ew of
commits. More than structure, they are like books in a library narratin=
g a
development story. Consequently, and interestingly, they are as much th=
e
purpose of the repository as the commits they organize...which is
interesting.


Again, thanks for your patients.

George.
