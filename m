From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Subject: RE: git-svn and u-boot broken.
Date: Fri, 13 Oct 2006 21:43:21 +0200
Message-ID: <00ae01c6eeff$d6c454e0$1267a8c0@Jocke>
References: <86slhsgg3f.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 13 21:45:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYSyK-0002Np-If
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 21:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854AbWJMTp3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Oct 2006 15:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751855AbWJMTp3
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Oct 2006 15:45:29 -0400
Received: from 147.175.241.83.in-addr.dgcsystems.net ([83.241.175.147]:10898
	"EHLO tmnt04.transmode.se") by vger.kernel.org with ESMTP
	id S1751854AbWJMTp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Oct 2006 15:45:28 -0400
Received: from Jocke ([84.217.9.178]) by tmnt04.transmode.se with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 13 Oct 2006 21:45:26 +0200
To: "'Randal L. Schwartz'" <merlyn@stonehenge.com>
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Thread-Index: Acbu/2XhgfSie4HXTBGPTIL6wyYORwAAEXjg
In-Reply-To: <86slhsgg3f.fsf@blue.stonehenge.com>
X-OriginalArrivalTime: 13 Oct 2006 19:45:26.0203 (UTC) FILETIME=[212948B0:01C6EF00]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28856>

 > 
> >>>>> "Joakim" == Joakim Tjernlund 
> <joakim.tjernlund@transmode.se> writes:
> 
> Joakim> First, I had to change this (from memory) in git-svn:
> Joakim>   my $got = SVN::TxDelta::send_stream($fh, @$atd, 
> $self->{pool});
> Joakim> to
> Joakim>   my $got;
> Joakim>   if ( $got ) {
> Joakim>     $got = SVN::TxDelta::send_stream($fh, @$atd, 
> $self->{pool});
> Joakim>   } else {
> Joakim>     $got = $exp
> Joakim>   }
> Joakim> I am no perl programmer so please change as you se fit.
> 
> That doesn't make any sense.  You'll never run the if-true 
> branch there.
> The value of $got immediately following "my $got;" is always undef.

Typo, should be 'if( $atd )', sorry
