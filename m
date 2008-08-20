From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Local branch ahead of tracked remote branch but git push
	claims everything up-to-date
Date: Wed, 20 Aug 2008 22:37:58 +0200
Message-ID: <20080820203758.GI16626@blimp.local>
References: <1219263969579-736663.post@n2.nabble.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: ir0s <imirene@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 22:39:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVuSR-0001gs-Ob
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 22:39:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755408AbYHTUiD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 16:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755401AbYHTUiB
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 16:38:01 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:14517 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754830AbYHTUiB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 16:38:01 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg201f5UW7
Received: from tigra.home (Faf2f.f.strato-dslnet.de [195.4.175.47])
	by post.webmailer.de (mrclete mo54) (RZmta 16.47)
	with ESMTP id N03540k7KHe3vm ; Wed, 20 Aug 2008 22:37:59 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 15162277AE;
	Wed, 20 Aug 2008 22:37:59 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 00AE736D18; Wed, 20 Aug 2008 22:37:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1219263969579-736663.post@n2.nabble.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93039>

ir0s, Wed, Aug 20, 2008 22:26:09 +0200:
> $ git push origin remotebranch
> Everything up-to-date

Just (assuming that tracking information is correct)

    git push

or (if you want to be absolutely sure, and be able to find and
understand the fact afterwards in your shells history)

    git push origin HEAD:remotebranch
