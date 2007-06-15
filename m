From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: [CORRECTED PATCH] Introduce file with the common default build-time items.
Date: Fri, 15 Jun 2007 14:28:48 +0400
Message-ID: <20070615102847.GF3779@void.codelabs.ru>
References: <20070613054316.GN86872@void.codelabs.ru> <20070614043633.GV6073@spearce.org> <20070614095654.GT86872@void.codelabs.ru> <20070614150929.GA18491@spearce.org> <20070614190739.GA3779@void.codelabs.ru> <20070615032204.GC18491@spearce.org> <20070615054002.GD3779@void.codelabs.ru> <46723C9F.4EE044F9@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 12:28:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hz931-0002uz-Kj
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 12:28:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbXFOK2y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jun 2007 06:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbXFOK2y
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jun 2007 06:28:54 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:58017 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108AbXFOK2x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2007 06:28:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:Sender:X-Spam-Status:Subject;
	b=qyQoy/mJpIAXpzXIMEt2cDaRG7qDtvAEzQ/LEdNbu352B0Y4GrMupNe2miyBx0B/CflDtuitJ3u1s341hurpDU0PaiTTe9Xee85TxxSLrqgopS5fzy8aGZPcCsZl49DlZzaN8faAiprotaiwWV8n3fE2EFgnkhU25XPfO/ndPaI=;
Received: from void.codelabs.ru (void.codelabs.ru [144.206.177.25])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1Hz92y-0004eO-GV; Fri, 15 Jun 2007 14:28:52 +0400
Content-Disposition: inline
In-Reply-To: <46723C9F.4EE044F9@eudaptics.com>
X-Spam-Status: No, score=-1.9 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_20
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50257>

Johannes, good day.

Fri, Jun 15, 2007 at 09:15:43AM +0200, Johannes Sixt wrote:
> Eygene Ryabinkin wrote:
> > OK, let us wait for the other's reaction.  May be you're right and
> > it doesn't worth it.  But I always felt that if I can change something
> > by changing it only in one place, then it worth it.  Otherwise I
> > should remember all places where it is used and this leads to errors.
> > But maybe the 'wish' and 'tclsh' are not worth it.
> 
> Huh? This "one place" already exists. Its name is 'config.mak'. I have
> this in it:
> 
> TCL_PATH=tclsh84
> TCLTK_PATH=wish84

config.mak is a bit different: it is not used by the configure when
it sets the default TCL_PATH.  But ok, I feel that my change is not
very good, since two of you already disliked it.  Please, don't
waste your time on it anymore.
-- 
Eygene
