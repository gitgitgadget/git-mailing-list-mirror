From: Douglas Stockwell <doug@11011.net>
Subject: Re: gmail smtp server and git-send-mail. Is this combination working?
Date: Thu, 10 Jan 2008 12:45:15 +0900
Message-ID: <fm44ck$299$1@ger.gmane.org>
References: <4d8e3fd30801080858h5f109b47v87abc6b315fcfa08@mail.gmail.com>	 <fm1h7t$nnr$1@ger.gmane.org> <4d8e3fd30801091509q49c02e1dua4ca42805ba891d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 10 04:46:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCoMl-00030p-68
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 04:46:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756215AbYAJDpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 22:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756210AbYAJDpf
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 22:45:35 -0500
Received: from main.gmane.org ([80.91.229.2]:52479 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754854AbYAJDpf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 22:45:35 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JCoMG-0007Dj-O9
	for git@vger.kernel.org; Thu, 10 Jan 2008 03:45:32 +0000
Received: from ie186.opt2.point.ne.jp ([222.225.39.186])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 Jan 2008 03:45:32 +0000
Received: from doug by ie186.opt2.point.ne.jp with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 Jan 2008 03:45:32 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: ie186.opt2.point.ne.jp
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <4d8e3fd30801091509q49c02e1dua4ca42805ba891d6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70038>

Paolo Ciarrocchi wrote:

> Well, it would be nice to add this information to the wiki, it's still
> mentioning
> that you require an external program for supporting the TLS connection.
> I'll do that when I'll get my box working with the configuration you suggested,
> 
> What I'm getting at the moment is:
> paolo@paolo-desktop:~/git$ git-send-email -compose -to
> paolo.ciarrocchi@gmail.com /home/paolo/Desktop/patch/
> snip
> snip
> Can't locate Net/SMTP/SSL.pm in @INC (@INC contains:

As indicated, the module you need is Net::SMTP::SSL, if there is no 
package for ubuntu, you can install it using CPAN:

perl -MCPAN -e 'install Net::SMTP::SSL'

Doug
