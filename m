From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-format-patch builtin isn't using git-cherry?
Date: Fri, 23 Jun 2006 14:33:25 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606231431420.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <46a038f90606221732k6d93bcceic2761081d7a7c72b@mail.gmail.com>
 <Pine.LNX.4.63.0606231357420.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060623152321.2c20e9f8.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: martin.langhoff@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 23 14:33:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ftkr0-0000Ah-SW
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 14:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932580AbWFWMdg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 08:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbWFWMdd
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 08:33:33 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:1692 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932580AbWFWMd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 08:33:26 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id BAF2F21EF;
	Fri, 23 Jun 2006 14:33:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id AEADA20F5;
	Fri, 23 Jun 2006 14:33:25 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 922521CB4;
	Fri, 23 Jun 2006 14:33:25 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20060623152321.2c20e9f8.tihirvon@gmail.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22414>

Hi,

On Fri, 23 Jun 2006, Timo Hirvonen wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > Basically, it will involve the following recipe:
> > 
> > 	- add a DIFF_FORMAT_PATCH_ID
> 
> Please don't add any DIFF_FORMAT_*.  I'm cleaning the diff output code
> and replacing diff_options.output_format with one-bit flags.

Okay. For the purposes of git-format-patch, this is not needed anyway, but 
rather a function which takes two tree objects and returns the patch id. 
When you are finished it should be easy to add this as a display format.

Ciao,
Dscho
