From: Petr Baudis <pasky@suse.cz>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 00:58:03 +0200
Message-ID: <20061020225803.GM20017@pasky.or.cz>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<200610201517.26702.jnareb@gmail.com>
	<a7e835d40610200759h49859a20k8a409fe34f68630a@mail.gmail.com>
	<200610210050.32254.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Henstridge <james@jamesh.id.au>, bazaar-ng@lists.canonical.com,
	Linus Torvalds <torvalds@osdl.org>, Andreas Ericsson <ae@op5.se>,
	Carl Worth <cworth@cworth.org>, git@vger.kernel.org
X-From: bazaar-ng-bounces@lists.canonical.com Sat Oct 21 00:58:22 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb3Jf-0003v1-LM
	for gcvbg-bazaar-ng@m.gmane.org; Sat, 21 Oct 2006 00:58:15 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1Gb3JV-0003Jq-Q6; Fri, 20 Oct 2006 23:58:06 +0100
Received: from w241.dkm.cz ([62.24.88.241] helo=machine.or.cz)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <pasky@machine.or.cz>) id 1Gb3JU-0003Jg-0o
	for bazaar-ng@lists.canonical.com; Fri, 20 Oct 2006 23:58:04 +0100
Received: (qmail 19277 invoked by uid 2001); 21 Oct 2006 00:58:03 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <200610210050.32254.jnareb@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29550>

Dear diary, on Sat, Oct 21, 2006 at 12:50:31AM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> P.S. what Git lacks at least now is a way to generate diff between
> two different local repositories, but you can always setup alternates
> file and fetch the other repository into some tag.

It's not exactly convenient, but you can do

	xpasky@machine[0:0]~/git$ GIT_ALTERNATE_OBJECT_DIRECTORIES=../cogito/.git/objects cg-diff -r `GIT_DIR=../cogito/.git cg-object-id -c HEAD`..HEAD

I don't personally think it's worth a special UI, but there're no
boundaries for initiative... :-)
