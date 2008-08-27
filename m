From: Stefan Naewe <stefan.naewe+git@gmail.com>
Subject: Re: Problems with importing Adobe Opensource SVN repos
Date: Wed, 27 Aug 2008 08:00:17 +0000 (UTC)
Message-ID: <loom.20080827T075256-86@post.gmane.org>
References: <c7d83d0d0808261548o1614b025i80f4ce34f0b161cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 27 10:01:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYFyH-0007i7-Ch
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 10:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752620AbYH0IAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 04:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752462AbYH0IAh
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 04:00:37 -0400
Received: from main.gmane.org ([80.91.229.2]:40072 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752432AbYH0IAg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 04:00:36 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KYFx7-00011q-9i
	for git@vger.kernel.org; Wed, 27 Aug 2008 08:00:29 +0000
Received: from lxsrv96.atlas.de ([194.156.172.86])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 08:00:29 +0000
Received: from stefan.naewe+git by lxsrv96.atlas.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 08:00:29 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 194.156.172.86 (Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.0.1) Gecko/2008070208 Firefox/3.0.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93869>

Weyert de Boer <weyert <at> gmail.com> writes:

> 
> Hello!
> 
> I am trying to import some SVN repositories available at Adobe
> Opensource. Mainly I am trying to import the
> repo of Flex. Only I am having trouble to get it imported into GIT.
> The problem is that it keeps asking for the authentication
> credentials.
> 
> I have tried the following commands:
> 
> git svn clone --stdlayout http://opensource.adobe.com/svn/opensource/flex/sdk
> 
> and
> 
> git svn clone --stdlayout http://opensource.adobe.com/svn/opensource/cairngorm
> 
> The results I am getting are as follows:
> 
> git svn clone --stdlayout http://opensource.adobe.com/svn/opensource/flex/sdk
> Authentication realm: <http://opensource.adobe.com:80> Opensource
> Subversion Repository
> Password for 'albinotreefrog':
> 
> This keeps occurring until you cancel the command.
> 
> The information about the Flex SDK repo can be found at:
> http://opensource.adobe.com/wiki/display/flexsdk/Get+Source+Code
> 
> Anyone happen to know what I am doing wrong?
> 
> Thanks in advance,
> 
> Weyert de Boer

I get the same results.
'git svn' tries to access http://opensource.adobe.com with is indeed protected
 by password.

It works for me if I do 
git svn clone  http://opensource.adobe.com/svn/opensource/flex/sdk/trunk
adobe-flex-sdk

Regards,
Stefan
