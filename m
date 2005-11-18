From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: "make test" fails with current HEAD
Date: Fri, 18 Nov 2005 04:27:17 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511180425200.6820@wbgn013.biozentrum.uni-wuerzburg.de>
References: <pan.2005.11.17.15.31.56.755022@smurf.noris.de>
 <Pine.LNX.4.63.0511171652020.17402@wbgn013.biozentrum.uni-wuerzburg.de>
 <437D4924.50307@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 04:28:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcwuN-0006Nh-BG
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 04:27:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbVKRD1Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 22:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbVKRD1Y
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 22:27:24 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:23441 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751514AbVKRD1X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 22:27:23 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 752B313FBF0; Fri, 18 Nov 2005 04:27:23 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 76BFC9F34A; Fri, 18 Nov 2005 04:27:22 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 255589CC6E; Fri, 18 Nov 2005 04:27:22 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id DE96513FBF0; Fri, 18 Nov 2005 04:27:22 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: A Large Angry SCM <gitzilla@gmail.com>
In-Reply-To: <437D4924.50307@gmail.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12188>

Hi,

On Thu, 17 Nov 2005, A Large Angry SCM wrote:

> Fails at home (Suse 9.3) but passes a work (Ubuntu Hoary).
> 
> *** t4103-apply-binary.sh ***
> *   ok 1: stat binary diff -- should not fail.
> *   ok 2: stat binary diff (copy) -- should not fail.
> *   ok 3: check binary diff -- should fail.
> *   ok 4: check binary diff (copy) -- should fail.
> *   ok 5: check incomplete binary diff with replacement -- should fail.
> *   ok 6: check incomplete binary diff with replacement (copy) -- should fail.
> * FAIL 7: check binary diff with replacement.
>         git-checkout master
>                  git-apply --check --allow-binary-replacement BF.diff

Any chance you investigate this in detail? Like inserting "test_done; 
exit" right before that test, only running t4103-*, and then executing
the command yourself?

Hth,
Dscho
