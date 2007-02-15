From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] The "table-of-contents" in the update hook script should match the body
Date: Thu, 15 Feb 2007 10:15:46 +0000
Message-ID: <200702151015.47828.andyparkins@gmail.com>
References: <200702141120.32776.andyparkins@gmail.com> <7vy7n0r87y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 15 11:16:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHdeg-0000AH-Ia
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 11:15:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965766AbXBOKPz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 05:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965767AbXBOKPz
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 05:15:55 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:59011 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965766AbXBOKPy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 05:15:54 -0500
Received: by ug-out-1314.google.com with SMTP id 44so100372uga
        for <git@vger.kernel.org>; Thu, 15 Feb 2007 02:15:53 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=E4pd1GnswmW/tjW8iPT/ujrjCthf+ObI/PsxKrxzFA1u2u7b0KJI6bOF9neNTr/155INGUAELQbT+kPs314ldw77J4ZzTjnZMfGSrNM0XWJa8xQ/EGtu9zS7EqEyasrkBqiDIZwvcmEFIAo32yrN8wnKZCdb0BOZ4NB+6KgHzhI=
Received: by 10.67.101.10 with SMTP id d10mr1478127ugm.1171534553253;
        Thu, 15 Feb 2007 02:15:53 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id 53sm1916139ugd.2007.02.15.02.15.50;
        Thu, 15 Feb 2007 02:15:50 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <7vy7n0r87y.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39807>

On Wednesday 2007 February 14 16:53, Junio C Hamano wrote:

> > -newrev_type=$(git-cat-file -t "$newrev")
> > +newrev_type=$(git-cat-file -t $newrev)
> >
> >  case "$refname","$newrev_type" in
> >  	refs/tags/*,commit)
>
> I do not think this hunk is related...

Oops; yes you're right.  I was having trouble with git-cvsserver calling the 
update hook; and that was the fix.  However, it's nothing to do with that 
patch - and I suspect that that fix should more properly be in git-cvsserver.


Andy


-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
