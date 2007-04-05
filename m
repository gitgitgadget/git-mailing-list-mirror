From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: [PATCH 2/4] Fix drop-down menus in the git-gui dialogs.
Date: Thu, 5 Apr 2007 16:49:20 +0400
Message-ID: <20070405124920.GV26348@codelabs.ru>
References: <20070327103005.GP14837@codelabs.ru> <20070404163709.GA5167@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Apr 05 14:49:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZRPA-0007Ao-0q
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 14:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766970AbXDEMt3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 08:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766972AbXDEMt3
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 08:49:29 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:61863 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1766970AbXDEMt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 08:49:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:Sender:X-Spam-Status:Subject;
	b=EzJRs6gvhzwXx2repwgoErx8L+DYh/mEHda/pdPZWpTDnPhruAP1NljCrNlAQkt1NMensSOKpG6L6nAJwqOhlWTYdPnOw9r86yWGelrJU3DfJFPVLSpbCsJ+ANm4SwuznkQ6u/UF24MtCt0OL7Bb4eYw5FoMGbPB1XayuxO5LWE=;
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HZRP5-000N2N-13; Thu, 05 Apr 2007 16:49:27 +0400
Content-Disposition: inline
In-Reply-To: <20070404163709.GA5167@spearce.org>
X-Spam-Status: No, score=-2.5 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_05
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43821>

Shawn, good day.

Wed, Apr 04, 2007 at 12:37:09PM -0400, Shawn O. Pearce wrote:
> git-gui patches should be addressed to me, not Paul.

Yep, I just messed with the mail addresses, since I was doing patches
both for gitk and git-gui. Sorry for it!

> > Error was fixed by "grab"bing the drop-down menu windows on their
> > activation. Now all drop-down menus are disappearing once the mouse
> > button is depressed, no matter what is the current position of the
> > mouse pointer.
> 
> This fix actually horribly breaks on Mac OS X.  The problem
> appears to be that the <Visibility> event on that system doesn't
> get delivered until after the menu is destroyed, yet I'm getting
> a %s of VisibilityUnobscured in the event handler.  Go figure.
>
> So anyway, I cannot apply this patch as-is, because it breaks
> my main development system.  I understand and feel your pain,
> but you either need to make this binding apply only on your OS,
> or find another way to workaround that Tk bug...

OK, I will try to find the other workaround, but I have no Mac OS
X at hand (they are a bit expensive to me), so I hope you will find
some time to test the new approaches, if I will come up with any.

Thank you!
-- 
Eygene
