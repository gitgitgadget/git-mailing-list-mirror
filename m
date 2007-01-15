From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: Commit signing
Date: Mon, 15 Jan 2007 10:01:57 -0300
Message-ID: <200701151301.l0FD1vPg007623@laptop13.inf.utfsm.cl>
References: <andyparkins@gmail.com>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 15 19:46:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6VVl-0000PI-Uo
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:20:45 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6VA5-0003eK-AQ
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:58:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbXAONCU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 08:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbXAONCU
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 08:02:20 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:58935 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932287AbXAONCT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 08:02:19 -0500
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [200.1.19.201])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id l0FD1vRL028220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 15 Jan 2007 10:02:02 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id l0FD1vPg007623;
	Mon, 15 Jan 2007 10:01:57 -0300
To: Andy Parkins <andyparkins@gmail.com>
In-Reply-To: Message from Andy Parkins <andyparkins@gmail.com> 
   of "Mon, 15 Jan 2007 11:50:26 -0000." <200701151150.28082.andyparkins@gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 15 Jan 2007 10:02:02 -0300 (CLST)
X-Virus-Scanned: ClamAV 0.88.7/2451/Mon Jan 15 07:27:30 2007 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36848>

Andy Parkins <andyparkins@gmail.com> wrote:

[...]

> Again true.  What has that to do with Git though?  Why shouldn't Git have 
> features that let people with different methods of development from you use 
> it?

As long as nobody else ends up paying the cost...

>     It is certainly true that signed commits /is/ a feature.  And it's a 
> feature that some people might want.  If there isn't a technical argument 
> against it, what does it matter?

It needs to be accomodated in the commit object format, so it means
an(other) incompatible change there. Need to add checking for properly
signed commits all the way when slurping in a stream of changes. Need to
set the whole up so it can bail out as if nothing ever happened in case one
commit doesn't check out (this is probably easy).

> (Note: it doesn't matter enough to me that I would put the time in, I'm 
> arguing in the abstract really - should features be kept out because they 
> allow a development method we would find distasteful?)

I'd vote for "If somebody needs this bad enough, they are free to fork pgit
('paranoid git')", and add "if the changes look sane, and don't screw up
the base (too much), we'll talk about merging back".

Open source development, scratch your own itch, bazaar and all that.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
