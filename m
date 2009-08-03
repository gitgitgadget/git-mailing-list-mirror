From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/3] rebase -i: use "git sequencer--helper --reset-hard"
Date: Mon, 3 Aug 2009 08:29:21 +0200
Message-ID: <200908030829.21424.chriscool@tuxfamily.org>
References: <20090803024023.3794.6487.chriscool@tuxfamily.org> <fabb9a1e0908022158g2578071ewd44bc8d730fb2b8b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 08:30:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXr2X-0000RL-Mk
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 08:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928AbZHCG2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 02:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751881AbZHCG2n
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 02:28:43 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:34362 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751629AbZHCG2n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 02:28:43 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id A289781810F;
	Mon,  3 Aug 2009 08:28:34 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 90528818036;
	Mon,  3 Aug 2009 08:28:31 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <fabb9a1e0908022158g2578071ewd44bc8d730fb2b8b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Monday 03 August 2009, Sverre Rabbelier wrote:
> Heya,
>
> On Sun, Aug 2, 2009 at 19:40, Christian Couder<chriscool@tuxfamily.org> 
wrote:
> > instead of "git reset --hard"
>
> Hmmm, why though? The commit message (either this one or those earlier
> in the series) don't really explain. What are the advantages of using
> this new 'git reset --hard' alternative?

This is part of my work to port git-rebase--interactive.sh to C using code 
from the sequencer project. So the advantage is that it introduces and uses 
the reset_almost_hard() function that will be used in the end when 
everything is done by C code.

Regards,
Christian.
