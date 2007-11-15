From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: [PATCH] Extend cat-file to take multiple arguments or read input
   from stdin.
Date: Thu, 15 Nov 2007 02:41:02 -0200
Message-ID: <fhgitt$b8d$1@ger.gmane.org>
References: <fhghqv$98a$1@ger.gmane.org> <Pine.LNX.4.64.0711150432420.4362@racer.site>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 15 05:46:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsWcW-0003bE-Kz
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 05:46:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754431AbXKOEqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 23:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754125AbXKOEqK
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 23:46:10 -0500
Received: from main.gmane.org ([80.91.229.2]:34520 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754083AbXKOEqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 23:46:09 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IsWc7-0003Ex-JO
	for git@vger.kernel.org; Thu, 15 Nov 2007 04:46:03 +0000
Received: from c911de8c.bhz.virtua.com.br ([201.17.222.140])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Nov 2007 04:46:03 +0000
Received: from hanwen by c911de8c.bhz.virtua.com.br with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Nov 2007 04:46:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: c911de8c.bhz.virtua.com.br
User-Agent: Thunderbird 2.0.0.6 (X11/20070926)
In-Reply-To: <Pine.LNX.4.64.0711150432420.4362@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65057>

Johannes Schindelin escreveu:
> Hi,
> 
> On Thu, 15 Nov 2007, Han-Wen Nienhuys wrote:
> 
>> With this functionality, the entire object database can be dumped with a 
>> limited number of processes: two cat-file processes for discovering size 
>> and type, and one cat-file process per type.
> 
> IMHO a better idea would be a counterpart to fast-import, probably called 
> "fast-export".  You'd need only one process then, and it would not only be 
> faster, but would be usable by even more people, I guess.

I know, and that's what I was thinking. However, I was hoping someone else 
would pick up the hint :-)

I suppose fast-export would just be cat-file with a different name and  
slightly saner interface.  How about

  type <sha1> <newline>
  size <sha1> <newline>
  dump <type> <sha1> <newline>

?

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
