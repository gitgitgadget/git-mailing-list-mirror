From: nguyenhu@minatec.inpg.fr
Subject: [RFC] Possibility to choose ~/.config/git/config instead of
 ~/.gitconfig
Date: Fri, 25 May 2012 18:15:26 +0200
Message-ID: <20120525181526.Horde.VibLf3wdC4BPv7AeKacSMiA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; DelSp=Yes
Cc: matthieu.moy@grenoble-inp.fr,
	Valentin DUPERRAY <Valentin.Duperray@phelma.grenoble-inp.fr>,
	Franck JONAS <Franck.Jonas@phelma.grenoble-inp.fr>,
	Lucien KONG <Lucien.Kong@phelma.grenoble-inp.fr>,
	Thomas NGUY <Thomas.Nguy@phelma.grenoble-inp.fr>,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@phelma.grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 25 18:47:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXxfZ-0000sW-Cw
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 18:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755311Ab2EYQrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 12:47:13 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:36352 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754194Ab2EYQrM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 May 2012 12:47:12 -0400
X-Greylist: delayed 1902 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 May 2012 12:47:12 EDT
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id A18951A0240;
	Fri, 25 May 2012 18:15:26 +0200 (CEST)
Received: from wifi-030151.grenet.fr (wifi-030151.grenet.fr
 [130.190.30.151]) by webmail.minatec.grenoble-inp.fr (Horde Framework) with
 HTTP; Fri, 25 May 2012 18:15:26 +0200
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198482>

Hello,

As you know, git stores its configuration in ~/.gitconfig file and in  
other hidden files at the root of the user's directory.

We would like to have a configuration directory instead of all these  
configuration files by following the XDG specification because:
- not a lot of hidden files at the root, so better view
- one directory per software in ~/.config

We would like to give to users the possibility to store configuration  
in ~/.config/git/config file.

git would store its configuration in ~/.config/git/config file if:
- this file exists,
- and ~/.gitconfig file doesn't.
Otherwise git would store its configuration in ~/.gitconfig as usual.

If you don't create ~/.config/git/config, there is no change.

What do you think about it ?

I will send you a patch today.

Thanks,

Lucien KONG,
Valentin DUPERRAY,
Huynh Khoi Nguyen NGUYEN,
Thomas NGUY,
Franck JONAS

Grenoble INP ENSIMAG
