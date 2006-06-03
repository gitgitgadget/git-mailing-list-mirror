From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: A test failing with python 2.2 -- ok?
Date: Sat, 3 Jun 2006 11:13:57 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606031113060.31512@wbgn013.biozentrum.uni-wuerzburg.de>
References: <93c3eada0606022348l3c39f966u781327b14b0bc3d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 03 11:14:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmSCy-0001EM-5Z
	for gcvg-git@gmane.org; Sat, 03 Jun 2006 11:14:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932597AbWFCJOA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 05:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932599AbWFCJOA
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 05:14:00 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:56008 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932598AbWFCJN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jun 2006 05:13:59 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id ADDE5E0D;
	Sat,  3 Jun 2006 11:13:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id A1ED0DE8;
	Sat,  3 Jun 2006 11:13:58 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 83FC2D32;
	Sat,  3 Jun 2006 11:13:57 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: geoff@austrics.com.au
In-Reply-To: <93c3eada0606022348l3c39f966u781327b14b0bc3d5@mail.gmail.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21189>

Hi,

On Sat, 3 Jun 2006, Geoff Russell wrote:

> I'm not sure how far back you are supporting, but I'm running a python 
> 2.2 machine and make test fails with a missing python module. Whatever 
> criss-cross merges are, I don't need them, but figured if you were 
> intending to support older environments, then you may be interested.

Python 2.2 is too old, even if you import some missing modules. But you 
can always set "NO_PYTHON=YesPlease" in config.mak.

Hth,
Dscho
