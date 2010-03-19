From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 17:50:58 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1003181739310.18017@i5.linux-foundation.org>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>  <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org>  <46a038f91003181536ib3b74f8o40603a4cee13d62b@mail.gmail.com>  <alpine.LFD.2.00.1003181909180.31128@xanadu.home> 
 <9e4733911003181626t7d143903mbc5737ff2fa5100f@mail.gmail.com>  <alpine.LFD.2.00.1003181930230.31128@xanadu.home>  <9e4733911003181641n400704c9r1a0addd6fce6fce0@mail.gmail.com>  <alpine.LFD.2.00.1003181953010.31128@xanadu.home> 
 <9e4733911003181716q7f141d5eqd18218c749ca4624@mail.gmail.com>  <alpine.LFD.2.00.1003181715490.18017@i5.linux-foundation.org> <9e4733911003181739m2f605dd7g9406aaecc296749f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 01:54:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsQTU-0008WO-2O
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 01:54:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752620Ab0CSAx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 20:53:59 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36641 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752492Ab0CSAx6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Mar 2010 20:53:58 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o2J0rs2p007843
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Mar 2010 17:53:55 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o2J0rrW6025576;
	Thu, 18 Mar 2010 17:53:54 -0700
In-Reply-To: <9e4733911003181739m2f605dd7g9406aaecc296749f@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.448 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142549>



On Thu, 18 Mar 2010, Jon Smirl wrote:
> 
> I had all of the names in the list so that I could regenerate the list
> and diff it against the old version to know which new names needed to
> be checked. Looking back I could have eliminated the names without
> errors and then added a comment to the file as to the last date all of
> the names were checked.  But that is less reliable than recording
> which were checked. The problem is that if you lose track of what has
> been checked, you are forced to recheck everything and it takes a long
> time to recheck everything.

The part you keep missing is that NOBODY CARES!

For example, I exist in the current git kernel tree with 11 different 
names for just the authorship information:

     32 Linus Torvalds torvalds@evo.osdl.org
   1522 Linus Torvalds torvalds@g5.osdl.org
   4194 Linus Torvalds torvalds@linux-foundation.org
      7 Linus Torvalds torvalds@macmini.osdl.org
      2 Linus Torvalds torvalds@merom.osdl.org
      8 Linus Torvalds torvalds@osdl.org
    166 Linus Torvalds torvalds@ppc970.osdl.org
      4 Linus Torvalds torvalds@ppc970.osdl.org.(none)
      1 Linus Torvalds torvalds@quad.osdl.org
   1606 Linus Torvalds torvalds@woody.linux-foundation.org
    174 Linus Torvalds torvalds@woody.osdl.org

(that's counts, in case you care). And then if you check signed-off lines, 
you'll find some _additional_ oddities where things just got misspelled, 
like

	Linus Torvalds <tovalds@linux-foundation.org>
	Linus Torvalds <torvalds@akpm@linux-foundation.org>

where in one case there's a missing 'r', and in the other it's some odd 
perverse incestuous relationship between me and Andrew (in reality, it's 
me doing a stupid "search-and-replace" on the emails, adding my own 
sign-off to Andrew's and that got a bit too much copy-paste issues)

There's a few other mistakes like that in the sign-offs.

Does anybody care? Certainly not I. There is absolutely zero reason to 
worry about it. I used to find it convenient to see what machines I had 
worked on, so I actually included that. And one of them was clearly 
mis-configured, or git did something wrong when the hostname was already 
in FQDN format. Whatever.

There is no real _value_ in making a .mailcap for each such buggy entry is 
what I'm trying to tell you. Those things are maybe used for statistics. 
On the whole, they are correct. 

			Linus
