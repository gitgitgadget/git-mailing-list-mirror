From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: "make test" fails with current HEAD
Date: Thu, 17 Nov 2005 16:52:28 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511171652020.17402@wbgn013.biozentrum.uni-wuerzburg.de>
References: <pan.2005.11.17.15.31.56.755022@smurf.noris.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 17:02:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ecm3t-00073b-HL
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 16:52:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbVKQPwa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 10:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbVKQPwa
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 10:52:30 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:53180 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932122AbVKQPw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 10:52:29 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E633D13F95E; Thu, 17 Nov 2005 16:52:28 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C4902B5231; Thu, 17 Nov 2005 16:52:28 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 92311B521E; Thu, 17 Nov 2005 16:52:28 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7005B13F95E; Thu, 17 Nov 2005 16:52:28 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <pan.2005.11.17.15.31.56.755022@smurf.noris.de>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12123>

Hi,

On Thu, 17 Nov 2005, Matthias Urlichs wrote:

> t4103.sh:
> 
> fatal: patch with only garbage at line 30
> * FAIL 7: check binary diff with replacement.
>         git-checkout master
>                  git-apply --check --allow-binary-replacement BF.diff

Does not fail here.

Did you set your GIT_EXEC_PATH?

Hth,
Dscho
