From: Marc Singer <elf@buici.com>
Subject: Re: gitweb testing with non-apache web server
Date: Thu, 3 Aug 2006 09:20:38 -0700
Message-ID: <20060803162038.GA1287@buici.com>
References: <20060803075403.GA5238@buici.com> <easbev$act$1@sea.gmane.org> <20060803153403.GA30729@buici.com> <eat5qp$3sr$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 03 18:21:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8fwM-000059-KZ
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 18:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561AbWHCQUk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 12:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932573AbWHCQUk
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 12:20:40 -0400
Received: from 206-124-142-26.buici.com ([206.124.142.26]:2194 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S932561AbWHCQUj
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 3 Aug 2006 12:20:39 -0400
Received: (qmail 1440 invoked by uid 1000); 3 Aug 2006 16:20:38 -0000
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <eat5qp$3sr$1@sea.gmane.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24737>

On Thu, Aug 03, 2006 at 05:48:11PM +0200, Jakub Narebski wrote:
> Marc Singer wrote:
> 
> > That isn't enough.  I did something like that when I was exploring the
> > script.  While the change *does* eliminate the 403 error, it doesn't
> > make the rest of the script work properly.  All of the links return to
> > the same page that lists the projects.
> 
> Strange... PATH_INFO is used _only_ if 'p' parameter is not set. And all
> links use 'p=$project', not PATH_INFO...
> 
> Are you sure you did changes mentioned in earlier post?

Yes.  I think that there is something else awry as well.  Note that
with the change you suggested, the latest script functions at the same
level as the latest from the repo.

TBPH, I've never found a good way to debug CGI scripts.  I just want
to see what is going on and that's hard considering the fact that the
server behavior seems to be a crucial component.  When I run the
script stand-alone, I see the results I expect (with some errors about
the CGI object missing some parameters).


> 
> -- 
> Jakub Narebski
> Warsaw, Poland
> ShadeHawk on #git
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
