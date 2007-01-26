From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 1/2] UNIX reference time of 1970-01-01 00:00 is UTC timezone, not local time zone
Date: Fri, 26 Jan 2007 09:43:54 +0000
Message-ID: <200701260943.55735.andyparkins@gmail.com>
References: <200701260858.48212.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 26 10:44:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HANcs-0007cl-UV
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 10:44:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161005AbXAZJoA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 04:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161006AbXAZJoA
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 04:44:00 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:19031 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161005AbXAZJn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 04:43:59 -0500
Received: by ug-out-1314.google.com with SMTP id 44so670684uga
        for <git@vger.kernel.org>; Fri, 26 Jan 2007 01:43:58 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=PPpJBL1WYU5AGsnQT09BYEqalX/hajE04JDxcVaOkXseU8KQxWL5vhuTJodPPfmUsuT2FhMR0NCa6SBUiFe5ygETOjfwAv3h4SSK9qBco7SnMaFESxO8Mv6CtvBeC3JPMlYkS94ANUOXK2SQpJgrjdH2FPGk99/B+6zwEmlXMD4=
Received: by 10.67.89.5 with SMTP id r5mr4035833ugl.1169804638368;
        Fri, 26 Jan 2007 01:43:58 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id o1sm3401490uge.2007.01.26.01.43.57;
        Fri, 26 Jan 2007 01:43:57 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <200701260858.48212.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37825>

On Friday 2007 January 26 08:58, Andy Parkins wrote:

> This of course means that the --date argument to date is specified in
> local time, not UTC.  So when the hooks--update script does this:
>
> date=$(date --date="1970-01-01 00:00:00 +0000 $ts seconds")

Bugger.  This description is wrong.  I've shown the fixed version not the 
original.  This line should have read

 date=$(date --date="1970-01-01 00:00:00 $ts seconds")

Sorry - patch was fine, message needs that change to make sense though.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
