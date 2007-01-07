From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: Re: problem with git clone on cygwin
Date: Sun, 7 Jan 2007 11:46:45 +0100
Message-ID: <17824.53141.207000.935133@lapjr.intranet.kiel.bmiag.de>
References: <20070106170330.GA8041@scotty.home>
	<17824.5988.344000.501073@lapjr.intranet.kiel.bmiag.de>
	<20070106215919.GB8041@scotty.home>
	<20070107093015.GA9909@scotty.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 11:47:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3VYT-0002Ou-Qs
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 11:47:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbXAGKrG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 05:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbXAGKrG
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 05:47:06 -0500
Received: from meriadoc.bmiag.de ([62.154.210.133]:34157 "EHLO
	meriadoc.bmiag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932485AbXAGKrF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 05:47:05 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by meriadoc.bmiag.de (Postfix) with ESMTP id 240E43AF21;
	Sun,  7 Jan 2007 11:47:01 +0100 (CET)
Received: from meriadoc.bmiag.de ([127.0.0.1])
	by localhost (meriadoc [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 09914-01; Sun, 7 Jan 2007 11:47:01 +0100 (CET)
Received: from eotheod.intranet.kiel.bmiag.de (eotheod.intranet.kiel.bmiag.de [10.130.2.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by meriadoc.bmiag.de (Postfix) with ESMTP id 72D943AF20;
	Sun,  7 Jan 2007 11:46:56 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eotheod.intranet.kiel.bmiag.de (Postfix) with ESMTP id C75EA3ADCD;
	Sun,  7 Jan 2007 11:46:55 +0100 (CET)
Received: from eotheod.intranet.kiel.bmiag.de ([127.0.0.1])
	by localhost (eotheod [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 24351-10; Sun, 7 Jan 2007 11:46:52 +0100 (CET)
Received: from LAPJR (dialin5.galadriel.bmiag.de [192.168.251.5])
	by eotheod.intranet.kiel.bmiag.de (Postfix) with ESMTP id 5E5593ADCC;
	Sun,  7 Jan 2007 11:46:49 +0100 (CET)
To: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
In-Reply-To: <20070107093015.GA9909@scotty.home>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eotheod.intranet.kiel.bmiag.de
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at meriadoc.bmiag.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36150>

Stefan-W. Hahn writes:
 > Also sprach Juergen Ruehle am Sat, 06 Jan 2007 at 22:40:52 +0100:
 > > Could you enumerate the other compatability problems?
 > 
 > The problem that one cannot use one version of cygwin.dll and
 > simultaniously another (incomatible) version. (Having a local
 > installed cygwin window open and trying to build in a branch where
 > another version is used.)

Yes that is an unfortunate (though probably unavoidable) downside of
cygwin. But my question was meant more along the lines of 'could you
give some examples of applications that do not work with 1.5.22 or
later and prevent you from upgrading your installed cygwin version'.
If there are serious showstoppers it would probably be a good idea to
go the route Shawn outlined to retain compatibility with earlier
cygwin releases. Otherwise we'll just keep recommending an upgrade:-)

Sorry for being unclear.
