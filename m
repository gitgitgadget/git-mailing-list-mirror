From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] repo-config: learn the flag "--no-local"
Date: Thu, 8 Jun 2006 22:18:54 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606082217580.28323@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0606081331140.11910@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060608153236.GA8047@satan.machinehead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 08 22:19:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoQy2-0007Gy-Oo
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 22:18:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964980AbWFHUS4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 16:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbWFHUS4
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 16:18:56 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:24043 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964980AbWFHUSz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 16:18:55 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 6BAACD1C;
	Thu,  8 Jun 2006 22:18:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 60085BA1;
	Thu,  8 Jun 2006 22:18:54 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 43AD3B7C;
	Thu,  8 Jun 2006 22:18:54 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
In-Reply-To: <20060608153236.GA8047@satan.machinehead.org>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21510>

Hi,

On Thu, 8 Jun 2006, Aneesh Kumar K.V wrote:

> On Thu, Jun 08, 2006 at 01:31:46PM +0200, Johannes Schindelin wrote:
> > 
> > Since there is a global config now, we need a way to access it
> > conveniently. Now you can say
> > 
> > 	git repo-config --no-local alias.l "log --stat -M ORIG_HEAD.."
> > 
> > to set the alias globally (it will be stored in ~/.gitconfig).
> > 
> 
> how about  making the above 
> 
>    git config --repo alias.l "log --stat -M ORIG_HEAD.."

IMHO it would be a sane thing to make this default. Most config variables 
are repository dependent.

Ciao,
Dscho
