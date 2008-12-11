From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: fatal: $HOME not set
Date: Thu, 11 Dec 2008 12:09:32 +0100
Message-ID: <4940F4EC.8070300@viscovery.net>
References: <003a01c95b7c$65b93a40$312baec0$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: JD Guzman <jd@jdguzman.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 12:11:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAjRj-0006HO-Bv
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 12:11:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754708AbYLKLJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 06:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753653AbYLKLJh
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 06:09:37 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:39653 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753867AbYLKLJg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 06:09:36 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LAjQD-0003cd-B8; Thu, 11 Dec 2008 12:09:33 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A90A154D; Thu, 11 Dec 2008 12:09:32 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <003a01c95b7c$65b93a40$312baec0$@com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102793>

JD Guzman schrieb:
> This is probably a really stupid question but I'm trying to run git outside
> of the shell provided by msysgit.
> Everything works however when I try to set config options I get the error in
> the subject line.  I would suspect this is because the windows command
> prompt isn't providing any information about the user's home directory.  My
> question is would this be something that I can set manually or does git rely
> on the OS to provide this information?

You can set it yourself to where you want git to store the .gitconfig
file. Do this in Settings->System->Advanced->Environment Variables,
section User variables. You can set it to %HOMEDRIVE%%HOMEPATH%  in order
point it somewhere below C:\Documents and Settings.

-- Hannes
