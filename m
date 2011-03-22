From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Actually use retval
Date: Tue, 22 Mar 2011 19:20:14 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1103221918540.1561@bonsai2>
References: <cover.1300798069.git.johannes.schindelin@gmx.de> <91afab0d46939238dd7c90ea2902b02cae083316.1300798069.git.johannes.schindelin@gmx.de> <7v7hbrkovz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 19:20:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q26Bu-0000ku-DT
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 19:20:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756612Ab1CVSUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 14:20:21 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:50213 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750910Ab1CVSUT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 14:20:19 -0400
Received: (qmail invoked by alias); 22 Mar 2011 18:20:16 -0000
Received: from pD9EB235B.dip0.t-ipconnect.de (EHLO noname) [217.235.35.91]
  by mail.gmx.net (mp014) with SMTP; 22 Mar 2011 19:20:16 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19WNoZFv/NWelvnk5uFzgb/thRYaYHDT3eLe1huWc
	5oTTWqAgQcUYhD
X-X-Sender: gene099@bonsai2
In-Reply-To: <7v7hbrkovz.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169758>

Hi,

On Tue, 22 Mar 2011, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > This is most likely a bug. Nocited by gcc 4.6.0.
> 
> While I don't doubt gcc 4.6.0 found the retval assigned is not used, I 
> think you misunderstood the value returned from this function.

Nope. I did not misunderstand. I did not understand in the first place. 
That is what I described pretty explicitly in the cover letter.

> The caller uses the return value to decide if an entry from t1 (and not 
> from t2) was consumed, if an entry each from both t1 and t2 were 
> consumed, or an entry from t2 (and not from t1) was consumed.  It 
> doesn't change the fact that the entry at the beginning of each tree we 
> looked at in this function at that point shared the same name and we 
> consumed them, whatever the call to diff_tree_sha1() to run a recursive 
> comparison between the trees found.
> 
> The likely fix would be to remove assignment to retval instead.

Thanks, that is the alternative I suggested after the dashdashdash.

Ciao,
Johannes
