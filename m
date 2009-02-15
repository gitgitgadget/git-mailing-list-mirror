From: Heikki Orsila <shdl@zakalwe.fi>
Subject: Re: [RFC - draft] List of proposed future changes that are backward incompatible
Date: Mon, 16 Feb 2009 01:20:13 +0200
Message-ID: <20090215232013.GA11543@zakalwe.fi>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 00:50:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYqkh-0002zP-GO
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 00:50:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753118AbZBOXsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 18:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753281AbZBOXsw
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 18:48:52 -0500
Received: from zakalwe.fi ([80.83.5.154]:39895 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753174AbZBOXsv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 18:48:51 -0500
X-Greylist: delayed 1716 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Feb 2009 18:48:51 EST
Received: by zakalwe.fi (Postfix, from userid 1023)
	id D42C12C677; Mon, 16 Feb 2009 01:20:13 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <7vk57ridyx.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110094>

On Sun, Feb 15, 2009 at 01:31:50PM -0800, Junio C Hamano wrote:
> * git-push to update the checked out branch will be refused by default
> 
>   Make "git push" into a repository to update the branch that is checked
>   out fail by default.
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/107758/focus=108007

If this is implemented, it shouldn't, in my opinion, be a default 
setting. I regularly push to checkout repos when I'm doing cross machine 
development. However, I could live with a configurable setting as 
proposed in the given URL. I think Git should not be too cautious about 
following users instructions. The user knows what is best for him/her ;)

-- 
Heikki Orsila
heikki.orsila@iki.fi
http://www.iki.fi/shd
