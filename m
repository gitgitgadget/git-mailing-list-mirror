From: Johan Herland <johan@herland.net>
Subject: Re: What's cooking in git.git (May 2009, #02; Sun, 17)
Date: Mon, 18 May 2009 15:36:39 +0200
Message-ID: <200905181536.39508.johan@herland.net>
References: <7vab5ci281.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Peter Hutterer <peter.hutterer@who-t.net>
X-From: git-owner@vger.kernel.org Mon May 18 15:37:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M631Y-0002Qu-8E
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 15:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752221AbZERNgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 09:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752036AbZERNgu
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 09:36:50 -0400
Received: from sam.opera.com ([213.236.208.81]:49650 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751951AbZERNgu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 09:36:50 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id n4IDadXL030515
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 18 May 2009 13:36:45 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <7vab5ci281.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119441>

On Sunday 17 May 2009, Junio C Hamano wrote:
> [Will merge to "master" soon]
>
> * ph/submodule-rebase (Fri Apr 24 09:06:38 2009 +1000) 1 commit 
>  + git-submodule: add support for --rebase.

Just a quick question before this ends up in 'master'. I'm sorry if this 
has already been answered:

Why only --rebase, and not also --merge?

I certainly don't have anything against "git submodule update --rebase", 
and I support its inclusion, but why not also "--merge"? While --rebase 
calls "git rebase" instead of "git checkout", --merge would call "git 
merge" instead. I believe there are useful workflows where --merge 
would be a better fit than --rebase.

Now, my question should not stop this feature from going into 'master', 
except for the fact that if we also want to support merge, we should 
rename the associated config variable:

Instead of

  submodule.<name>.rebase = true/false (false if unset)

we should have something like

  submodule.<name>.resolve = checkout/rebase/merge (checkout if unset)


Hmm?

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
