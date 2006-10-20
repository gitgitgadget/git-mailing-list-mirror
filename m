From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 20 Oct 2006 11:06:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610201100070.3962@g5.osdl.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<ehao3e$2qv$1@sea.gmane.org> <4538EC8F.7020502@utoronto.ca>
	<200610201821.34712.jnareb@gmail.com> <45390168.6020502@utoronto.ca>
	<Pine.LNX.4.64.0610201016490.3962@g5.osdl.org>
	<45390BAF.5040405@utoronto.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: bazaar-ng-bounces@lists.canonical.com Fri Oct 20 20:07:55 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaylS-0001Ey-DK
	for gcvbg-bazaar-ng@m.gmane.org; Fri, 20 Oct 2006 20:06:40 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1Gayl9-00041I-Ug; Fri, 20 Oct 2006 19:06:20 +0100
Received: from smtp.osdl.org ([65.172.181.4])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <torvalds@osdl.org>) id 1Gayl5-000403-Dh
	for bazaar-ng@lists.canonical.com; Fri, 20 Oct 2006 19:06:15 +0100
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9KI6BaX028640
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 20 Oct 2006 11:06:11 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9KI6ACD028247;
	Fri, 20 Oct 2006 11:06:10 -0700
To: Aaron Bentley <aaron.bentley@utoronto.ca>
In-Reply-To: <45390BAF.5040405@utoronto.ca>
X-Spam-Status: No, hits=-0.973 required=5 tests=AWL,
	OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29514>



On Fri, 20 Oct 2006, Aaron Bentley wrote:
> > 
> > Git _definitely_ handles renames, both in everyday life and when merging.
> 
> Hmm.  Could you say more here?  The only examples I can think of for
> handling renames are situations that can be expressed as a merge.

So yes, merges are the situation where renames are normally considered a 
"problem", but it's actually not nearly the most every-day situation at 
all.

The most common one is actually just showing things as a diff.

If you are looking at a code-change, there's an absolutely _huge_ 
difference if you look at the result as a "delete this huge file" and 
"create this other huge file" and seeing it as a "move this huge file from 
here to here, and change a few lines in the process".

So the most _important_ part of rename tracking from a user perspective is 
for the person who walks through somebody elses code history, and wants to 
know how a certain state came to be. The merges are usually not as big of 
a deal for the user (although they are clearly the most hairy case for the 
SCM - which is why SCM people concentrate on merges).

			Linus
