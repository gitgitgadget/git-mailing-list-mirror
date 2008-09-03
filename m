From: Johan Herland <johan@herland.net>
Subject: Re: Merge seems to get confused by (reverted) cherry-picks
Date: Wed, 3 Sep 2008 13:16:05 +0200
Message-ID: <200809031316.05336.johan@herland.net>
References: <20080903072011.GA14252@atjola.homenet> <7vprnld5ws.fsf@gitster.siamese.dyndns.org> <48BE56BD.6050805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Ittay Dror <ittay.dror@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 13:18:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaqNK-0003nY-G0
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 13:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbYICLRH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 07:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752113AbYICLRF
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 07:17:05 -0400
Received: from sam.opera.com ([213.236.208.81]:52868 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751398AbYICLRE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 07:17:04 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id m83BG5WM032540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 3 Sep 2008 11:16:10 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <48BE56BD.6050805@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94786>

On Wednesday 03 September 2008, Ittay Dror wrote:
> Note: codeville tried to implement a merge algorithm that considers
> the history to decide what the user wants to do:
> http://revctrl.org/PreciseCodevilleMerge. Maybe worth while
> exploring?

You haven't been here long, have you? ;)

There was an infamous mailing list discussion between Bram Cohen (who 
created PreciseCodevilleMerge), and Linus Torvalds back in 2005, 
discussing merge strategies. It is well recounted here:

http://wincent.com/a/about/wincent/weblog/archives/2007/07/a_look_back_bra.php

Also, nowadays, even Bram himself seems to have conceded 
PreciseCodevilleMerge in favour of traditional 3-way merge, at least if 
you look at item #3 in the following posting from his blog:

http://bramcohen.livejournal.com/52148.html



...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
