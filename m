From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: cvs import
Date: Thu, 14 Sep 2006 19:01:20 +0200
Message-ID: <45098AE0.6030409@alum.mit.edu>
References: <45084400.1090906@bluegap.ch>	<9e4733910609131201q7f583029r72dac66cd0dd098f@mail.gmail.com>	<46a038f90609131341se42b2dcne73c017cf757d13a@mail.gmail.com>	<450872AE.5050409@bluegap.ch>	<9e4733910609131438n686b6d72u4d5799533c7473d7@mail.gmail.com>	<4508EA78.5030001@alum.mit.edu>
	<20060914155003.GB9657@spearce.org>	<eebuih$u32$1@sea.gmane.org>
	<9e4733910609140927y30ecaa42wae0ff0597b8c3842@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: monotone-devel@nongnu.org, dev@rapidsvn.tigris.org, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org Thu Sep 14 19:01:35 2006
Return-path: <monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org>
Envelope-to: gcvmd-monotone-devel@m.gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNuai-0003qR-Vo
	for gcvmd-monotone-devel@m.gmane.org; Thu, 14 Sep 2006 19:01:33 +0200
Received: from localhost ([127.0.0.1] helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1GNuai-00009h-Lq
	for gcvmd-monotone-devel@m.gmane.org; Thu, 14 Sep 2006 13:01:32 -0400
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1GNuae-00009S-O3
	for monotone-devel@nongnu.org; Thu, 14 Sep 2006 13:01:28 -0400
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1GNuad-00009G-9y
	for monotone-devel@nongnu.org; Thu, 14 Sep 2006 13:01:28 -0400
Received: from [199.232.76.173] (helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1GNuad-00009D-74
	for monotone-devel@nongnu.org; Thu, 14 Sep 2006 13:01:27 -0400
Received: from [192.109.42.8] (helo=einhorn.in-berlin.de)
	by monty-python.gnu.org with esmtps
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32) (Exim 4.52) id 1GNucb-00036T-SI
	for monotone-devel@nongnu.org; Thu, 14 Sep 2006 13:03:30 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.135] (kaiserty.in-dsl.de [217.197.85.174])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id
	k8EH1LDr011172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 14 Sep 2006 19:01:22 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US;
	rv:1.8.0.5) Gecko/20060728 Thunderbird/1.5.0.5 Mnenhy/0.7.4.666
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910609140927y30ecaa42wae0ff0597b8c3842@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
X-BeenThere: monotone-devel@nongnu.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: developer discussion for monotone <monotone-devel.nongnu.org>
List-Unsubscribe: <http://lists.nongnu.org/mailman/listinfo/monotone-devel>,
	<mailto:monotone-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/pipermail/monotone-devel>
List-Post: <mailto:monotone-devel@nongnu.org>
List-Help: <mailto:monotone-devel-request@nongnu.org?subject=help>
List-Subscribe: <http://lists.nongnu.org/mailman/listinfo/monotone-devel>,
	<mailto:monotone-devel-request@nongnu.org?subject=subscribe>
Sender: monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org
Errors-To: monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27013>

Jon Smirl wrote:
> On 9/14/06, Jakub Narebski <jnareb@gmail.com> wrote:
>> Shawn Pearce wrote:
>>
>> > Originally I wanted Jon Smirl to modify the cvs2svn (...)
>>
>> By the way, will cvs2git (modified cvs2svn) and git-fast-import publicly
>> available?
> 
> It has some unresolved problems so I wasn't spreading it around everywhere.
> 
> It is based on cvs2svn from August. There has been too much change to
> the current cvs2svn to merge it anymore. [...]
> 
> If the repo is missing branch tags cvs2svn may turn a single missing
> branch into hundreds of branches. The Mozilla repo has about 1000
> extra branches because of this.

[To explain to our studio audience:] Currently, if there is an actual
branch in CVS but no symbol associated with it, cvs2svn generates branch
labels like "unlabeled-1.2.3", where "1.2.3" is the branch revision
number in CVS for the particular file.  The problem is that the branch
revision numbers for files in the same logical branch are usually
different.  That is why many extra branches are generated.

Such unnamed branches cannot reasonably be accessed via CVS anyway, and
somebody probably made the conscious decision to delete the branch from
CVS (though without doing it correctly).  Therefore such revisions are
probably garbage.  It would be easy to add an option to discard such
revisions, and we should probably do so.  (In fact, they can already be
excluded with "--exclude=unlabeled-.*".)  The only caveat is that it is
possible for other, named branches to sprout from an unnamed branch.  In
this case either the second branch would have to be excluded too, or the
unlabeled branch would have to be included.

Alternatively, there was a suggestion to add heuristics to guess which
files' "unlabeled" branches actually belong in the same original branch.
 This would be a lot of work, and the result would never be very
accurate (for one thing, there is no evidence of the branch whatsoever
in files that had no commits on the branch).

Other ideas are welcome.

Michael
