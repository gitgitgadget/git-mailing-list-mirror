From: Neil Brown <neilb@suse.de>
Subject: Re: [SCRIPT] chomp: trim trailing whitespace
Date: Sat, 27 May 2006 20:36:19 +1000
Message-ID: <17528.11171.347324.526827@cse.unsw.edu.au>
References: <4477B905.9090806@garzik.org>
	<Pine.LNX.4.61.0605271212210.6670@yvahk01.tjqt.qr>
	<20060527102439.GB26430@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	GIT <git@vger.kernel.org>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>
X-From: git-owner@vger.kernel.org Sat May 27 12:36:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fjw9v-00080S-Ps
	for gcvg-git@gmane.org; Sat, 27 May 2006 12:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbWE0Kg2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 May 2006 06:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbWE0Kg1
	(ORCPT <rfc822;git-outgoing>); Sat, 27 May 2006 06:36:27 -0400
Received: from cantor.suse.de ([195.135.220.2]:63405 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751459AbWE0Kg1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 May 2006 06:36:27 -0400
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id EF501EF73;
	Sat, 27 May 2006 12:36:25 +0200 (CEST)
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: message from Thomas Glanzmann on Saturday May 27
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20847>

On Saturday May 27, sithglan@stud.uni-erlangen.de wrote:
> Hello,
> 
> > #!/usr/bin/perl -i -p
> > s/[ \t\r\n]+$//
> 
> perl -p -i -e 's/\s+$//' file1 file2 file3 ...
> 

Uhm... have either of you actually tried those?  When I tried, I lose
all the '\n' characters :-(

  perl -pi -e 's/[ \t\r]+$//'  *.[ch]

seems to actually work.

NeilBrown
