From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Rss produced by git is not valid xml?
Date: Sat, 19 Nov 2005 01:04:42 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511190101590.28126@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200511181833.40048.ismail@uludag.org.tr> <200511181926.10357.ismail@uludag.org.tr>
 <200511182127.06958.ismail@uludag.org.tr> <20051118200217.GA2831@vrfy.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ismail Donmez <ismail@uludag.org.tr>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 01:23:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdGDq-0005VP-5N
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 01:04:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbVKSAEq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 19:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbVKSAEq
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 19:04:46 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:57536 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751167AbVKSAEq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 19:04:46 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0EBEC13FFEE; Sat, 19 Nov 2005 01:04:43 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E4E5E9F36D; Sat, 19 Nov 2005 01:04:42 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D1AF6907C8; Sat, 19 Nov 2005 01:04:42 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 35B7013FFEE; Sat, 19 Nov 2005 01:04:42 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20051118200217.GA2831@vrfy.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12303>

Hi,

On Fri, 18 Nov 2005, Kay Sievers wrote:

> Yes, convince the git maintainers, that it's incredibly stupid not to
> enforce utf8 in commit messages. It makes absolutely zero sense in a
> SCM, which merges forth and back between people around the world to
> allow random encodings from the last century.

Oh, but it makes sense! Just because you happen to work on a very 
international project does not mean everybody does.

Just because you happen to like utf-8 does not mean that you still do in 
2046. The encoding-du-jour might well be a 64-bit wide char code by then, 
since they'll laugh about our dreaming about terabytes.

BTW, utf-8 was designed on purpose to be easily distinguishable from other 
encodings so that you don't have to rely on every document obeying a 
certain encoding.

Hth,
Dscho
