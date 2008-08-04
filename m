From: Alexander Litvinov <litvinov2004@gmail.com>
Subject: Re: [PATCH] git-svn now work with crlf convertion enabled.
Date: Mon, 4 Aug 2008 10:10:38 +0700
Organization: AcademSoft Ltd.
Message-ID: <200808041010.38491.litvinov2004@gmail.com>
References: <200807231544.23472.litvinov2004@gmail.com> <200808011811.06984.litvinov2004@gmail.com> <37fcd2780808010536v63b2ed2ak31c6d85f2822dc20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 05:11:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPqUB-0000lj-IL
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 05:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754550AbYHDDKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 23:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754302AbYHDDKu
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 23:10:50 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:31901 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754162AbYHDDKu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 23:10:50 -0400
Received: by fg-out-1718.google.com with SMTP id 19so900434fgg.17
        for <git@vger.kernel.org>; Sun, 03 Aug 2008 20:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=lCE3R7AQABB/pusuvt1DkTmLtBLhn5UlueN6sp+QkJQ=;
        b=jOO8s3I+d+eisvI6lJRoWq2Ex/maz0PJxcCHtM0iG0XjXDZ2kfzdKqPAf/9RkX7u1U
         qfIFxs0BqMuSJXPuBmRByR460xvEVTZ8mcQMB+bQBtKhAksHY0X1IChAP/RVUxagqAUF
         iDIbu6MYZVPHCs736XxWtMPlrrlk0XcosGxFw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=CrOdY4DEZIJNN2HvT4sCRWsZsyn6OT1/Up21GbTym/fT1dSXzDpMh7OHOew9A8wLQ9
         VHw5HY74gTi9WxiQfx50q8xnUt4aGXua1o1xKu4lo5rmsiOhA39kfYwRchPIyg4wJAl7
         bROZk0IGEdQpcUpOXZNpovSs/E2WDxJcAO6J0=
Received: by 10.103.131.18 with SMTP id i18mr5253104mun.116.1217819448675;
        Sun, 03 Aug 2008 20:10:48 -0700 (PDT)
Received: from lan.ac-sw.lcl ( [91.201.74.194])
        by mx.google.com with ESMTPS id i5sm14644313mue.2.2008.08.03.20.10.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 03 Aug 2008 20:10:47 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <37fcd2780808010536v63b2ed2ak31c6d85f2822dc20@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91310>

> 2. You do not really need it if the SVN repository has correct eol
> settings, because all files that have svn:eol-style set to either 'native'
> or 'LF' will have LF. Those that do not have svn:eol-style or have it to
> another value should not be subject to CRLF conversion at all.
>
> So, I believe all files received from SVN should be stored as is. Import is
> not about creating new commits, it is about getting history from another
> repository as it is.

I understand the idea now. Some of my files in svn repo are missing eol style 
property at all. Will fix this :-)

Thanks for help !
