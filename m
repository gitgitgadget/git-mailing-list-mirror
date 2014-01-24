From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: Globbing for ignored branches?
Date: Fri, 24 Jan 2014 18:07:39 +0100
Message-ID: <20140124170739.GC396@x4>
References: <20140124090104.GA396@x4>
 <0C723FEB5B4E5642B25B451BA57E273075148284@S1P5DAG3C.EXCHPROD.USA.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jim Garrison <jim.garrison@nwea.org>
X-From: git-owner@vger.kernel.org Fri Jan 24 18:07:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6kEN-0007xw-EW
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 18:07:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbaAXRHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jan 2014 12:07:42 -0500
Received: from ud10.udmedia.de ([194.117.254.50]:38768 "EHLO
	mail.ud10.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537AbaAXRHl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 12:07:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=mail.ud10.udmedia.de; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=beta; bh=T6/IdN3UrjaLyvsCD0VQqQ7kUQ
	nO8eLRMj/2PhD7Boc=; b=BzIrXoR9FqFt4w4eDMotiOOVH9T2mgTZ3JvZBOzX5B
	77G5DcHBBrvAczOcMw4omcClEXQ9YbW2wUeUqyr84VGpo9z43lqrvWBbxezwb2KB
	Say0se716Rt3jxUvCOBWVxxRfmiW16lPaO2Ywml6tkBKAZ69Tdh6u3kOca2SvKY4
	o=
Received: (qmail 24584 invoked from network); 24 Jan 2014 18:07:39 +0100
Received: from unknown (HELO x4) (ud10?360p3@91.64.96.185)
  by mail.ud10.udmedia.de with ESMTPSA (DHE-RSA-AES256-SHA encrypted, authenticated); 24 Jan 2014 18:07:39 +0100
Content-Disposition: inline
In-Reply-To: <0C723FEB5B4E5642B25B451BA57E273075148284@S1P5DAG3C.EXCHPROD.USA.NET>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241016>

On 2014.01.24 at 16:37 +0000, Jim Garrison wrote:
> > -----Original Message-----
> > Behalf Of Markus Trippelsdorf
> > Sent: Friday, January 24, 2014 1:01 AM
> > Subject: Globbing for ignored branches?
> > 
> > I would like to ignore branches that match a certain pattern, e.g.:
> [snip]
> > 
> > Is it possible to ignore all branches that match "hjl"?
>  
> 
> If you mean ignore them when you do "git branch -a", then
> 
> git branch -a |grep -v hjl
> 
> If you mean "ignore" in some other scenario you need to be more
> specific about what you want.

I want to them when I run "git pull".

-- 
Markus
