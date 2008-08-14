From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [GSoC] What is status of Git's Google Summer of Code 2008 projects?
Date: Fri, 15 Aug 2008 01:23:31 +0200
Message-ID: <200808150123.33546.jnareb@gmail.com>
References: <200807080227.43515.jnareb@gmail.com> <200808140457.56464.jnareb@gmail.com> <1218717743.11530.99.camel@maia.lan>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Joshua Roys <roysjosh@gmail.com>,
	Sverre Rabbelier <alturin@gmail.com>,
	Sverre Rabbelier <sverre@rabbelier.nl>,
	David Symonds <dsymonds@gmail.com>,
	Lea Wiemann <LeWiemann@gmail.com>,
	John Hawley <warthog19@eaglescrag.net>,
	Marek Zawirski <marek.zawirski@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	gittorrent@lists.utsl.gen.nz
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Fri Aug 15 01:24:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTmBV-0002dq-57
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 01:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbYHNXXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 19:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbYHNXXj
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 19:23:39 -0400
Received: from qb-out-0506.google.com ([72.14.204.238]:49262 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbYHNXXh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 19:23:37 -0400
Received: by qb-out-0506.google.com with SMTP id a16so834176qbd.17
        for <git@vger.kernel.org>; Thu, 14 Aug 2008 16:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=cDIxvSWsZHNIB2ZcTN2Ux3TMfYvzVPvPgQ79jlTgN1w=;
        b=by9Tbcuig5rGtbWmDp6Eo24sHdRhcPABfJTQueyBuf2rIwDWnpZAtr5BGoulbdNPyI
         iLx1mXMr3yMrDyi8yvHvn5cPONw/Q1Nvm9Zmoyx5K56pQMtfb78L+tTI+Ak1AG/smx2k
         Zu22Q71F+Px02PTDpxmEi6sHzxlDfWeeofpHg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=g5Ti2BxlYBt0NG6YaO1GMAo8qdEo3UgOik4HvJs0r1mUR60ljHndDEJC2lZuSfVrsu
         ufytNEAXNsWVddOryPeO4UceWaVjENSxT5mYDivd9JB6MaFQRaDGftGro9/3aQXwiIkr
         /OhFqLQgopp5e+NNrj0pn1rhHxBw1K6xnf1ZM=
Received: by 10.210.115.15 with SMTP id n15mr2126434ebc.81.1218756216293;
        Thu, 14 Aug 2008 16:23:36 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.237.184])
        by mx.google.com with ESMTPS id c24sm3282688ika.4.2008.08.14.16.23.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 14 Aug 2008 16:23:34 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1218717743.11530.99.camel@maia.lan>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92438>

On Thu, 14 Aug 2008, Sam Vilain wrote:
> On Thu, 2008-08-14 at 04:57 +0200, Jakub Narebski wrote:
>>
>> 1. GitTorrent
>>  
>> Student: Joshua Roys
>> Mentor: Sam Vilain
>> 
>> If I remember correctly at midterm it was deemed to be somewhat late;
>> metainfo was done, tracker was in works, some core infrastructure
>> and beginnings of peer to peer:
>>   http://thread.gmane.org/gmane.comp.version-control.git.gittorrent/1
[...]

>> Status: I have no idea how close GitTorrent is to completion (where by 
>> completion I mean ready, tested and benchmarked code running e.g. on 
>> kernel.org).  I'm not sure if it is meant to be incorporated in git, 
>> even in contrib, or remain separate like StGIT, TopGit or jgit.
> 
> The scope outlined in the GitTorrent proposal was a little bit more of a
> research project; being ready for production use on kernel.org or having
> code ready to merge to git was not directly a deliverable.
> 
> The approved idea at the outset of *this* project was to try out the RFC
> protocol design as it stands, iron out the weaknesses and see how it
> performs. [...]

That is a very good idea, but neither 
http://git.or.cz/gitwiki/SoC2008Projects#GitTorrent nor
http://code.google.com/soc/2008/git/appinfo.html?csaid=F544F0DAA82AFDFC
tells me that it is more about prototype implementation, or even
pre-prototype implementation (testing protocol design), than actually
implementing it in the state for it to be ready to use.

What I (and I guess also GSoC 2008 admins) would know is how far this
research on GitTorrent Protocol went; what milestones were achieved and
what were missed...

-- 
Jakub Narebski
Poland
