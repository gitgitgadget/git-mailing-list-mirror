From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: sha-1 mismatch using command line sha1sum
Date: Tue, 16 Jan 2007 15:17:00 +0100
Organization: At home
Message-ID: <eoimnv$g0c$1@sea.gmane.org>
References: <200701161342.56431.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Jan 16 15:17:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6p7U-0002e8-8g
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 15:17:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbXAPOQ6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 09:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbXAPOQ6
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 09:16:58 -0500
Received: from main.gmane.org ([80.91.229.2]:38335 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751153AbXAPOQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 09:16:57 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H6p7J-0001Uu-Rp
	for git@vger.kernel.org; Tue, 16 Jan 2007 15:16:49 +0100
Received: from host-81-190-20-200.torun.mm.pl ([81.190.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Jan 2007 15:16:49 +0100
Received: from jnareb by host-81-190-20-200.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Jan 2007 15:16:49 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-200.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36939>

Andy Parkins wrote:

> Hello,
> 
> I came across this message:
> 
> http://www.gelato.unsw.edu.au/archives/git/0504/0212.html
> 
> So I thought, "hey that's interesting, I'll try it".  I was surprised to find 
> this:
> 
> $ sha1sum .git/objects/f4/b6c6b90fdce12d69e4ad80ff6082405ec8cfb8 
> ac4c6f1d36d6e0341486789b32f86ae6f506df35  .git/objects/f4/b6c6b90fdce12d69e4ad80ff6082405ec8cfb8
> 
> This is in the latest git repository.
> 
> Is this correct, or should we all begin screaming and crying that our 
> repositories are woefully corrupt? :-)

sha-1 sum of _uncompressed_ object.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
