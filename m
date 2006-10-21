From: "=?ISO-8859-1?Q?Erik_B=E5gfors?=" <zindar@gmail.com>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 10:48:25 +0200
Message-ID: <845b6e870610210148l1337fc06n238eca0a2f382d0b@mail.gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<200610171030.35854.jnareb@gmail.com> <vpqejt76vgz.fsf@ecrins.imag.fr>
	<200610171345.32313.jnareb@gmail.com>
	<20061017080702.615a3b2f.seanlkml__27953.817000571$1161408618$gmane$org@sympatico.ca>
	<ehclkf$v3e$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: bazaar-ng-bounces@lists.canonical.com Sat Oct 21 10:57:23 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbCfN-0005Cj-Og
	for gcvbg-bazaar-ng@m.gmane.org; Sat, 21 Oct 2006 10:57:17 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GbCfG-0001h0-Id; Sat, 21 Oct 2006 09:57:10 +0100
Received: from py-out-1112.google.com ([64.233.166.176])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <zindar@gmail.com>) id 1GbCeT-0001f5-T2
	for bazaar-ng@lists.canonical.com; Sat, 21 Oct 2006 09:56:22 +0100
Received: by py-out-1112.google.com with SMTP id f25so53783pyf
	for <bazaar-ng@lists.canonical.com>;
	Sat, 21 Oct 2006 01:56:20 -0700 (PDT)
Received: by 10.35.115.18 with SMTP id s18mr2315809pym;
	Sat, 21 Oct 2006 01:48:25 -0700 (PDT)
Received: by 10.35.116.4 with HTTP; Sat, 21 Oct 2006 01:48:25 -0700 (PDT)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <ehclkf$v3e$1@sea.gmane.org>
Content-Disposition: inline
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29595>

On 10/21/06, Jakub Narebski <jnareb@gmail.com> wrote:
> Sean wrote:
>
> > On Tue, 17 Oct 2006 13:45:31 +0200
> > Jakub Narebski <jnareb@gmail.com> wrote:
> >
> >> Git cannot do that remotely (with exception of git-tar-tree/git-archive
> >> which has --remote option), yet. But you can get contents of a file
> >> (with "git cat-file -p [<revision>:|:<stage>:]<filename>"), list
> >> directory (with "git ls-tree <tree-ish>") and compare files or
> >> directories (git diff family of commands) without need for working
> >> directory.
> >
> > Interesting, I didn't know about the --remote option.  So in fact as long
> > as the remote has enabled upload-tar then anyone can do a "light
> > checkout".
>
> Not exactly. "Light checkout" (aka "lazy one-branch clone") in bzr
> contains also info about the repository it came from, and has some
> metadata that you can commit to it locally. git tar-tree --remote
> just gets snapshot.

No, a lightweight checkout doesn't have that.  A lightweight checkout
is basically just the latest revision checked out, a snapshot. For
everything else it needs to go the remote branch to get information.
You cannot commit locally on a "lightwieght checkout"

A "normal/heavyweight" checkout has the ability to commit locally.

/Erik
