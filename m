From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 20 Oct 2006 13:21:25 -0400
Message-ID: <20061020172125.GF18019@spearce.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<ehao3e$2qv$1@sea.gmane.org> <4538EC8F.7020502@utoronto.ca>
	<200610201821.34712.jnareb@gmail.com>
	<45390168.6020502@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: bazaar-ng-bounces@lists.canonical.com Fri Oct 20 19:21:47 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gay41-0000Uz-MQ
	for gcvbg-bazaar-ng@m.gmane.org; Fri, 20 Oct 2006 19:21:45 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1Gay40-0001nB-A3; Fri, 20 Oct 2006 18:21:44 +0100
Received: from corvette.plexpod.net ([64.38.20.226])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <spearce@spearce.org>) id 1Gay3l-0001lJ-RP
	for bazaar-ng@lists.canonical.com; Fri, 20 Oct 2006 18:21:32 +0100
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
	helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gay3c-0001tX-Rc; Fri, 20 Oct 2006 13:21:20 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 077D320FB79; Fri, 20 Oct 2006 13:21:26 -0400 (EDT)
To: Aaron Bentley <aaron.bentley@utoronto.ca>
Content-Disposition: inline
In-Reply-To: <45390168.6020502@utoronto.ca>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - lists.canonical.com
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29507>

Aaron Bentley <aaron.bentley@utoronto.ca> wrote:
> Jakub Narebski wrote:
> > Gaaah, so rename detection in bzr is done using file-ids?
> > Linus will tell you the inherent problems with that "solution".
> 
> All solutions have disadvantages.  We prefer the disadvantages that come
> from using file-ids over the disadvantages that come from using
> content-based rename detection.

As good as the content based rename detection is I got burned
recently by it.

I renamed hundreds of small files in one shot and also did a few
hundered adds and deletes of other small XML files.  Git generated
a lot of those unrelated adds/deletes as rename/modifies, as their
content was very similiar.  Some people involved in the project
freaked as the files actually had nothing in common with one
another... except for a lot of XML elements (as they shared the
same DTD).
