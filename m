From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Git clone gives zero file permissions
Date: Thu, 24 Apr 2014 12:18:49 +0200
Message-ID: <5358E509.7070306@viscovery.net>
References: <CACDOErWqjihSYi4r6r8cjfFcbWe+7H0Tihjmkn18Y-szn7cE2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Jussi Peltonen <peltoju@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 24 12:22:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdGmm-0000Ty-8w
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 12:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754421AbaDXKV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 06:21:29 -0400
Received: from so.liwest.at ([212.33.55.14]:58186 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755103AbaDXKS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 06:18:56 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1WdGjx-00045n-V6; Thu, 24 Apr 2014 12:18:51 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id AEEF116613;
	Thu, 24 Apr 2014 12:18:49 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <CACDOErWqjihSYi4r6r8cjfFcbWe+7H0Tihjmkn18Y-szn7cE2g@mail.gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246962>

Am 4/24/2014 10:24, schrieb Jussi Peltonen:
> I installed git to my Windows 7 workstation and cloned
> "http://git.ipxe.org/ipxe.git" by using the Git GUI.
> 
> ipxe-23042014/src tree looks like this in Cygwin bash:
> 
> Files have no permissions, same goes with subfolders, e.g.
> 
> $ ls -l config/
> total 47
> ----------+ 1 peltoju Domain Users  699 Apr 23 09:00 colour.h
> ...

If that's the only problem, then I'd say: don't use Cygwin's ls to look at
these files ;-)

So, really, what is the problem? You are using:

> git-gui version 0.19.GITGUI
> git version 1.9.0.msysgit.0

This doesn't look like Cygwin's git. That there are some discrepancies in
the result produced by Git for Windows is not surprising (but I'm not
saying "is expected").

-- Hannes
