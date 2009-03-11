From: Bernie Innocenti <bernie@develer.com>
Subject: Re: Obfuscated error message
Date: Wed, 11 Mar 2009 05:28:50 +0100
Organization: Develer s.r.l. - http://www.develer.com/
Message-ID: <49B73E02.7040406@develer.com>
References: <49B73D1A.4050605@codewiz.org>
Reply-To: bernie@codewiz.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Giovanni Bajo <rasky@develer.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 11 05:37:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhGBk-0008QT-7d
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 05:37:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbZCKEfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 00:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbZCKEfg
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 00:35:36 -0400
Received: from trinity.develer.com ([89.97.188.34]:40022 "EHLO
	trinity.develer.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbZCKEff (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 00:35:35 -0400
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Mar 2009 00:35:35 EDT
Received: (qmail 32028 invoked from network); 11 Mar 2009 04:28:51 -0000
Received: from static-217-133-10-139.clienti.tiscali.it (HELO ?10.4.4.169?) (bernie@217.133.10.139)
  by trinity.develer.com with ESMTPA; 11 Mar 2009 04:28:51 -0000
User-Agent: Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <49B73D1A.4050605@codewiz.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112879>

Bernie Innocenti wrote:
> A friend who uses Mercurial pointed this out as a reson why
> Git is evil:
> 
> rasky@lilax:~/src$ git clone git://www.develer.com/doesnt-exist
> Initialized empty Git repository in /home/rasky/src/doesnt-exist/.git/
> fatal: The remote end hung up unexpectedly
> 
> Plus, the directory was not really there :-)
> 
> rasky@lilax:~/src$ hg clone hg://www.develer.com/doesnt-exist
> abort: repository hg://www.develer.com/doesnt-exist not found!
> 
> rasky@lilax:~/src$ svn co svn://www.develer.com/doesnt-exist
> svn: URL 'svn://www.develer.com/doesnt-exist' doesn't exist
> 

And another really nasty one:

trinity:~/foo$ git init
Initialized empty shared Git repository in /home/bernie/foo/.git/
trinity:~/foo$ git push
fatal: 'origin': unable to chdir or not a git archive
fatal: The remote end hung up unexpectedly

Both are with git HEAD as of today.

-- 
   // Bernie Innocenti - http://www.codewiz.org/
 \X/  Sugar Labs       - http://www.sugarlabs.org/
