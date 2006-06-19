From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix setting config variables with an alternative GIT_CONFIG
Date: Tue, 20 Jun 2006 01:46:33 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606200145310.26329@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0606200050150.26329@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Jun 20 01:46:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsTS1-0005n3-TX
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 01:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964999AbWFSXqf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 19:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbWFSXqf
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 19:46:35 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:36236 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964999AbWFSXqe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jun 2006 19:46:34 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 536D420FD;
	Tue, 20 Jun 2006 01:46:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 47C262406;
	Tue, 20 Jun 2006 01:46:33 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 2C0241D21;
	Tue, 20 Jun 2006 01:46:33 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
In-Reply-To: <Pine.LNX.4.63.0606200050150.26329@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22145>

Hi,

On Tue, 20 Jun 2006, Johannes Schindelin wrote:

> +	config_filename = getenv("GIT_CONFIG_LOCAL");
> +	if (!config_filename) {
> +		config_filename = getenv("GIT_CONFIG");

Oops. At the other places, GIT_CONFIG overrides GIT_CONFIG_LOCAL, so these 
two must be exchanged in the patch.

Sorry,
Dscho
