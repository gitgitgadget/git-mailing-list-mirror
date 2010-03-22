From: Petr Baudis <pasky@suse.cz>
Subject: Re: rethinking patch management with GIT / topgit
Date: Mon, 22 Mar 2010 20:30:35 +0100
Message-ID: <20100322193035.GM3533@machine.or.cz>
References: <201003201802.51129.thomas@koch.ro>
	<201003201953.34666.thomas@koch.ro>
	<20100321203626.GE3533@machine.or.cz>
	<201003220859.41820.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: vcs-pkg-discuss@lists.alioth.debian.org, git@vger.kernel.org
To: Thomas Koch <thomas@koch.ro>
X-From: vcs-pkg-discuss-bounces+gcpv-vcs-pkg-discuss=m.gmane.org@lists.alioth.debian.org Mon Mar 22 20:30:45 2010
Return-path: <vcs-pkg-discuss-bounces+gcpv-vcs-pkg-discuss=m.gmane.org@lists.alioth.debian.org>
Envelope-to: gcpv-vcs-pkg-discuss@m.gmane.org
Received: from alioth.debian.org ([217.196.43.134])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <vcs-pkg-discuss-bounces+gcpv-vcs-pkg-discuss=m.gmane.org@lists.alioth.debian.org>)
	id 1NtnKm-0001Tw-7I
	for gcpv-vcs-pkg-discuss@m.gmane.org; Mon, 22 Mar 2010 20:30:44 +0100
Received: from localhost ([127.0.0.1] helo=alioth.debian.org)
	by alioth.debian.org with esmtp (Exim 4.69)
	(envelope-from <vcs-pkg-discuss-bounces+gcpv-vcs-pkg-discuss=m.gmane.org@lists.alioth.debian.org>)
	id 1NtnKl-0006pJ-UO
	for gcpv-vcs-pkg-discuss@m.gmane.org; Mon, 22 Mar 2010 19:30:43 +0000
Received: from w241.dkm.cz ([62.24.88.241] helo=machine.or.cz ident=postfix)
	by alioth.debian.org with esmtp (Exim 4.69)
	(envelope-from <pasky@machine.or.cz>) id 1NtnKd-0006oo-Qg
	for vcs-pkg-discuss@lists.alioth.debian.org;
	Mon, 22 Mar 2010 19:30:40 +0000
Received: by machine.or.cz (Postfix, from userid 2001)
	id 506EF86208C; Mon, 22 Mar 2010 20:30:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201003220859.41820.thomas@koch.ro>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-policyd-weight: using cached result; rate:hard: -7.6
X-Spam-ASN: AS6830 62.24.80.0/20
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on alioth.debian.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none shortcircuit=no
	autolearn=failed version=3.2.5
X-BeenThere: vcs-pkg-discuss@lists.alioth.debian.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: Discussions on using VCS for distro packaging
	<vcs-pkg-discuss.lists.alioth.debian.org>
List-Unsubscribe: <http://lists.alioth.debian.org/mailman/options/vcs-pkg-discuss>,
	<mailto:vcs-pkg-discuss-request@lists.alioth.debian.org?subject=unsubscribe>
List-Archive: <http://lists.alioth.debian.org/pipermail/vcs-pkg-discuss>
List-Post: <mailto:vcs-pkg-discuss@lists.alioth.debian.org>
List-Help: <mailto:vcs-pkg-discuss-request@lists.alioth.debian.org?subject=help>
List-Subscribe: <http://lists.alioth.debian.org/mailman/listinfo/vcs-pkg-discuss>,
	<mailto:vcs-pkg-discuss-request@lists.alioth.debian.org?subject=subscribe>
Sender: vcs-pkg-discuss-bounces+gcpv-vcs-pkg-discuss=m.gmane.org@lists.alioth.debian.org
Errors-To: vcs-pkg-discuss-bounces+gcpv-vcs-pkg-discuss=m.gmane.org@lists.alioth.debian.org
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: vcs-pkg-discuss-bounces+gcpv-vcs-pkg-discuss=m.gmane.org@lists.alioth.debian.org
X-SA-Exim-Scanned: No (on alioth.debian.org); SAEximRunCond expanded to false
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142961>

On Mon, Mar 22, 2010 at 08:59:40AM +0100, Thomas Koch wrote:
> In all three cases you're free to either keep or throw away the old patchset.

Yes, but to the same degree e.g. with StGIT I'm free to keep the head of
the old patch series. That does not mean the operation *preserves* the
history, only that the history is still around somewhere in the
repository, however it won't be around in other incarnations of the
repository and it will not be connected in any way to the current
version of the patchset.

Yes, if you are lucky you can figure out the name of the previous
version, but it's like starting development of each new kernel version
by a clean import of the sources.

-- 
				Petr "Pasky" Baudis
http://pasky.or.cz/ | "Ars longa, vita brevis." -- Hippocrates
