From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Quick question: end of lines
Date: Tue, 28 Feb 2006 21:07:19 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602282101530.10710@wbgn013.biozentrum.uni-wuerzburg.de>
References: <f898cca90602281032n6603bf14q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 21:07:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEB83-0006Wb-A0
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 21:07:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932536AbWB1UHY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 15:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbWB1UHY
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 15:07:24 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:23270 "EHLO
	mailrelay.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932536AbWB1UHX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2006 15:07:23 -0500
Received: from virusscan.mail (mail03.mail [172.25.1.102])
	by mailrelay.mail (Postfix) with ESMTP id 1B25C1CA0;
	Tue, 28 Feb 2006 21:07:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 0FC7CB1A;
	Tue, 28 Feb 2006 21:07:20 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id E2C39AF2;
	Tue, 28 Feb 2006 21:07:19 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Emmanuel Guerin <emmanuel@guerin.fr.eu.org>
In-Reply-To: <f898cca90602281032n6603bf14q@mail.gmail.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16950>

Hi,

On Tue, 28 Feb 2006, Emmanuel Guerin wrote:

> Is it possible to checkout sources out of the GIT repository with
> Windows style end of lines?

No.

As far as git is concerned, every versioned file is equal. IMHO this 
decision is good, since

- different handling is more complicated (you have to keep track of the 
file type), and
- it is not really worth doing.

Windows can handle Unix line endings quite properly (with the notable 
exception of notepad.exe), and even Apple has learnt that it might be a 
stupid idea to insist on being different when it's just not worth it.

The only reason I would accept: you have to work with MS-DOS tools. But 
even in this case, I'd rather write a wrapper which converts to DOS line 
endings, executes the tool, and converts back.

Hth,
Dscho
