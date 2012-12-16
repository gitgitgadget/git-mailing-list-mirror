From: Adam Spiers <git@adamspiers.org>
Subject: compiler checks
Date: Sun, 16 Dec 2012 23:04:11 +0000
Message-ID: <20121216230411.GA3673@gmail.com>
References: <7vvcfwf937.fsf@alter.siamese.dyndns.org>
 <1348170383-15751-1-git-send-email-git@adamspiers.org>
 <7vehlv5hg8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 17 00:04:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkNG4-0003N7-Vl
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 00:04:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519Ab2LPXEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 18:04:14 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:41477 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990Ab2LPXEO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 18:04:14 -0500
Received: from localhost (4.8.9.4.4.5.7.d.4.0.6.a.a.2.0.b.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:b02a:a604:d754:4984])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 958342E5D5
	for <git@vger.kernel.org>; Sun, 16 Dec 2012 23:04:12 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vehlv5hg8.fsf@alter.siamese.dyndns.org>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211616>

On Fri, Sep 21, 2012 at 12:00:55PM -0700, Junio C Hamano wrote:
> Adam Spiers <git@adamspiers.org> writes:
> 
> > It has been rebased on the latest master, and passed a full test run.
> 
> FYI, I applied the attached on top before queuing it in 'pu'.
> 
> Points to note:
> 
>  * We match the underline and the title of documentation header;
> 
>  * a few type mismatches (constness of full_path and treat_gitlink()
>    signature) that broke compilation;

Of course I will incorporate these tweaks in my re-roll, but it
worries me that my environment yielded no compilation issues even
without these tweaks.  Obviously I wouldn't have dreamed of submitting
a patch series which didn't even compile!  I'm using a modern gcc, and
I guess you probably are too?  Which would suggest to me that either
your environment is somehow set up to perform stricter type checking
than mine[1], or that there's a weird compiler-oriented bug somewhere
(e.g. in Makefile).  Or maybe I'm missing something obvious ...

[1] I'm in favour of stricter compiler checks where possible:
    http://article.gmane.org/gmane.comp.version-control.git/211607
