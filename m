From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Clone with local alternates?
Date: Wed, 19 Apr 2006 09:39:17 +0100
Message-ID: <1145435957.13200.39.camel@pmac.infradead.org>
References: <1145404132.16166.97.camel@shinybook.infradead.org>
	 <20060418235658.GB8915@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 19 10:39:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FW8Dd-0002To-K3
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 10:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWDSIjW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 19 Apr 2006 04:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWDSIjW
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 04:39:22 -0400
Received: from canuck.infradead.org ([205.233.218.70]:5046 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1750802AbWDSIjV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Apr 2006 04:39:21 -0400
Received: from pmac.infradead.org ([81.187.2.168])
	by canuck.infradead.org with esmtpsa (Exim 4.61 #1 (Red Hat Linux))
	id 1FW8DX-0004Ch-PW; Wed, 19 Apr 2006 04:39:20 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060418235658.GB8915@spearce.org>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18913>

On Tue, 2006-04-18 at 19:56 -0400, Shawn Pearce wrote:
>   git clone --reference=3D/foo git://remote/foo

That's nice. What would be even _nicer_ is if I could enforce its usage
on the server. I keep a clean copy of Linus' kernel tree on the machine
with the git d=C3=A6mon, so I'd like to make it refuse to send any obje=
cts
which are in that tree and which people should already have fetched fro=
m
elsewhere anyway.

--=20
dwmw2
