From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 2/3] Only show log entries for new revisions in hooks--update
Date: Tue, 13 Feb 2007 18:08:17 +0000
Message-ID: <200702131808.19291.andyparkins@gmail.com>
References: <200702131424.06983.andyparkins@gmail.com> <7vbqjyymye.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 13 19:11:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH27Z-0002ef-Qd
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 19:11:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbXBMSLP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 13:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbXBMSLP
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 13:11:15 -0500
Received: from wx-out-0506.google.com ([66.249.82.231]:1785 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416AbXBMSLP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 13:11:15 -0500
Received: by wx-out-0506.google.com with SMTP id h31so2355961wxd
        for <git@vger.kernel.org>; Tue, 13 Feb 2007 10:11:14 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dTQUzs8nfWlOTc2b7TtoKpApyk2GhNZmAIknOEcDPsxNdz7kgirfNRFha0OkPcN3nQ4fAUC1+M178YSefU218WXNpGTMVkHuJT5TtyYMhxi+hGgfjg8+wZ8vin1lj8kZGC3X0DagbLHaq+OJ9xHYw43RtHW6NcGVu3+PJ6LMlG4=
Received: by 10.90.104.14 with SMTP id b14mr19611793agc.1171390274455;
        Tue, 13 Feb 2007 10:11:14 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id e34sm12479990ugd.2007.02.13.10.11.10;
        Tue, 13 Feb 2007 10:11:12 -0800 (PST)
User-Agent: KMail/1.9.6
In-Reply-To: <7vbqjyymye.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39569>

On Tuesday 2007, February 13, Junio C Hamano wrote:

> If we want to take this example hook seriously, I suspect that
> the existing mechanism based on hooks.* variables might need to
> be made to allow finer grained, per-branch, control.  I dunno.
>
> Post 1.5.0.

Absolutely - per-branch sounds great.  However, as that is definitely a 
post-1.5.0 topic, I wanted to get the hook that was there in better 
shape for the release.

Until the per-branch work is done, I think this patch is worth having.


Andy
-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
andyparkins@gmail.com
