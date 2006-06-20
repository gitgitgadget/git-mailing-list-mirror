From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Tue, 20 Jun 2006 19:46:11 +0200
Organization: At home
Message-ID: <e79c8t$8sd$1@sea.gmane.org>
References: <e79921$u0e$1@sea.gmane.org> <87r71jspeo.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Jun 20 19:47:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FskJE-000407-IN
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 19:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWFTRqh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 13:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWFTRqh
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 13:46:37 -0400
Received: from main.gmane.org ([80.91.229.2]:29888 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750728AbWFTRqg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jun 2006 13:46:36 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FskIr-0003wc-HX
	for git@vger.kernel.org; Tue, 20 Jun 2006 19:46:17 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Jun 2006 19:46:17 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Jun 2006 19:46:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22215>

Carl Worth wrote:

> On Tue, 20 Jun 2006 18:51:18 +0200, Jakub Narebski wrote:
>>
>> Any further ideas for other useful features?
>>
> 
> Since you asked...
> 
> From the first time I saw gitweb the feature I wanted was to put
> more useful information in the path of the URL rather than in the
> query string.
> 
> One possible organization might be:
> 
> /<project>/<commitish>/<path>[/<more_path> ...]
> 
> I'd really like to be able to publish nice clean URLs (without any
> query component) for getting at particular branches within projects,
> for example.
> 
> The above might not be entirely feasible in the face of hierachical
> project names containing '/' characters as they might then conflict
> with branch names.

And in the face of topic branches with names like 'js/lsfix' or
'gitweb/config'.

Add to that the fact that above needs some support from web server
(e.g. Apache's mod_rewrite) and web server configuration, while gitweb tries
to be server agnostic...

One of the part of HTML cleanup would be changing order of URL query string,
so that the human readable part is first.


P.S. I have forgot about:
* Check how gitweb.cgi behaves with mod_perl, and correct/add modifications
  to support this mode better (and perhaps also FastCGI if it adds
  anything).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
