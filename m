From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Recent unresolved issues
Date: Sat, 15 Apr 2006 13:46:02 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604151343010.25269@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604141637230.3701@g5.osdl.org> <7vlku7n05x.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604141748070.3701@g5.osdl.org> <Pine.LNX.4.64.0604141751270.3701@g5.osdl.org>
 <7vu08vjra5.fsf@assigned-by-dhcp.cox.net> <7vk69ri5cp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 15 13:46:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUjED-0004Sg-1p
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 13:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbWDOLqE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 07:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbWDOLqE
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 07:46:04 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:27807 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932493AbWDOLqD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Apr 2006 07:46:03 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 1E4EAD17;
	Sat, 15 Apr 2006 13:46:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 12480CFE;
	Sat, 15 Apr 2006 13:46:02 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id E9D83BB3;
	Sat, 15 Apr 2006 13:46:01 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk69ri5cp.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18738>

Hi,

On Sat, 15 Apr 2006, Junio C Hamano wrote:

> Honestly, the longer I look at it, the more I feel that this way
> might break more things than it fixes.  I haven't even looked at
> blame.c or http-push.c to see what's broken yet.

I do not have time to look at this closely, but it sounds to me like you 
need a two-stage approach:

setup_diff_options(&options);
[... set defaults ...]
handle_cmdline_arguments(&options);
[... possibly check if the user overrode some defaults ...]

I think that the unified option parsing is the right approach.

Ciao,
Dscho
