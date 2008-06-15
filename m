From: Sam Vilain <sam@vilain.net>
Subject: Re: git-svn fails
Date: Mon, 16 Jun 2008 09:12:19 +1200
Message-ID: <485585B3.60406@vilain.net>
References: <A869B7C3-4AC3-4592-A0F1-0349B64E07ED@itee.uq.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Guido Governatori <guido@itee.uq.edu.au>
X-From: git-owner@vger.kernel.org Sun Jun 15 23:13:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7zXQ-00081D-EC
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 23:13:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347AbYFOVMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 17:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752378AbYFOVMa
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 17:12:30 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:42706 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752285AbYFOVMa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 17:12:30 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 001EB21C946; Mon, 16 Jun 2008 09:12:28 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=5.0 tests=AWL,BAYES_00 autolearn=ham
	version=3.2.3
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 156D621C662;
	Mon, 16 Jun 2008 09:12:21 +1200 (NZST)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <A869B7C3-4AC3-4592-A0F1-0349B64E07ED@itee.uq.edu.au>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85119>

Guido Governatori wrote:
> I'm trying to convert an svn repository. But when I run
> 
> git svn clone --prefix=file://PATH --sdtlayout URL
> 
> the program exist with an error message like
> 
> r341 = eaa122678de1d79883f578f3f57b73e31f5d7a6d (file%3A//PATH/tags/ 
> NAME)
> fatal: refs/remotes/file%3A//PATH/tags/NAME: not a valid SHA1
> update-ref refs/heads/master refs/remotes/file%3A//PATH/tags/NAME:  
> command returned error: 128
> 
> What am I doing wrong?

Looks like something very strange in your .git/config under the svn
remote section, like a file:// URI placed where something expected a
regular path name.

Sam.
