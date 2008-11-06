From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: multiple-commit cherry-pick?
Date: Thu, 6 Nov 2008 22:37:11 +0100
Message-ID: <20081106213711.GA4334@blimp.localdomain>
References: <buoiqr18tdk.fsf@dhapc248.dev.necel.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Thu Nov 06 22:38:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyCYi-00008H-3R
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 22:38:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbYKFVhS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 16:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbYKFVhR
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 16:37:17 -0500
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:28713 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351AbYKFVhP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 16:37:15 -0500
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx8AE81ptmF
Received: from tigra.home (Fab89.f.strato-dslnet.de [195.4.171.137])
	by post.webmailer.de (mrclete mo27) (RZmta 17.17)
	with ESMTP id k0146ckA6LJrAi ; Thu, 6 Nov 2008 22:37:12 +0100 (MET)
Received: from blimp.localdomain (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id AD5EB277C8;
	Thu,  6 Nov 2008 22:37:11 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 54C4336D27; Thu,  6 Nov 2008 22:37:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <buoiqr18tdk.fsf@dhapc248.dev.necel.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100268>

Miles Bader, Thu, Nov 06, 2008 03:45:27 +0100:
> Is there any easy way to cherry pick a _range_ of commits from some other
> branch to the current branch, instead of just one?
> 
> I thought maybe git-rebase could be coerced to do this somehow, but I
> couldn't figure a way.  [Using git-rebase would be nice because of all the
> useful tools it provides, e.g., the --abort, --continue, and -i options.]
> 

git format-patch --full-index --binary --stdout <range...> | git am -3

This will not work if you want to pick a list, not a range, of
commits.
