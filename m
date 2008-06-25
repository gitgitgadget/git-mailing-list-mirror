From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Errors building git-1.5.6 from source on Mac OS X 10.4.11
Date: Wed, 25 Jun 2008 19:53:11 +0200
Message-ID: <20080625175311.GB4039@steel.home>
References: <2eb980790806250620t73ae0ff7heedb65780a66ad00@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ifejinelo Onyiah <nelo.onyiah@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 19:54:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBZC7-0001fi-FX
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 19:54:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbYFYRxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 13:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751984AbYFYRxP
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 13:53:15 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:34017 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281AbYFYRxO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 13:53:14 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20tf4EbVSQ==
Received: from tigra.home (Fad8f.f.strato-dslnet.de [195.4.173.143])
	by post.webmailer.de (fruni mo57) (RZmta 16.45)
	with ESMTP id w06404k5PHouZo ; Wed, 25 Jun 2008 19:53:12 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 3CA23277BD;
	Wed, 25 Jun 2008 19:53:12 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id EBAA456D2A; Wed, 25 Jun 2008 19:53:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <2eb980790806250620t73ae0ff7heedb65780a66ad00@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86311>

Ifejinelo Onyiah, Wed, Jun 25, 2008 15:20:39 +0200:
> 
> They all run fine but when I issue the make test command, it dies at
> the following:
> 
> % make test
> 
> ... TRUNCATED OUTPUT ...
> 
> *** t2004-checkout-cache-temp.sh ***
> * FAIL 1: preparation
> 

If you don't mind helping the investigation a bit, could you please go
into the t/ directory and run

    bash -x t2004-checkout-cache-temp.sh -d -v -i

and post the output here? This diagnostics are much more useful
(well, essential, in this case). Are running the tests on HFS+, BTW?
