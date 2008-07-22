From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Difficulty with getting an accurate changelog after
	cherry-picking and merging.
Date: Tue, 22 Jul 2008 23:09:24 +0200
Message-ID: <20080722210924.GE5113@blimp.local>
References: <7dc909980807221338g707d6104ob8b1534cdf02a77a@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: luuk@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 22 23:10:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLP7p-000504-Q7
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 23:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754817AbYGVVJ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 17:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755198AbYGVVJ0
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 17:09:26 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:31765 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753104AbYGVVJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 17:09:26 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg2r44jepV
Received: from tigra.home (Fa955.f.strato-dslnet.de [195.4.169.85])
	by post.webmailer.de (mrclete mo6) (RZmta 16.47)
	with ESMTP id z00c36k6MKnh8e ; Tue, 22 Jul 2008 23:09:24 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 1C300277BD;
	Tue, 22 Jul 2008 23:09:24 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 1ABF736D17; Tue, 22 Jul 2008 23:09:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7dc909980807221338g707d6104ob8b1534cdf02a77a@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89530>

Luuk Paulussen, Tue, Jul 22, 2008 22:38:19 +0200:
> I'm trying to generate an accurate changelog of changes between 2 tags
> on a branch.  There is a merge between these 2 points which includes
> changes that were cherry-picked before the start point.  This causes
> the changelog to show these changes, despite them already existing
> before the start point of the log.

Cherry-picked commits are completely new commits and have no relation
to the original commits whatsoever. Of course, they will be shown.
It is literally a change made again, as if you typed it all in and
committed.
