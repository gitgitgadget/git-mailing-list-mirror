From: Kevin <compufreak@gmail.com>
Subject: Re: Git commit error: fatal: Repository has been updated, but unable
 to write new_index file.
Date: Tue, 27 Mar 2012 14:20:45 +0200
Message-ID: <20120327122045.GA7421@ikke-laptop.buyways.nl>
References: <34E530A4-A792-42AC-8C19-5F7CB71FA46C@jetbrains.com>
 <jks9k9$c35$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Ben Tebulin <nntp.20.jexpert@spamgourmet.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 14:20:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCVOS-0001gA-3K
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 14:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753216Ab2C0MUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 08:20:51 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36550 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752997Ab2C0MUu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 08:20:50 -0400
Received: by wibhq7 with SMTP id hq7so5438281wib.1
        for <git@vger.kernel.org>; Tue, 27 Mar 2012 05:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=4Dbf5W+JJ/ppGZVGTBxmOBcw1axdkd8snCZg25G2qpg=;
        b=iM9CfvckReR4I9rgSnhZyPGL2u0b3lEIdkYFZAvHwn51NWGyDwtiv8mYuPS5/rhiIX
         m8HvOwdaRMcWVwpg6UXZd03wK3/eh7GQXgrXvHb8cuCavKS6f/AhAVozYwQI1GByyFIY
         B47rYErKDSzsJhFthRv85LkTmB5WT/9z6LkeRCZ/cjOR8EpfdpA/M6dPzs2U61JgpLyh
         hvkdoRH5MUqjTsvA8zGRBE7lfpEty20/ibltwhJ8tOt+IKR4VhAeZnAbMrppABbCuBng
         SiJ1NoP+ylLlS85ZnBsUHMexQdYeJ3DtAlMAFjUMuarj7NNOktyHSV4YPXkjr18CZV12
         h0TA==
Received: by 10.216.138.135 with SMTP id a7mr15017236wej.19.1332850849251;
        Tue, 27 Mar 2012 05:20:49 -0700 (PDT)
Received: from localhost (D4B2749A.static.ziggozakelijk.nl. [212.178.116.154])
        by mx.google.com with ESMTPS id bx13sm49052877wib.10.2012.03.27.05.20.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 27 Mar 2012 05:20:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <jks9k9$c35$1@dough.gmane.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194041>

One hint that this is a windows issue is that all the reporters seem to
use msysgit.

(added msysgit mailinglist as cc)

On Tue, Mar 27, 2012 at 01:51:48PM +0200, Ben Tebulin wrote:
> >fatal: Repository has been updated, but unable to write new_index
> >file. Check that disk is not full or quota is not exceeded, and then
> >"git reset HEAD" to recover.
> >
> >Here is the command which IDE executes to make a commit:
> >
> ># git commit --only -F<message file>  -- <several files chosen to
> >commit>
> 
> I can confirm this issue. I saw this error more than once. And I'm
> working with cygwin Git on the command line - but having an IDE (VS
> in this case) opened in parallel.
> 
> I don't think the issue is about two parallel Git operations in
> parallel. I only started one. But more that some file of the working
> copy is in access. And Git seems to be much more sensible about
> those than i.e. subversion. (No file was "locked")
> 
> Sorry - but I cannot tell anything more except that I've experienced
> this issue too. Maybe this is a  windows specific issue? As a
> windows user I had some of them...
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
