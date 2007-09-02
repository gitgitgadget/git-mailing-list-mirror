From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [ANNOUNCE] GIT 1.5.3
Date: Sun, 2 Sep 2007 12:28:00 +0200
Message-ID: <20070902102800.GA11473@steel.home>
References: <7vodglr32i.fsf@gitster.siamese.dyndns.org> <fbdt3q$lcf$1@sea.gmane.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
X-From: git-owner@vger.kernel.org Sun Sep 02 12:28:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRmgz-0006a2-4h
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 12:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756059AbXIBK2G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 06:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756011AbXIBK2F
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 06:28:05 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:44057 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755535AbXIBK2E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 06:28:04 -0400
Received: from tigra.home (Fc93c.f.strato-dslnet.de [195.4.201.60])
	by post.webmailer.de (klopstock mo22) (RZmta 12.3)
	with ESMTP id R0151bj82943mQ ; Sun, 2 Sep 2007 12:28:01 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 1B174277BD;
	Sun,  2 Sep 2007 12:28:01 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id BE910BEAC; Sun,  2 Sep 2007 12:28:00 +0200 (CEST)
Mail-Followup-To: Alex Riesen <raa.lkml@gmail.com>,
	Arkadiusz Miskiewicz <arekm@pld-linux.org>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <fbdt3q$lcf$1@sea.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaFzAPiog==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57313>

Arkadiusz Miskiewicz, Sun, Sep 02, 2007 10:43:38 +0200:
> *** t0001-init.sh ***
> * FAIL 1: plain
> 
>                 (
>                         unset GIT_DIR GIT_WORK_TREE &&
>                         mkdir plain &&
>                         cd plain &&
>                         git init
>                 ) &&
>                 check_config plain/.git false unset
> 
> *   ok 2: plain with GIT_WORK_TREE
> * FAIL 3: plain bare
> 
>                 (
>                         unset GIT_DIR GIT_WORK_TREE GIT_CONFIG &&
>                         mkdir plain-bare-1 &&
>                         cd plain-bare-1 &&
>                         git --bare init
>                 ) &&
>                 check_config plain-bare-1 true unset
> 

Do you have bash-2.05b as /bin/sh ?
