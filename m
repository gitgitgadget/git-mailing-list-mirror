From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: Two ideas for improving git's user interface
Date: Thu, 02 Feb 2006 13:31:38 +0100
Message-ID: <87mzhandqt.fsf@mid.deneb.enyo.de>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
	<Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
	<46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
	<1138446030.9919.112.camel@evo.keithp.com>
	<7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
	<20060130185822.GA24487@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0601311750270.25300@iabervon.org>
	<7vek2oot7z.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0601311623240.7301@g5.osdl.org>
	<7v4q3jlgw2.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602011125370.5397@localhost.localdomain>
	<7vhd7ibza2.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602011307250.21884@g5.osdl.org>
	<7v8xsu91vf.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602011433290.21884@g5.osdl.org>
	<87lkwupsbr.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Feb 02 13:31:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4dcm-0003ye-0C
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 13:31:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWBBMbl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Feb 2006 07:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbWBBMbl
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Feb 2006 07:31:41 -0500
Received: from mail.enyo.de ([212.9.189.167]:5076 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S1750978AbWBBMbj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2006 07:31:39 -0500
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1F4dcg-00072f-Tr
	for git@vger.kernel.org; Thu, 02 Feb 2006 13:31:38 +0100
Received: from fw by deneb.enyo.de with local (Exim 4.60)
	(envelope-from <fw@deneb.enyo.de>)
	id 1F4dcg-0002WQ-4Q
	for git@vger.kernel.org; Thu, 02 Feb 2006 13:31:38 +0100
To: git@vger.kernel.org
In-Reply-To: <87lkwupsbr.wl%cworth@cworth.org> (Carl Worth's message of "Wed,
	01 Feb 2006 15:33:44 -0800")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15506>

* Carl Worth:

> Here's a fundamental question I have, (and thanks to Keith Packard for
> helping me to phrase it):
>
> 	Is it ever useful (reasonable, desirable) to commit file
> 	contents that differ from the contents of the working
> 	directory?

You mean like "darcs record"? 8-)

I think this is very useful functionality.  Granted, it interferes
with a rigorous developer-side regression test policy ("all changes
must have been built and passed the test suite").  But it encourages
things like fixing typos in comments you spot while editing a file for
other reasons.  And you can keep some ugly debugging code while
working on a series of changes.
