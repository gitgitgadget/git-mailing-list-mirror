From: Olivier Andrieu <oandrieu@nerim.net>
Subject: Re: git-viz tool for visualising commit trees
Date: Thu, 21 Apr 2005 15:55:19 +0200 (CEST)
Message-ID: <20050421.155519.112619323.oandrieu@nerim.net>
References: <20050421092120.GA20626@elte.hu>
	<20050421.133136.78712855.oandrieu@nerim.net>
	<20050421130242.GA5817@elte.hu>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 15:53:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOc5Q-0003tj-Gv
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 15:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbVDUNza (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 09:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbVDUNza
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 09:55:30 -0400
Received: from smtp-104-thursday.nerim.net ([62.4.16.104]:32265 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261380AbVDUNzW
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 09:55:22 -0400
Received: from localhost (karryall.dnsalias.org [62.4.18.180])
	by kraid.nerim.net (Postfix) with ESMTP
	id 4EA9B43B12; Thu, 21 Apr 2005 15:55:20 +0200 (CEST)
To: mingo@elte.hu
In-Reply-To: <20050421130242.GA5817@elte.hu>
X-Mailer: Mew version 4.1 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

 > Ingo Molnar [Thu, 21 Apr 2005]:
 > 
 > * Olivier Andrieu <oandrieu@nerim.net> wrote:
 > 
 > >  >  Preprocessor error
 > >  >  make: *** [viz_style.cmx] Error 2
 > > 
 > > That's probably because the configure script didn't find camlp4. 
 > > Camlp4 is a preprocessor for ocaml, it's needed for compiling this 
 > > file (viz_style.ml). Camlp4 is built with the ocaml compilers but some 
 > > package it separately. Try to find and install some ocaml-camlp4 (or 
 > > camlp4) package and then re-run configure.
 > 
 > ah, ok. I installed camlp4-3.08.3-1, and this also solved the other 
 > build problem as well that looked like to be a PATH problem.
 > 
 > when i run git-viz in a git-controlled directory, it seems to start up 
 > fine, but i get an error message: "Could not execute dot". Closing that 
 > window gives me the ability to do an 'Open', but git-viz does not seem 
 > to recognize any of my GIT repositories as such. (perhaps there's some 
 > GIT version dependency? I've got Linus' latest & greatest
 > installed.)

Yes, git-viz uses the `dot' program from the graphviz package (it's in
Fedora Extra too I believe).

 > > The configure script should signal an error when it doesn't find 
 > > camlp4, I'll change that.
 > 
 > fyi, it also didnt check for ocaml and lablgtk.

er, what's weird. Here's what I get :

,----
| $ tar zxf git-viz-0.1.tar.gz
| $ cd git-viz-0.1
| $ ./configure
| checking for ocamlc... ocamlc
| OCaml version is 3.08.2
| OCaml library path is /usr/lib/ocaml
| checking for ocamlopt... ocamlopt
`----

-- 
   Olivier
