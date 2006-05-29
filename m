From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] git commit --branch
Date: Mon, 29 May 2006 23:27:04 +0200
Organization: At home
Message-ID: <e5fovc$vqf$1@sea.gmane.org>
References: <20060529202851.GE14325@admingilde.org> <Pine.LNX.4.63.0605292310280.17412@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon May 29 23:29:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkpIV-0006Rx-3k
	for gcvg-git@gmane.org; Mon, 29 May 2006 23:29:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWE2V2x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 17:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWE2V2t
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 17:28:49 -0400
Received: from main.gmane.org ([80.91.229.2]:64174 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751385AbWE2V2P (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 17:28:15 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FkpHB-00066w-SG
	for git@vger.kernel.org; Mon, 29 May 2006 23:27:49 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 May 2006 23:27:49 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 May 2006 23:27:49 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20976>

Johannes Schindelin wrote:

> On Mon, 29 May 2006, Martin Waitz wrote:
> 
>> Sometimes it is neccessary to have some local modifications in the tree
>> in order to test it and work with it.
> 
> Doesn't
> 
> $ git-update-index $(git-ls-files --modified)
> $ git-checkout -b tempBranch
> $ git-commit -m "to test"
> 
> work? 

Added to GitFaq page on GitWiki, under

  "How do I save some local modifications?"
  http://git.or.cz/gitwiki/GitFaq#saving-draft

-- 
Jakub Narebski
Warsaw, Poland
