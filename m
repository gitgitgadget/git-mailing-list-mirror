From: =?iso-8859-1?Q?Martin_Storsj=F6?= <martin@martin.st>
Subject: Re: [PATCH] Allow curl to rewind the read buffers
Date: Wed, 1 Apr 2009 19:46:41 +0300 (EEST)
Message-ID: <Pine.LNX.4.64.0904011943560.5901@localhost.localdomain>
References: <Pine.LNX.4.64.0904011809080.5901@localhost.localdomain>
 <7vbprg1h3m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 18:49:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp3bw-0006BG-Fc
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 18:48:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760089AbZDAQqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 12:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759433AbZDAQqs
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 12:46:48 -0400
Received: from smtp2.abo.fi ([130.232.213.77]:48804 "EHLO smtp2.abo.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757866AbZDAQqs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 12:46:48 -0400
Received: from albin.abo.fi (albin.abo.fi [130.232.81.192])
	by smtp2.abo.fi (8.14.3/8.12.9) with ESMTP id n31GkfcX002337;
	Wed, 1 Apr 2009 19:46:41 +0300
X-X-Sender: mstorsjo@localhost.localdomain
In-Reply-To: <7vbprg1h3m.fsf@gitster.siamese.dyndns.org>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (smtp2.abo.fi [130.232.213.77]); Wed, 01 Apr 2009 19:46:41 +0300 (EEST)
X-Virus-Scanned: by foxy.abo.fi (foxy.abo.fi: Wed Apr  1 19:46:41 2009)
X-Scanned-By: MIMEDefang 2.64 on 130.232.213.77
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115402>

On Wed, 1 Apr 2009, Junio C Hamano wrote:

> It may be obvious to people proficient in cURL, but I had to guess that
> you perhaps meant to say "when using multi-pass authentication methods,
> cURL library may need to rewind the read buffers (depending on what is fed
> by the server), and in order to allow the library to do so, we need to
> tell it how by providing the way to manipulate the buffers we supply with
> these IOCTL callbacks."
> 
> Do I understand you correctly?

Yeah, that's exactly correct.

> My point is that the your two-line statement of fact (with a bit more
> explanation of the fact that follows) was clear but it was unclear to me
> how that fact translates to the need of what the patch does.  We would
> want the commit log message to be helpful to people who look at the code 6
> months down the line and wonder why these lines were added.

The original commit comment was a bit vague in retrospect, yes. I'll reply 
with an updated version soon.

Thanks!

// Martin
