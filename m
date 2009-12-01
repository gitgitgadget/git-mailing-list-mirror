From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] git-merge: a deprecation notice of the ancient command
 line syntax
Date: Mon, 30 Nov 2009 22:55:58 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0911302251270.5820@xanadu.home>
References: <cover.1259524136.git.brlink@debian.org>
 <7v8wdnooza.fsf@alter.siamese.dyndns.org>
 <20091201071234.6117@nanako3.lavabit.com>
 <7vmy23bl4o.fsf@alter.siamese.dyndns.org>
 <7vaay3bkyx.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	"Bernhard R. Link" <brlink@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 04:56:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFJqa-0000WF-1W
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 04:56:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601AbZLAD4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 22:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752107AbZLAD4E
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 22:56:04 -0500
Received: from relais.videotron.ca ([24.201.245.36]:25219 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752446AbZLAD4D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 22:56:03 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KTY008AQG9AQGX1@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 30 Nov 2009 22:55:59 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vaay3bkyx.fsf_-_@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134162>

On Mon, 30 Nov 2009, Junio C Hamano wrote:

> The ancient form of git merge command used in the original sample script
> has been copied from Linus and are still found everywhere, I think, and
> people may still have it in their scripts, but on the other hand, it is so
> unintuitive that even people reasonably familiar with git is surprised by
> accidentally triggering the support to parse this ancient form.
> 
> Gently nudge people to upgrade their script to more recent and readable
> style for eventual removal of the original syntax.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>     And this is the first step of such a deprecation.  Perhaps we start
>     warning in 1.7.0 and remove it in 1.8.0, or something like that.

If this is going to be removed in the future, then it is already 
deprecated.  Therefore it is much better to start warning now and not 
wait for 1.7.0.  There is just no point delaying the advice.


Nicolas
