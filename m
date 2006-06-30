From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 13] autoconf: Append '-include config.mak.autogen' to config.mak if it is not present
Date: Fri, 30 Jun 2006 22:29:39 +0200
Organization: At home
Message-ID: <e841j7$ne3$1@sea.gmane.org>
References: <200606290301.51657.jnareb@gmail.com> <200606301441.01327.jnareb@gmail.com> <200606301708.19521.jnareb@gmail.com> <200606301711.39635.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Jun 30 22:30:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwPcj-0006gq-13
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 22:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWF3U3w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 16:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWF3U3w
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 16:29:52 -0400
Received: from main.gmane.org ([80.91.229.2]:45203 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751126AbWF3U3v (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jun 2006 16:29:51 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FwPcT-0006eB-C2
	for git@vger.kernel.org; Fri, 30 Jun 2006 22:29:42 +0200
Received: from host-81-190-27-124.torun.mm.pl ([81.190.27.124])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Jun 2006 22:29:41 +0200
Received: from jnareb by host-81-190-27-124.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Jun 2006 22:29:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-27-124.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23017>

Jakub Narebski wrote:

> +grep -q -s -F "-include ${config_file}" config.mak || \
> +        echo  "-include ${config_file}" >> config.mak

Gah, should be of course

+grep -q -s -F -e "-include ${config_file}" config.mak || \
+            echo "-include ${config_file}" >> config.mak

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
