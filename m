From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: [RFC] Patches exchange is bad?
Date: Tue, 16 Aug 2005 15:09:22 -0700 (PDT)
Message-ID: <20050816220923.42545.qmail@web26301.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 00:10:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E59cd-0005q6-Vn
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 00:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbVHPWJZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 18:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbVHPWJZ
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 18:09:25 -0400
Received: from web26301.mail.ukl.yahoo.com ([217.146.176.12]:58731 "HELO
	web26301.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751107AbVHPWJY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2005 18:09:24 -0400
Received: (qmail 42547 invoked by uid 60001); 16 Aug 2005 22:09:23 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=oLm3hwX2yG5E8C/2XqHgi1HY85Ik6tY4eyHI/q0XsM4szQYNv4PmBzkH1tI5kjL3sXNlMtzwnhkjgjg2xr6QHSeOvM+++YYo6El3q9UpDCu1KoQSKDfH+a24EFMAckULWFJiyaqT9+KMuifhXja/TYWZr2WszCtzFmatYqBkZbI=  ;
Received: from [151.38.74.63] by web26301.mail.ukl.yahoo.com via HTTP; Tue, 16 Aug 2005 15:09:22 PDT
To: martin.langhoff@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Martin Langhoff wrote:

>>From what I understand, you'll want the StGIT infrastructure. If you
>use git/cogito, there is an underlying  assumption that you'll want
>all the patches merged across, and a simple cg-update will bring in
>all the pending stuff.
>

My concerns are both metodologicals and practical:

1) Method: To use the 'free patching workflow' on git is something foreseen in
git design, something coherent with the fork + develop + merge cycle that it
seems, at least to me, THE way git is meant to be used. Or it is stretching 
the possibility of the tool to something technically allowed but not suggested.

2) Practical: The round trip git-format-patch + git-applymbox is the logical and
natural way to reach this goal or, also in this case, I intend to stretch some tools, 
designed for one thing, for something else?


About StGIT, I agree it is the right tool, designed for this kind of problems. But,
peraphs because I don't know it very much, I still can't figure out how to integrate 
StGit in a git GUI, like qgit is, so to have an unified and friendly view of a git 
archive and a patches stack.


Marco



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
