From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] defaults for where to merge from (take 3)
Date: Fri, 2 Mar 2007 10:05:00 +0100
Message-ID: <81b0412b0703020105o128fc3adq2912e43d5af74dca@mail.gmail.com>
References: <es450f$d58$1@sea.gmane.org> <45E68EDE.2090405@lu.unisi.ch>
	 <81b0412b0703010033w2e1079a3l6ac6e38c59bdefd5@mail.gmail.com>
	 <45E69297.8070001@lu.unisi.ch>
	 <81b0412b0703010059w52a33b54n4d3c25ada6b96369@mail.gmail.com>
	 <45E69EEE.8070905@lu.unisi.ch>
	 <81b0412b0703010212w5367c8cek51f22e9098f8e22f@mail.gmail.com>
	 <7vvehls1h9.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0703010242t36cea2fdr676c1adb799c8077@mail.gmail.com>
	 <7vlkigmeqh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: bonzini@gnu.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Julian Phillips" <julian@quantumfyre.co.uk>,
	"Andy Parkins" <andyparkins@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 02 10:05:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN3hi-0004ZJ-SW
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 10:05:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422744AbXCBJF1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 04:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422741AbXCBJF0
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 04:05:26 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:55095 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933104AbXCBJFB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 04:05:01 -0500
Received: by ug-out-1314.google.com with SMTP id 44so636757uga
        for <git@vger.kernel.org>; Fri, 02 Mar 2007 01:05:00 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fCU+zK4Epu9dMNgWrimuR9P3aCIeQW6iPyZJ3OyDWrdsgmk6yhKiY7oaPZclsXvozrz7QJoKv9d4AZ0NepMgC/zmfj+LWWE1xlR8shnklI7KYh+jK/5wPbQl2sTaX0SYXQCvY9buvXVf9esvv0Ws/2UUk/IQ12qisgF5/OPLfPA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Bitm+MprWh5kLL2VdFjFxjdzfeZKy7r4BmF8n6boSR0DlJPkYa3B09tFPGo+1dAlef3jLf1VHxGy6gwguBnW8xjDxQSu2yLpH7cvyBohjpKe7zfe//GibOq3w3mH4QLP2HtK6UZ3FFsgttZDQTDLBinhYljVikesIlHkmfKOvag=
Received: by 10.78.158.11 with SMTP id g11mr247433hue.1172826300104;
        Fri, 02 Mar 2007 01:05:00 -0800 (PST)
Received: by 10.78.139.9 with HTTP; Fri, 2 Mar 2007 01:05:00 -0800 (PST)
In-Reply-To: <7vlkigmeqh.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41171>

On 3/2/07, Junio C Hamano <junkio@cox.net> wrote:
> "Alex Riesen" <raa.lkml@gmail.com> writes:
>
> > The oldtimers will have no problems changing the default,
> > and the option is properly documented in the patch.
>
> "Old-timers will have no problems" is not a good enough
> justification to change the default.  You need to justify _why_
> it is _they_ who needs to do the extra configuration.
>

I don't know. I wont have any trouble, I think.

I don't even care either way (it is documented, it has
configurable default and it can be switched on or off
in deterministic manner), and will be only slightly
pleased if creation of a tracked branch is more
noticeable (see the mail regarding message on
branch creation).
