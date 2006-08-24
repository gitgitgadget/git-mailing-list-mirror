From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Running gitweb under mod_perl
Date: Thu, 24 Aug 2006 19:49:30 +0200
Organization: At home
Message-ID: <eckor9$jje$1@sea.gmane.org>
References: <eck6sq$agn$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Aug 24 19:51:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGJLz-0002Kf-PV
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 19:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030431AbWHXRuu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 13:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030442AbWHXRuu
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 13:50:50 -0400
Received: from main.gmane.org ([80.91.229.2]:27105 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030431AbWHXRut (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Aug 2006 13:50:49 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GGJLU-0002C8-VN
	for git@vger.kernel.org; Thu, 24 Aug 2006 19:50:25 +0200
Received: from host-81-190-21-215.torun.mm.pl ([81.190.21.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 Aug 2006 19:50:24 +0200
Received: from jnareb by host-81-190-21-215.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 Aug 2006 19:50:24 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-215.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25969>

By the way, does the "static" variables works under mod_perl? i.e.

{
  my $private_var = "something"

  sub some_sub {
    ...
  }

  sub other_sub {
    ...
  }
}

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
