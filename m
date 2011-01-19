From: Alexey Shumkin <zapped@mail.ru>
Subject: Re: Locating Git Clone
Date: Wed, 19 Jan 2011 08:49:37 +0000 (UTC)
Message-ID: <loom.20110119T094539-141@post.gmane.org>
References: <1295426139368-5938712.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 19 09:50:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfTju-0001KH-Gk
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 09:50:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018Ab1ASItw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 03:49:52 -0500
Received: from lo.gmane.org ([80.91.229.12]:54320 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752678Ab1ASItu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 03:49:50 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PfTjf-0001Ev-Mi
	for git@vger.kernel.org; Wed, 19 Jan 2011 09:49:47 +0100
Received: from 212.34.37.3 ([212.34.37.3])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 19 Jan 2011 09:49:47 +0100
Received: from zapped by 212.34.37.3 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 19 Jan 2011 09:49:47 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 212.34.37.3 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/534.10 (KHTML, like Gecko) Chrome/8.0.552.215 Safari/534.10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165246>

flebber <flebber.crue <at> gmail.com> writes:

> 
> 
> I downloaded from git as I was following this walkthrough
> http://www.grails.org/Installation.
> 
> So I issued the command 
> 
>     * git clone git://github.com/grails/grails-core.git
> 
> So that worked no problems, except I don't know where it cloned it to or how
> I can move it. I had intended it to go to c:\grails.
> 
> Is there a way to find a locate something you have cloned?
> 
> Sayth

'git clone URL [FOLDER]' clones repo to FOLDER if it is set
and to basename of URL to your current dir (say PWD) otherwise
I.e. PWD/grails-core (.git suffix is automatically removed) is this case

RTFM )) 
