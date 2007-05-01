From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: svn:externals using git submodules
Date: Tue, 1 May 2007 19:39:16 +0100
Message-ID: <200705011939.17846.andyparkins@gmail.com>
References: <200705011121.17172.andyparkins@gmail.com> <20070501153626.GA21182@pe.Belkin> <200705011936.14345.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Chris Shoemaker <c.shoemaker@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 01 20:39:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HixGC-000545-CU
	for gcvg-git@gmane.org; Tue, 01 May 2007 20:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031268AbXEASjd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 14:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031273AbXEASjd
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 14:39:33 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:51075 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031268AbXEASjc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 14:39:32 -0400
Received: by ug-out-1314.google.com with SMTP id 44so104013uga
        for <git@vger.kernel.org>; Tue, 01 May 2007 11:39:31 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=GR6On9gHEJJmxIYa79wn7HkSyIYZAfSmxgftP6HspvUyXvs1BrXbY4/J7Irt/+Ph3kR1NGgbZsGO23PLMeyP+vI1KqmPPwQNSjxhfZ1OdULQ/E2iBrJGdDkEmeNnK6joc5saOWxmlTm2wlKP9fMWZ+YUmAQQ8g8b0nPQKiCN37U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ok1OeqfdGemj0gT7qLVW7CQO4nagr7diFk5VD9lbwLzLwPIQjxiRveX482fVvJYL0z244omzKquICII/M7Wu/i9SwvOB+PRgHYHSOSRttatDXVNPrn0WDj8Zys0JJkFWFwZVYdH4tzBFbH3mGpvb1xM95bt2z+wLDYD9kZP8UX4=
Received: by 10.67.32.19 with SMTP id k19mr494554ugj.1178044770983;
        Tue, 01 May 2007 11:39:30 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTP id x26sm989157ugc.2007.05.01.11.39.28;
        Tue, 01 May 2007 11:39:29 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <200705011936.14345.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45969>

On Tuesday 2007, May 01, Andy Parkins wrote:

> Now, changes to that file _are_ tracked, in that if I changed the URL
> that change would be recorded in the parent repository.  However,
> nowhere is the revision of the external recorded.  Subversion always
> fetches the latest revision at that URL.

I meant to add as well that this is absolutely NOT the thing that you 
want to be tracked.  There are any number of times while using 
externals that I reorganised a directory only to have to change the 
svn:externals in the parent.  That change is then tracked, so if you 
check out an earlier version not only do you not get a particular 
revision you also don't get the right URL, so subverion doesn't even 
fetch the current version.  Gah!


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
