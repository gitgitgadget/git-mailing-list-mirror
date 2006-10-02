From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: tree view: eliminate redundant "blob"
Date: Mon, 2 Oct 2006 12:11:15 -0700 (PDT)
Message-ID: <20061002191115.84730.qmail@web31811.mail.mud.yahoo.com>
References: <200610012041.15296.jnareb@gmail.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Luben Tuikov <ltuikov@yahoo.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 02 21:12:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUTCE-0005Ww-Od
	for gcvg-git@gmane.org; Mon, 02 Oct 2006 21:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965359AbWJBTLS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Oct 2006 15:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965364AbWJBTLS
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Oct 2006 15:11:18 -0400
Received: from web31811.mail.mud.yahoo.com ([68.142.207.74]:54190 "HELO
	web31811.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965359AbWJBTLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Oct 2006 15:11:16 -0400
Received: (qmail 84732 invoked by uid 60001); 2 Oct 2006 19:11:15 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=BoPZ1RdZ2QIZINq/AIBt7uawqS+ItNq0CkWJoUs6kKZ1RKjruoEdgAgTXUOJiqD5Tfk1XN9x7mnFweoonzCiU/9NmJQnn92q2k8XugH+IfCcnjHLvWM3KHea8aMR3w0AGaql06PQjTauaJUTi3vGR8cuHRp8QLH7+C9+v1cA2uI=  ;
Received: from [64.215.88.90] by web31811.mail.mud.yahoo.com via HTTP; Mon, 02 Oct 2006 12:11:15 PDT
To: Jakub Narebski <jnareb@gmail.com>, Junio C Hamano <junkio@cox.net>
In-Reply-To: <200610012041.15296.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28228>

--- Jakub Narebski <jnareb@gmail.com> wrote:
> But that is plain impossible without compromising interface usability.
> Let me explain. 
> 
> In the case of tree view (directory listing) we have blobs (files and 
> symlinks) and trees (directories). To mark item unequivocably as link 
> it has to have default link color (blue) and default link decoration 
> (underline). That means that we cannot distinguish really well (at 
> least color) between tree and blob entries. I'd rather have redundant 
> "blob"/"tree" (self)links, clearly marked as links, and tree entries 
> using link decoration (blue, underlined) while blob entries have 
> default text decoration (black, no underline).
> 
> In the case of shortlog/log/history/heads/tags view, to clearly mark 
> subject/title of a commit or tag as link, we would have to use default 
> link decoration. Let's for a while abandon link-within-link, i.e. using 
> some of committags also in commit title (in shortlog/history view)...
> But underlined text is harder to read, and blue underlined text even 
> more so (as for example it is hard to read italics, commonly used for 
> emphasis). I'd rather have additional "commit" link, clearly marked as 
> link, and leave subject as is, as hidden link, as a shortcut.
> 
> I think that redundancy in a visual interface (and not only visual, as 
> seen in the example of Perl programming language) is a good idea, 
> contrary to the redundancy in code or data (database).

Jakub,

Your opinion here is highly subjective.

Years of experience make certain things "make sense" and other
"make less sense".  Note that that is in itself subjective.

Give it 10 years, your opinion will change.

     Luben
