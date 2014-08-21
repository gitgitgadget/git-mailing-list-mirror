From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: What's cooking in git.git (Aug 2014, #03; Wed, 20)
Date: Thu, 21 Aug 2014 14:51:11 +0200
Message-ID: <20140821125111.GA68724@book.hvoigt.net>
References: <xmqqlhqisqcy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 14:51:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKRps-0006q6-GE
	for gcvg-git-2@plane.gmane.org; Thu, 21 Aug 2014 14:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841AbaHUMvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 08:51:19 -0400
Received: from smtprelay02.ispgateway.de ([80.67.31.36]:44155 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754838AbaHUMvS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 08:51:18 -0400
Received: from [77.21.76.69] (helo=book.hvoigt.net)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1XKRpj-0007jP-Gk; Thu, 21 Aug 2014 14:51:15 +0200
Content-Disposition: inline
In-Reply-To: <xmqqlhqisqcy.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255610>

On Wed, Aug 20, 2014 at 04:17:33PM -0700, Junio C Hamano wrote:
> * hv/submodule-config (2014-06-30) 4 commits
>   (merged to 'next' on 2014-07-17 at 5e0ce45)
>  + do not die on error of parsing fetchrecursesubmodules option
>  + use new config API for worktree configurations of submodules
>  + extract functions for submodule config set and lookup
>  + implement submodule config cache for lookup of submodule names
> 
>  Will cook in 'next'.

While using the config API for implementing my recursive fetch. I
discovered a bug in my API here. In submodule_from_name() the lookup of
the gitmodule sha1 is missing. So currently you would have to pass in
the gitmodule sha1 instead of the commit sha1 as documented. I will
extend the test and fix this.

Cheers Heiko
