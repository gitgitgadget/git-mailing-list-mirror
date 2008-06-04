From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: log --graph --first-parent weirdness
Date: Wed, 4 Jun 2008 18:08:26 +0300
Message-ID: <20080604150826.GB3038@mithlond.arda.local>
References: <20080604150042.GA3038@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Simpkins <adam@adamsimpkins.net>
X-From: git-owner@vger.kernel.org Wed Jun 04 17:10:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3ucV-0000pI-OC
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 17:09:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760985AbYFDPIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 11:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760975AbYFDPIa
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 11:08:30 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:55953 "EHLO
	kirsi1.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760945AbYFDPI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 11:08:29 -0400
Received: from mithlond.arda.local (80.220.180.181) by kirsi1.rokki.sonera.fi (8.5.014)
        id 483E837C004CC231; Wed, 4 Jun 2008 18:08:27 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1K3ubC-0001d3-Mt; Wed, 04 Jun 2008 18:08:26 +0300
Content-Disposition: inline
In-Reply-To: <20080604150042.GA3038@mithlond.arda.local>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83788>

Teemu Likonen wrote (2008-06-04 18:00 +0300):

> $ git log --graph --first-parent --pretty=oneline --abbrev-commit
> 
> M   2ba1dba... Merge branch 'topic'
> |\  
> * | b762236... Change from branch 'master'
> * | d7fb80a... Initial commit
>  /
> 
> 
> So, it prints the second parent line but it leads to nowhere. Try the
> same with the git repository and you'll see a _lots_ of parallel
> branch lines which seem to go nowhere.

And by the way, I'm pretty sure that some earlier log --graph version
printed only this with --first-parent:

M   2ba1dba... Merge branch 'topic'
|\  
*   b762236... Change from branch 'master'
*   d7fb80a... Initial commit
