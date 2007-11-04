From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: Re: [PATCH 01/10] Add a parseopt mode to git-rev-parse to bring
	parse-options to shell scripts.
Date: Sun, 4 Nov 2007 12:31:30 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20071104113130.GC2119@ins.uni-bonn.de>
References: <1194172262-1563-1-git-send-email-madcoder@debian.org> <1194172262-1563-2-git-send-email-madcoder@debian.org> <20071104112931.GB2119@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Pierre Habouzit <madcoder@debian.org>, gitster@pobox.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 12:31:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iodhj-0005m7-Hg
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 12:31:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756851AbXKDLbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 06:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756812AbXKDLbd
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 06:31:33 -0500
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:43688 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756524AbXKDLbd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 06:31:33 -0500
Received: from ins.uni-bonn.de (gibraltar [192.168.193.254])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id DFBD64000048A;
	Sun,  4 Nov 2007 12:31:31 +0100 (CET)
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>, gitster@pobox.com,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071104112931.GB2119@ins.uni-bonn.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63383>

* Ralf Wildenhues wrote on Sun, Nov 04, 2007 at 12:29:31PM CET:
> A couple of language nits:
> 
> * Pierre Habouzit wrote on Sun, Nov 04, 2007 at 11:30:53AM CET:
[...]
> > +It takes on the standard input the specification of the options to parse and
> > +understand, and echoes on the standard ouput a line suitable for `sh(1)` `eval`

Missed another  s/ouput/output/  here.

> > +to replace the arguments with normalized ones.  In case of error, it ouputs
> 
> s/ouputs/outputs/
