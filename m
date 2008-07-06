From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3] Implement "git stash branch <newbranch> <stash>"
Date: Sun, 6 Jul 2008 14:54:44 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0807061453540.3486@wbgn129.biozentrum.uni-wuerzburg.de>
References: <20080702195947.6117@nanako3.lavabit.com> <alpine.DEB.1.00.0807021447200.9925@racer> <7vvdzo9kkw.fsf@gitster.siamese.dyndns.org> <20080702195401.GA17214@toroid.org> <7vprpw80bw.fsf@gitster.siamese.dyndns.org> <20080703022316.GA25433@toroid.org>
 <7v63rn61yj.fsf@gitster.siamese.dyndns.org> <20080703061605.GB3815@toroid.org> <20080706112333.GA6477@toroid.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Abhijit Menon-Sen <ams@toroid.org>
X-From: git-owner@vger.kernel.org Sun Jul 06 14:55:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFTmM-00054B-CN
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 14:55:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757318AbYGFMyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 08:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757305AbYGFMys
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 08:54:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:54700 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757198AbYGFMyq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 08:54:46 -0400
Received: (qmail invoked by alias); 06 Jul 2008 12:54:45 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp016) with SMTP; 06 Jul 2008 14:54:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/q+NguOL3qNKdllvP463CcnZ5qUZ+My5sFr8/7mv
	J0+sQQc3uLIM+Q
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <20080706112333.GA6477@toroid.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87526>

Hi,

On Sun, 6 Jul 2008, Abhijit Menon-Sen wrote:

> Restores the stashed state on a new branch rooted at the commit on which
> the stash was originally created, so that conflicts caused by subsequent
> changes on the original branch can be dealt with.
> 
> (Thanks to Junio for this nice idea.)
> 
> Signed-off-by: Abhijit Menon-Sen <ams@toroid.org>
> ---
> Reposting as requested with a new test included.

AFAICS the previous version is in 'next' already: 
656b50345239293929ad8c639c5f1941c6b867ad

Hth,
Dscho
