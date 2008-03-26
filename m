From: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
Subject: Re: Bug in .gitignore handling
Date: Wed, 26 Mar 2008 21:27:49 +0100
Message-ID: <FDBA351C-54DE-406D-930C-7DCE0694A042@orakel.ntnu.no>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Tommy Thorn <tommy-git@thorn.ws>
X-From: git-owner@vger.kernel.org Wed Mar 26 21:28:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JecEg-0002Ov-K3
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 21:28:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757563AbYCZU1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 16:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757423AbYCZU1y
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 16:27:54 -0400
Received: from 97.84-49-228.nextgentel.com ([84.49.228.97]:56410 "EHLO
	eyvind.bernhardsens.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755910AbYCZU1w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 16:27:52 -0400
Received: from vredefort.d.eyvind.bernhardsens.net (vredefort.d.eyvind.bernhardsens.net [172.16.3.223])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by eyvind.bernhardsens.net (Postfix) with ESMTP id 7B76A14C6F0;
	Wed, 26 Mar 2008 21:27:50 +0100 (CET)
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78307>

On 26. mars. 2008, at 21.01, Tommy Thorn wrote:

[...]

> According to the man page, I should be able to change .gitignore to
> "foo/" to stop it from looking recursively, but that doesn't work, as
> now git clean -n -f -d wants to remove mydir/foo but not mydir/foo/ 
> objs
>
> My desperate attempts "./foo" and "^foo" also didn't work. Please note
> that this is a vastly simplified version of the real problem, so I  
> can't
> just use "!mousetrap/foo".
>
> It seems "foo/" _should_ work even though foo isn't a directory.

Have you tried "/foo"?  That should match "foo" only in the root of  
the repository, which is what I think you're trying to do.  "foo/"  
means to only match "foo" if it is a directory.
-- 
Eyvind Bernhardsen
