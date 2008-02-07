From: Rene Herman <rene.herman@keyaccess.nl>
Subject: GIT submodules
Date: Thu, 07 Feb 2008 22:24:44 +0100
Message-ID: <47AB771C.8020402@keyaccess.nl>
References: <s5hwspjzbt0.wl%tiwai@suse.de>	<Pine.LNX.4.61.0802061437190.8113@tm8103.perex-int.cz>	<Pine.LNX.4.61.0802061505470.8113@tm8103.perex-int.cz>	<47AA1361.7070201@keyaccess.nl>
	<s5h7ihhknez.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: ALSA development <alsa-devel@alsa-project.org>, git@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
X-From: alsa-devel-bounces@alsa-project.org Thu Feb 07 22:24:15 2008
Return-path: <alsa-devel-bounces@alsa-project.org>
Envelope-to: glad-alsa-devel-2@m.gmane.org
Received: from alsa0.perex.cz ([212.20.107.51])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNEE2-0004pQ-72
	for glad-alsa-devel-2@m.gmane.org; Thu, 07 Feb 2008 22:24:06 +0100
Received: by alsa0.perex.cz (Postfix, from userid 1000)
	id 6F78B2465F; Thu,  7 Feb 2008 22:23:37 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.8 (2007-02-13) on
	alsa0.alsa-project.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=disabled
	version=3.1.8
Received: from alsa0.perex.cz (localhost [127.0.0.1])
	by alsa0.perex.cz (Postfix) with ESMTP id 353F024656;
	Thu,  7 Feb 2008 22:23:33 +0100 (CET)
X-Original-To: alsa-devel@alsa-project.org
Delivered-To: alsa-devel@alsa-project.org
Received: by alsa0.perex.cz (Postfix, from userid 1000)
	id 7DBB324658; Thu,  7 Feb 2008 22:23:31 +0100 (CET)
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 14DAC24655
	for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2008 22:23:28 +0100 (CET)
Received: from [213.51.146.188] (port=38915 helo=smtp3.tilbu1.nb.home.nl)
	by smtpq1.tilbu1.nb.home.nl with esmtp (Exim 4.60)
	(envelope-from <rene.herman@keyaccess.nl>)
	id 1JNEDP-0004SG-1L; Thu, 07 Feb 2008 22:23:27 +0100
Received: from cc334381-b.groni1.gr.home.nl ([82.73.12.33]:36581
	helo=[192.168.0.3]) by smtp3.tilbu1.nb.home.nl with esmtp (Exim 4.60)
	(envelope-from <rene.herman@keyaccess.nl>)
	id 1JNEDO-00076Y-5P; Thu, 07 Feb 2008 22:23:26 +0100
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <s5h7ihhknez.wl%tiwai@suse.de>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
	http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73003>

On 07-02-08 12:37, Takashi Iwai wrote:

(sorry, that's not git-devel@, but simply git@)

>> I believe the git submodule stuff would also nicely allow all of ALSA to be 
>> one giant repo basically, with kernel, lib, ..., as submodules.
> 
> Just out of curiosity, what could be a merit of submodules in the case
> of ALSA?

Given that they're used for larger projects, I can't say I've used them but
I read about them when Linus mentioned them in the context of KDE maybe
switching:

http://lwn.net/Articles/246381/

Basically, submodules are the  actual git repositories with one organizing
superproject. This seems to be a fairly nice description of the submodule
support:

http://www.ishlif.org/blog/linux/git-submodules/

What they provide is stitching the parts together nicely into one coherent
release. In this case, you'd have alsa-driver, alsa-lib, alsa-utils and so
on repos, and an "alsa-project" superproject tying them together, where you
could do checkouts of a complete coherent release off all the modules for
example.

As said, I haven't actually used them, so I've added the git list (*) to see
if anyone has something to add, correct or explain (please do!). Submodules
seem to be intended exactly for the kind of setup that ALSA is using with
the many semi-independent parts...

(*) git list: alsa-devel is moderated for non-subscribers but you'll be
whitelisted after landing in the queue once if you're not a subscriber

Rene.
