From: Adam Spiers <git@adamspiers.org>
Subject: Re: questions / suggestions about history simplification
Date: Thu, 19 Dec 2013 20:46:03 +0000
Message-ID: <20131219204603.GI23496@pacific.linksys.moosehall>
References: <20131219183645.GD23496@pacific.linksys.moosehall>
 <20131219190333.GE23496@pacific.linksys.moosehall>
 <xmqq38lofv8b.fsf@gitster.dls.corp.google.com>
 <20131219203635.GG23496@pacific.linksys.moosehall>
 <xmqqob4cefti.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 19 21:46:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtkTz-0006W0-BH
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 21:46:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756368Ab3LSUqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Dec 2013 15:46:06 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:45978 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756274Ab3LSUqE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Dec 2013 15:46:04 -0500
Received: from localhost (243.103.2.81.in-addr.arpa [81.2.103.243])
	by coral.adamspiers.org (Postfix) with ESMTPSA id CC1092E30D
	for <git@vger.kernel.org>; Thu, 19 Dec 2013 20:46:03 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <xmqqob4cefti.fsf@gitster.dls.corp.google.com>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239544>

On Thu, Dec 19, 2013 at 12:39:05PM -0800, Junio C Hamano wrote:
> Adam Spiers <git@adamspiers.org> writes:
> 
> > Ah OK, that makes sense now, but not the most intuitive choice of name
> > IMHO.  I would have gone for something like --all-commits, but I guess
> > it's way too late to change now.
> 
> Besides, it is not --all-commits, is it?  We do cull irrelevant side
> branches IIRC.

True, unless (IIUC) --full-history is also specified, in which case no
commit chains are pruned from the walk.

So --all-walked-commits sounds about right.
