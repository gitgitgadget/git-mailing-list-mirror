From: Ingo Molnar <mingo@elte.hu>
Subject: Re: git-viz tool for visualising commit trees
Date: Thu, 21 Apr 2005 15:02:42 +0200
Message-ID: <20050421130242.GA5817@elte.hu>
References: <20050420100824.GB25477@elte.hu> <20050421.034227.104037433.oandrieu@nerim.net> <20050421092120.GA20626@elte.hu> <20050421.133136.78712855.oandrieu@nerim.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pasky@ucw.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 14:59:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DObGS-0003Vf-DE
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 14:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVDUNC6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 09:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbVDUNC6
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 09:02:58 -0400
Received: from mx1.elte.hu ([157.181.1.137]:191 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261335AbVDUNC4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 09:02:56 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx1.elte.hu (Postfix) with ESMTP id 5A1EC30CD93;
	Thu, 21 Apr 2005 15:02:02 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 53EA41FC2; Thu, 21 Apr 2005 15:02:47 +0200 (CEST)
To: Olivier Andrieu <oandrieu@nerim.net>
Content-Disposition: inline
In-Reply-To: <20050421.133136.78712855.oandrieu@nerim.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


* Olivier Andrieu <oandrieu@nerim.net> wrote:

>  >  Preprocessor error
>  >  make: *** [viz_style.cmx] Error 2
> 
> That's probably because the configure script didn't find camlp4. 
> Camlp4 is a preprocessor for ocaml, it's needed for compiling this 
> file (viz_style.ml). Camlp4 is built with the ocaml compilers but some 
> package it separately. Try to find and install some ocaml-camlp4 (or 
> camlp4) package and then re-run configure.

ah, ok. I installed camlp4-3.08.3-1, and this also solved the other 
build problem as well that looked like to be a PATH problem.

when i run git-viz in a git-controlled directory, it seems to start up 
fine, but i get an error message: "Could not execute dot". Closing that 
window gives me the ability to do an 'Open', but git-viz does not seem 
to recognize any of my GIT repositories as such. (perhaps there's some 
GIT version dependency? I've got Linus' latest & greatest installed.)
 
> The configure script should signal an error when it doesn't find 
> camlp4, I'll change that.

fyi, it also didnt check for ocaml and lablgtk.

	Ingo
