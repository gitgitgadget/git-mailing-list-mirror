From: Anders Larsen <al@alarsen.net>
Subject: rpmbuild fails
Date: Tue, 10 Oct 2006 22:31:49 +0200
Organization: systems engineer Anders Larsen
Message-ID: <pan.2006.10.10.20.31.48.692444@alarsen.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Oct 10 22:45:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXOTc-0001u8-Us
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 22:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030331AbWJJUpJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 16:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030330AbWJJUpH
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 16:45:07 -0400
Received: from main.gmane.org ([80.91.229.2]:36522 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030329AbWJJUpE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Oct 2006 16:45:04 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GXOTG-0001pE-O1
	for git@vger.kernel.org; Tue, 10 Oct 2006 22:45:02 +0200
Received: from p54ac262a.dip0.t-ipconnect.de ([84.172.38.42])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Oct 2006 22:45:02 +0200
Received: from al by p54ac262a.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Oct 2006 22:45:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: p54ac262a.dip0.t-ipconnect.de
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28664>

The current git fails when building rpms:

	RPM build errors:
	    Installed (but unpackaged) file(s) found:
	   /usr/lib/perl5/vendor_perl/5.8.6/Git.pm

Indeed git.spec.in does not specify any files for perl-Git, only
	%files -n perl-Git -f perl-files
	%defattr(-,root,root)
nothing more.

How is this supposed to be handled correctly?

Cheers
 Anders
