From: John Keeping <john@keeping.me.uk>
Subject: Re: Bug with rev-list --reverse?
Date: Thu, 18 Apr 2013 11:26:44 +0100
Message-ID: <20130418102644.GY2278@serenity.lan>
References: <CAMP44s25mUA1M+K+YKaC=bz3Dr7kSDyXK5g2ot8i+1EPy8zRhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 12:27:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USm3P-00072Z-2B
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 12:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965302Ab3DRK0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 06:26:54 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:46698 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964916Ab3DRK0x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 06:26:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 8082ECDA5E5;
	Thu, 18 Apr 2013 11:26:52 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uIHDSBe3u6UK; Thu, 18 Apr 2013 11:26:49 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id DC17DCDA5E3;
	Thu, 18 Apr 2013 11:26:46 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CAMP44s25mUA1M+K+YKaC=bz3Dr7kSDyXK5g2ot8i+1EPy8zRhA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221644>

On Thu, Apr 18, 2013 at 05:17:14AM -0500, Felipe Contreras wrote:
> If I do these:
> 
> % git log --oneline -1 v1.8.1.5^..v1.8.1.6
> % git log --oneline --reverse -1 v1.8.1.5^..v1.8.1.6
> 
> I expect to get a different output, and not both showing v1.8.1.6.
> Wouldn't you agree?

I expect to get the same output.  This is probably because I consider
--reverse to be an output filter.  So I expect to show the commits
"v1.8.1.5^..v1.8.1.6 -1" which selects a single commit and then show
that in reverse order.
