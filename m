From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Do not show progress meter while checking files out.
Date: Fri, 20 Apr 2007 09:12:17 -0400
Message-ID: <20070420131217.GA16077@fieldses.org>
References: <11770585393395-git-send-email-junkio@cox.net> <1177058540390-git-send-email-junkio@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 20 15:12:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HesuV-0006KB-8G
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 15:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993006AbXDTNMT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 09:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993034AbXDTNMT
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 09:12:19 -0400
Received: from mail.fieldses.org ([66.93.2.214]:36487 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2993006AbXDTNMS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 09:12:18 -0400
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HesuP-0004Qu-DF; Fri, 20 Apr 2007 09:12:17 -0400
Content-Disposition: inline
In-Reply-To: <1177058540390-git-send-email-junkio@cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45102>

On Fri, Apr 20, 2007 at 01:42:19AM -0700, Junio C Hamano wrote:
> Originally I thought it would take too long to check out many
> files and to prevent people from getting bored, I added progress
> meter.  But it feels a bit too noisy; let's disable it.

I was just doing a kernel-tree clone on an NFS filesystem yesterday, and
creating 20000 new files over NFS does take some time, so the progress
meter was appreciated.

--b.
