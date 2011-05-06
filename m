From: Luke Diamand <luke@diamand.org>
Subject: git-p4: keeping p4 and git in sync?
Date: Fri, 06 May 2011 22:39:27 +0100
Message-ID: <4DC46A8F.2080809@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 06 23:39:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QISkK-0003Qv-PZ
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 23:39:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932883Ab1EFVjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 17:39:32 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54296 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932837Ab1EFVjb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 17:39:31 -0400
Received: by wya21 with SMTP id 21so2708640wya.19
        for <git@vger.kernel.org>; Fri, 06 May 2011 14:39:30 -0700 (PDT)
Received: by 10.216.67.15 with SMTP id i15mr5195060wed.32.1304717970248;
        Fri, 06 May 2011 14:39:30 -0700 (PDT)
Received: from [86.30.143.167] (cpc4-cmbg14-2-0-cust166.5-4.cable.virginmedia.com [86.30.143.167])
        by mx.google.com with ESMTPS id m84sm1011175weq.36.2011.05.06.14.39.28
        (version=SSLv3 cipher=OTHER);
        Fri, 06 May 2011 14:39:29 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110402 Icedove/3.1.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173014>


I've been using git-p4 to keep a git branch more-or-less tracking a 
perforce repository.

That works well with one person, but with more people it gets harder.

I'd like to get to the point where the two branches are kept in sync 
pretty much automatically, continually (modulo merge conflicts where the 
same lines are touched in git and p4 simultaneously). Right now I'm 
using "git-p4 rebase" manually.

I'm just wondering if anyone else has done this, and what 
experiences/techniques/problems they have?

Thanks
Luke
