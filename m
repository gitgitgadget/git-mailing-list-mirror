From: Christoph Bartoschek <bartoschek@gmx.de>
Subject: Re: Setting http proxy and http password
Date: Tue, 23 Nov 2010 00:32:08 +0100
Organization: =?UTF-8?B?VW5pdmVyc2l0w6R0?= Bonn
Message-ID: <p4brr7-t56.ln1@homer.bruehl.pontohonk.de>
References: <o28rr7-5r4.ln1@homer.bruehl.pontohonk.de> <vpqeiadc6sb.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 23 00:33:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKfsi-0002Ha-Vg
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 00:33:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757817Ab0KVXdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Nov 2010 18:33:03 -0500
Received: from lo.gmane.org ([80.91.229.12]:38264 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757899Ab0KVXdC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Nov 2010 18:33:02 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PKfsb-0002Ek-8o
	for git@vger.kernel.org; Tue, 23 Nov 2010 00:33:01 +0100
Received: from p4ff4ad3b.dip.t-dialin.net ([79.244.173.59])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 00:33:01 +0100
Received: from bartoschek by p4ff4ad3b.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 00:33:01 +0100
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: p4ff4ad3b.dip.t-dialin.net
User-Agent: KNode/4.4.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161918>

Matthieu Moy wrote:

> Christoph Bartoschek <bartoschek@gmx.de> writes:
> 
>> 1. How can I set the proxy that should be used for git commands? For
>> externals pages I have a proxy. But for our git server no proxy should be
>> used. How can I configure git to never use the proxy?
> 
> Search for proxy here:
> 
> http://www.kernel.org/pub/software/scm/git/docs/git-config.html
> 
> but I think the more or less standard $http_proxy environment variable
> does the trick.
> 
>> 2. How can I have git remember the username and password for our git
>> server?
> 
> Either use ~/.netrc (see
> http://www.kernel.org/pub/software/scm/git/docs/howto/setup-git-server-
over-http.txt
> ), or set the URL of the remote repo to
> http(s)://user:password@server.com/path in .git/config (after
> restricting read permissions on this file appropriately, of course).
> 

Thanks for the reply. 

For the first problem I now use the environment variable no_proxy. Adding 
http_proxy="" in front of each git command that communicates with the depot 
is a little bit tedious.

For the second problem I now use the .netrc file.

Christoph
