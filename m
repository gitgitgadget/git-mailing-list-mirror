From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Removes the <?xml?> declaration from gitweb.pl
Date: Fri, 13 Oct 2006 15:07:54 +0200
Organization: At home
Message-ID: <ego331$568$2@sea.gmane.org>
References: <20061011172553.GA1147@linux-mips.org> <egjnk5$bpn$2@sea.gmane.org> <200610120745.00909.robin.rosenberg.lists@dewire.com> <200610122321.18630.jnareb@gmail.com> <ego2nk$3nm$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Oct 13 15:10:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYMnn-0006M2-MG
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 15:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbWJMNKM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Oct 2006 09:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751692AbWJMNKM
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Oct 2006 09:10:12 -0400
Received: from main.gmane.org ([80.91.229.2]:50114 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751682AbWJMNKK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Oct 2006 09:10:10 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GYMna-0006H1-4Q
	for git@vger.kernel.org; Fri, 13 Oct 2006 15:10:02 +0200
Received: from host-81-190-17-207.torun.mm.pl ([81.190.17.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Oct 2006 15:10:02 +0200
Received: from jnareb by host-81-190-17-207.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Oct 2006 15:10:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-207.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28842>

Pazu wrote:

> Jakub Narebski wrote:
> 
>> So what should be our decision? Honor IE quirks ;-) and either remove
>> XML declaration, or use Transitional DTD? Add back SPC to &nbsp; conversion
>> in esc_html? Ignore broken browsers?
> 
> My bad here. In my first email I said that using the Transitional DTD 
> would fix the problem, but I was wrong. It doesn't matter the DTD you 
> use, if you add a <?xml?> declaration, IE will get it wrong and activate 
> quirks mode.

Well, there is yet another solution. Do browser detection, and do not output
<?xml ... ?> declaration for IE. Perhaps that would be best solution.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
