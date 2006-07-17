From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: Re: comparing file contents in is_exact_match?
Date: Mon, 17 Jul 2006 19:37:40 +0200
Message-ID: <17595.51940.887000.442225@lapjr.intranet.kiel.bmiag.de>
References: <20060706055729.GA12512@admingilde.org>
	<87k66p8jee.fsf@mid.deneb.enyo.de>
	<Pine.LNX.4.63.0607080450100.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<87fyh1ncm0.fsf@mid.deneb.enyo.de>
	<f36b08ee0607160803s27dac6a6k476e3dd7742346fc@mail.gmail.com>
	<20060716223607.GA6023@steel.home>
	<87d5c4ajlu.fsf@mid.deneb.enyo.de>
	<Pine.LNX.4.63.0607171439270.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<17595.48003.145000.414361@lapjr.intranet.kiel.bmiag.de>
	<Pine.LNX.4.63.0607171907080.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Florian Weimer <fw@deneb.enyo.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 17 19:40:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G2X35-0006VA-1y
	for gcvg-git@gmane.org; Mon, 17 Jul 2006 19:38:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbWGQRhz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Jul 2006 13:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWGQRhz
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Jul 2006 13:37:55 -0400
Received: from meriadoc.bmiag.de ([62.154.210.133]:65172 "EHLO
	meriadoc.bmiag.de") by vger.kernel.org with ESMTP id S1751094AbWGQRhy
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jul 2006 13:37:54 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by meriadoc.bmiag.de (Postfix) with ESMTP id AA47B3AECB;
	Mon, 17 Jul 2006 19:37:51 +0200 (CEST)
Received: from meriadoc.bmiag.de ([127.0.0.1])
	by localhost (meriadoc [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 19016-07; Mon, 17 Jul 2006 19:37:51 +0200 (CEST)
Received: from eorl.intranet.kiel.bmiag.de (eorl.intranet.kiel.bmiag.de [10.131.2.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by meriadoc.bmiag.de (Postfix) with ESMTP id 343AD3AEC8;
	Mon, 17 Jul 2006 19:37:49 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id 25DBF3BB4D;
	Mon, 17 Jul 2006 19:37:49 +0200 (CEST)
Received: from eorl.intranet.kiel.bmiag.de ([127.0.0.1])
	by localhost (eorl [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 17618-02; Mon, 17 Jul 2006 19:37:44 +0200 (CEST)
Received: from LAPJR (lapjr.intranet.kiel.bmiag.de [10.191.7.182])
	by eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id 2F7C73BB44;
	Mon, 17 Jul 2006 19:37:43 +0200 (CEST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607171907080.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eorl.intranet.kiel.bmiag.de
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at meriadoc.bmiag.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23977>

Johannes Schindelin writes:
 > In my not-so-simple tests, it failed. Reproducibly. If I am not mistaken, 
 > your test just does not hit the problem, namely fork()ing after 
 > rename()ing a mmap()ed file.

No doubt about that.

But until you post additional test cases, I can continue to claim my
version passes all tests:-)

  jr
