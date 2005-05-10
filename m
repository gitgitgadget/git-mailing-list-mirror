From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH Cogito] cg-init breaks if . contains sub-dir
Date: Tue, 10 May 2005 10:36:09 +0200
Message-ID: <20050510083609.GF11221@kiste.smurf.noris.de>
References: <20050509233904.GB878@osuosl.org> <pan.2005.05.10.03.41.15.683163@smurf.noris.de> <428043EB.7010004@didntduck.org> <20050510075227.GA8176@lug-owl.de> <20050510080445.GB8176@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gerst <bgerst@didntduck.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 10:29:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVQ7B-000800-Gm
	for gcvg-git@gmane.org; Tue, 10 May 2005 10:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbVEJIgg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 04:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbVEJIgc
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 04:36:32 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:63385 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S261580AbVEJIgb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2005 04:36:31 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1DVQDp-0005x1-Rc; Tue, 10 May 2005 10:36:23 +0200
Received: (nullmailer pid 4672 invoked by uid 501);
	Tue, 10 May 2005 08:36:09 -0000
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Content-Disposition: inline
In-Reply-To: <20050510080445.GB8176@lug-owl.de>
User-Agent: Mutt/1.5.6+20040907i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

Jan-Benedict Glaw:
> > 	find * \( -type f -o tyle l \) -print0 | ...
> 
> Btw, this won't find dot files, so using "." as the path list (instead
> of "*") might be wise...
> 
git doesn't want to handle dot files anyway.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
