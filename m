From: Seth Falcon <sfalcon@fhcrc.org>
Subject: Re: suggestion for git rebase -i
Date: Sat, 28 Jul 2007 08:52:40 -0700
Message-ID: <m2vec4seyf.fsf@ziti.fhcrc.org>
References: <m26445t98z.fsf@ziti.fhcrc.org>
	<Pine.LNX.4.64.0707280941380.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Seth Falcon <sfalcon@fhcrc.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 28 17:52:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEob4-0004YA-9J
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 17:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbXG1Pwr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 11:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbXG1Pwr
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 11:52:47 -0400
Received: from MICA.FHCRC.ORG ([140.107.152.12]:36355 "EHLO mica.fhcrc.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750774AbXG1Pwq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 11:52:46 -0400
Received: from jade.fhcrc.org (JADE.FHCRC.ORG [140.107.42.223])
	by mica.fhcrc.org (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id l6SFqgYH028203
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 28 Jul 2007 08:52:43 -0700
Received: from ziti.fhcrc.org (DORMOUSE.FHCRC.ORG [140.107.170.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jade.fhcrc.org (Postfix) with ESMTP id C708BE7E5;
	Sat, 28 Jul 2007 08:52:42 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707280941380.14781@racer.site> (Johannes Schindelin's message of "Sat\, 28 Jul 2007 09\:43\:15 +0100 \(BST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (darwin)
X-PMX-Version: 5.3.2.304607, Antispam-Engine: 2.5.1.298604, Antispam-Data: 2007.7.28.83054
X-FHCRC-SCANNED: Sat Jul 28 08:52:43 2007
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54039>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> Why?  This is an implementation detail, and should not concern the
> user.

In the context of an existing editing session, the name of the
tempfile is visible and relevant to the user (not just an
implementation detail).  For example, the tempfile name is useful when
multi-tasking and one needs to get back to the buffer.  As another
reply pointed out, the name could also be used for editor mode
customization.

So.  When editing a commit message, the buffer is named
COMMIT_EDITMSG.  When editing a rebase -i buffer it is named todo.  Is
this a real problem?  Of course not.  But I think a slightly more
descriptive name makes sense -- especially if other commands gain
interactive modes and a user might have a number of them going at once
(in different repos, e.g.).

+ seth
