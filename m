From: Geert Bosch <bosch@adacore.com>
Subject: Re: [WIP PATCH] Add 'git fast-export', the sister of 'git fast-import'
Date: Wed, 21 Nov 2007 07:43:43 -0500
Message-ID: <2348F06A-F9A2-4A8F-8501-D0B696F34388@adacore.com>
References: <Pine.LNX.4.64.0711210336210.27959@racer.site>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 21 13:44:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iuovz-0004xr-3n
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 13:44:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754166AbXKUMnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 07:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753698AbXKUMnq
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 07:43:46 -0500
Received: from rock.gnat.com ([205.232.38.15]:35120 "EHLO rock.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753189AbXKUMnp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 07:43:45 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by filtered-rock.gnat.com (Postfix) with ESMTP id 8FFF22A9661;
	Wed, 21 Nov 2007 07:43:44 -0500 (EST)
Received: from rock.gnat.com ([127.0.0.1])
	by localhost (rock.gnat.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id cRtOnhHolQEI; Wed, 21 Nov 2007 07:43:44 -0500 (EST)
Received: from [172.16.1.98] (sdsl-216-220-103-157.dsl.bway.net [216.220.103.157])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rock.gnat.com (Postfix) with ESMTP id 4F7892A966C;
	Wed, 21 Nov 2007 07:43:44 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711210336210.27959@racer.site>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65641>


On Nov 20, 2007, at 22:40, Johannes Schindelin wrote:
> 	Oh, and it relies on "int" being castable to void * and vice
> 	versa.  Is anybody aware of a platform where this can lead to
> 	problems?

Like any 64-bit system? int is 32 bit and void * is 64.
So, casting a pointer to an int drops half the bits.
When you convert it back it will point to a funny place...

   -Geert
