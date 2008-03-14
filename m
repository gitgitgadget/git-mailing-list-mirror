From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] merge-recursive: handle file mode changes
Date: Fri, 14 Mar 2008 13:56:12 +0100
Message-ID: <20080314125612.GA6157@localhost>
References: <20080308171726.GA16129@localhost> <alpine.LSU.1.00.0803081850470.3975@racer.site> <20080313125229.GA24758@localhost> <alpine.LSU.1.00.0803131607030.1656@racer.site> <20080313192246.GA30361@localhost> <alpine.LSU.1.00.0803132216580.4174@racer.site> <20080313224741.GA5000@localhost> <frcg66$2nb$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 13:57:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja9T1-00044w-Qg
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 13:57:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869AbYCNM4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 08:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752736AbYCNM4U
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 08:56:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:25038 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722AbYCNM4T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 08:56:19 -0400
Received: by ug-out-1314.google.com with SMTP id z38so56465ugc.16
        for <git@vger.kernel.org>; Fri, 14 Mar 2008 05:56:16 -0700 (PDT)
Received: by 10.66.220.12 with SMTP id s12mr355105ugg.15.1205499376264;
        Fri, 14 Mar 2008 05:56:16 -0700 (PDT)
Received: from darc.dyndns.org ( [88.117.54.52])
        by mx.google.com with ESMTPS id o30sm1456735ugd.84.2008.03.14.05.56.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Mar 2008 05:56:14 -0700 (PDT)
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1Ja9SG-0001dm-Pp; Fri, 14 Mar 2008 13:56:12 +0100
Content-Disposition: inline
In-Reply-To: <frcg66$2nb$1@ger.gmane.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77216>

On Fri, Mar 14, 2008 at 01:17:10AM +0100, Jakub Narebski wrote:
> > Handle file mode changes similarly to changes of content. If the file mode
> > changed in only one branch, keep the changed version. If the file mode
> > changed in both branches, prompt the user to choose one by reporting a
> > conflict.
> 
> Shouldn't it print "CONFLICT(mode/mode)" then?

I think currently the only way to get a mode conflict is when a file is added
in both branches with different permissions, since we only track the executable
bit.

Clemens
