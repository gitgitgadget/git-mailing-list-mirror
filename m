From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: [PATCH 2/2] Cached the git configuration, which is now noticibly
   faster on windows.
Date: Mon, 10 Nov 2008 01:50:52 -0200
Message-ID: <gf8b2t$5v0$1@ger.gmane.org>
References: <1226114569-8506-1-git-send-email-thestar@fussycoder.id.au> <1226114569-8506-2-git-send-email-thestar@fussycoder.id.au> <7vr65kagvm.fsf@gitster.siamese.dyndns.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 10 04:52:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzNpB-0000mm-HR
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 04:52:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175AbYKJDvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2008 22:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753059AbYKJDvG
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Nov 2008 22:51:06 -0500
Received: from main.gmane.org ([80.91.229.2]:52316 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753017AbYKJDvF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2008 22:51:05 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KzNnp-00030V-K7
	for git@vger.kernel.org; Mon, 10 Nov 2008 03:51:01 +0000
Received: from 201.80.54.37 ([201.80.54.37])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 10 Nov 2008 03:51:01 +0000
Received: from hanwen by 201.80.54.37 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 10 Nov 2008 03:51:01 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 201.80.54.37
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <7vr65kagvm.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100488>

Hi Junio,

I haven't been involved with git-p4 for a long time.  I'm not really fit 
for judging these patches.


Junio C Hamano escreveu:
> These are patches to fast-import/git-p4, which you two seem to in charge
> of.
> 
>     From:	John Chapman <thestar@fussycoder.id.au>
>     Subject: [PATCH 1/2] Added support for purged files and also optimised memory usage.
>     Date:	Sat,  8 Nov 2008 14:22:48 +1100
>     Message-Id: <1226114569-8506-1-git-send-email-thestar@fussycoder.id.au>
> 
>     From:	John Chapman <thestar@fussycoder.id.au>
>     Subject: [PATCH 2/2] Cached the git configuration, which is now noticibly faster on windows.
>     Date:	Sat,  8 Nov 2008 14:22:49 +1100
>     Message-Id: <1226114569-8506-2-git-send-email-thestar@fussycoder.id.au>
> 
> It was unfortunately not immediately obvious from the Subject: line what
> these patches are about, and I am guessing you missed them because of that.


-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
