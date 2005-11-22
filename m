From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Make grafts versionable
Date: Tue, 22 Nov 2005 01:37:44 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511220136140.6187@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0511212152110.4611@wbgn013.biozentrum.uni-wuerzburg.de>
 <43823654.2060904@zytor.com> <Pine.LNX.4.64.0511211326110.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 01:39:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeMAj-0000DZ-4v
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 01:38:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbVKVAht (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 19:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbVKVAht
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 19:37:49 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:453 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964805AbVKVAhs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 19:37:48 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 455D613FDDB; Tue, 22 Nov 2005 01:37:47 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2281BB52A2; Tue, 22 Nov 2005 01:37:47 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0726BB5298; Tue, 22 Nov 2005 01:37:47 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 520C413FDDB; Tue, 22 Nov 2005 01:37:44 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511211326110.13959@g5.osdl.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12511>

Hi,

On Mon, 21 Nov 2005, Linus Torvalds wrote:

> In general, making any internal git data versionable is very confusing. So 
> you make the grafts file versionable - that suddenly means that different 
> branches may have different parents for the same commit. And that 
> depending on which branch you have checked out, git-fsck-cache may result 
> in an error, or it may not. That's _nasty_, in my opinion.

Yes, that is nasty. It does not reflect my normal usage pattern, but that 
does not make it better. So let's forget about that idea of mine.

Ciao,
Dscho
