From: Sam Vilain <sam@vilain.net>
Subject: Re: git-svn problem with v1.6.5
Date: Wed, 11 Nov 2009 17:02:25 +1300
Message-ID: <4AFA3751.7000709@vilain.net>
References: <4AF9E7FE.3060701@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Wed Nov 11 05:02:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N84Pf-0005YZ-Tn
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 05:02:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836AbZKKECV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 23:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752050AbZKKECV
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 23:02:21 -0500
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:56448 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914AbZKKECV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 23:02:21 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 424E732300;
	Wed, 11 Nov 2009 17:02:26 +1300 (NZDT)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z8+BjVumjaPY; Wed, 11 Nov 2009 17:02:25 +1300 (NZDT)
Received: from [IPv6:2404:130:0:1000:21d:7dff:fe90:5fe0] (unknown [IPv6:2404:130:0:1000:21d:7dff:fe90:5fe0])
	(Authenticated sender: samv)
	by mail.catalyst.net.nz (Postfix) with ESMTPSA id C39BB322EB;
	Wed, 11 Nov 2009 17:02:25 +1300 (NZDT)
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <4AF9E7FE.3060701@obry.net>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132613>

Pascal Obry wrote:
> Hello,
>
> A git-svn mirror is created using Git v1.6.4. When I copy this mirror 
> into another machine which is using v1.6.5 I get the following error:
>
> $ git svn rebase
> fatal: Invalid revision range 
> d2cf08bb67e4b7da33a250127aab784f1f2f58d3..refs/remotes/svn/trunk
> rev-list --pretty=raw --no-color --reverse 
> d2cf08bb67e4b7da33a250127aab784f1f2f58d3..refs/remotes/svn/trunk --: 
> command returned error: 128
>
> Using v1.6.4 instead I have no problem. Any idea to track this problem down?
>   

Did you copy the entire directory across using rsync/tar/etc or 'git
clone' ?   You'll need to make sure that the 'refs/remotes/*' refs look
exactly the same on the clone as they did on the original import repository.

Sam
