From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] "git checkout -- paths..." should signal error
Date: Thu, 29 May 2008 09:05:43 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0805290905020.19665@iabervon.org>
References: <483AC2CE.7090801@gmail.com> <7vy75vvtxo.fsf@gitster.siamese.dyndns.org> <32541b130805280933r573d59d0mf9cdc09f5e5a6a17@mail.gmail.com> <7vfxs2uytm.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0805281326520.19665@iabervon.org>
 <7vskw2tgu2.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0805281455100.19665@iabervon.org> <7v7idetb1h.fsf@gitster.siamese.dyndns.org> <7vtzgirus5.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 29 15:07:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1hq5-0005AX-8y
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 15:06:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756960AbYE2NFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 09:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756689AbYE2NFq
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 09:05:46 -0400
Received: from iabervon.org ([66.92.72.58]:59750 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756950AbYE2NFp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 09:05:45 -0400
Received: (qmail 14465 invoked by uid 1000); 29 May 2008 13:05:43 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 May 2008 13:05:43 -0000
In-Reply-To: <7vtzgirus5.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83195>

On Wed, 28 May 2008, Junio C Hamano wrote:

> When "git checkout -- paths..." cannot update work tree for whatever
> reason, checkout_entry() correctly issued an error message for the path to
> the end user, but the command ignored the error, causing the entire
> command to succeed.  This fixes it.

Acked-by: Daniel Barkalow <barkalow@iabervon.org>
