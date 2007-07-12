From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: mtimes of working files
Date: Thu, 12 Jul 2007 18:27:26 +0100
Message-ID: <1184261246.31598.139.camel@pmac.infradead.org>
References: <f36b08ee0707110808h56ecbc7at9c92727c01cca508@mail.gmail.com>
	 <Pine.LNX.4.64.0707111940080.4516@racer.site>
	 <20070711202615.GE3069@efreet.light.src>
	 <200707120857.53090.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 19:27:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I92Rz-0007m4-2U
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 19:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753076AbXGLR1b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 13:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753151AbXGLR1b
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 13:27:31 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:48192 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071AbXGLR1a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 13:27:30 -0400
Received: from pmac.infradead.org ([2001:8b0:10b:1:20d:93ff:fe7a:3f2c])
	by pentafluge.infradead.org with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1I92Rr-0002XS-48; Thu, 12 Jul 2007 18:27:27 +0100
In-Reply-To: <200707120857.53090.andyparkins@gmail.com>
X-Mailer: Evolution 2.10.2 (2.10.2-2.fc7.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52307>

On Thu, 2007-07-12 at 08:57 +0100, Andy Parkins wrote:
> The only time you get an unnecessary rebuild is if you do
> 
>  git checkout branch1
>  git checkout branch2
>  git checkout branch1
> 
> But we can hardly expect git to be responsible for that. 

Indeed. That's a user error. Git makes it cheap and easy to have
separate _trees_. Just use them -- branches are just another mental
hangover from CVS which we should try to cure ourselves of :)

-- 
dwmw2
