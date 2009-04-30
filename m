From: Peter Simons <simons@cryp.to>
Subject: Re: gitweb sets incorrect <base> header
Date: Thu, 30 Apr 2009 12:06:45 +0200
Organization: private
Message-ID: <87preuzc96.fsf@write-only.cryp.to>
References: <877i15uf14.fsf@write-only.cryp.to> <m3k553oldj.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 30 12:07:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzTAc-0004qB-Q6
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 12:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753640AbZD3KHB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 06:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752912AbZD3KHB
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 06:07:01 -0400
Received: from main.gmane.org ([80.91.229.2]:48821 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751437AbZD3KHA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 06:07:00 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LzTAO-0002ag-1S
	for git@vger.kernel.org; Thu, 30 Apr 2009 10:06:56 +0000
Received: from p54bd25bf.dip0.t-ipconnect.de ([84.189.37.191])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 30 Apr 2009 10:06:56 +0000
Received: from simons by p54bd25bf.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 30 Apr 2009 10:06:56 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p54bd25bf.dip0.t-ipconnect.de
Cancel-Lock: sha1:Z1slVPsMKYECvtwcGUsxkG6/mgc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118011>

Hi Jakub,

 > Or you can set up $base_url in your gitweb configuration file (which
 > is not mentioned in the gitweb/README, unfortunately).

My gitweb.conf file is now configured as follows:

  $my_url = "http://git.cryp.to/";
  $my_uri = "/";
  $base_url = $my_uri;
  [...]

That seems to do the trick.

Thank you for your help,
Peter
