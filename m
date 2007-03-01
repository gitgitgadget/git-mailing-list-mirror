From: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: defaults for where to merge from
Date: Thu, 01 Mar 2007 09:29:18 +0100
Message-ID: <45E68EDE.2090405@lu.unisi.ch>
References: <es450f$d58$1@sea.gmane.org>	 <200702281522.14965.andyparkins@gmail.com>	 <Pine.LNX.4.64.0702281526270.15314@reaper.quantumfyre.co.uk>	 <Pine.LNX.4.63.0702281643200.22628@wbgn013.biozentrum.uni-wuerzburg.de>	 <81b0412b0702281045u2e511ebfie14a7b718531f8c4@mail.gmail.com>	 <45E5DE8A.2080101@lu.unisi.ch>	 <81b0412b0702281607l6f9b1cadg9f3a84b06b9acd7d@mail.gmail.com>	 <Pine.LNX.4.63.0703010221000.22628@wbgn013.biozentrum.uni-wuerzburg.de>	 <81b0412b0702282355i176ad7e5t7b9e417b27e524fb@mail.gmail.com>	 <45E68897.8000607@lu.unisi.ch> <81b0412b0703010010o24513f60x937b5af52362e0c8@mail.gmail.com>
Reply-To: bonzini@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 09:29:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMgfI-0000rN-MM
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 09:29:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932664AbXCAI30 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 03:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933087AbXCAI30
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 03:29:26 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:8710 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932664AbXCAI3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 03:29:25 -0500
Received: by nf-out-0910.google.com with SMTP id o25so822703nfa
        for <git@vger.kernel.org>; Thu, 01 Mar 2007 00:29:24 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=QnCo/Y+WfJ+dME6dYz25qwKOESOkOIjrEfhibNytA0S9NC5Tp8bJgL42FWmRD/Aehg3mSy3SJZ550LPTWH6meJSC5xuEzEyJFmf8MSc0+WcryCEc4j2BlcaRwlMbCMo/Yxl3NadasAU8hlYRaZo48YZvUmibaqw9pJQDndtzOz0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=SfvQit8loSZvICLk1CGKQspMnTKdMLEQlHNcGb8Vnn9kcutjhGnh0QVon4wKd5xXu0u9fNZhCn0akLo5CSfIz6uXDKXdTlt2PtX5L4MI/c5kPy+D+3Trpi847k29mPM5Zp539ODbXbuW089SwOGEffAWRQTa3ycCl5BWvd3IZ3c=
Received: by 10.49.54.3 with SMTP id g3mr5284380nfk.1172737764708;
        Thu, 01 Mar 2007 00:29:24 -0800 (PST)
Received: from ?192.168.76.141? ( [195.176.176.226])
        by mx.google.com with ESMTP id y2sm6200577mug.2007.03.01.00.29.21;
        Thu, 01 Mar 2007 00:29:23 -0800 (PST)
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
In-Reply-To: <81b0412b0703010010o24513f60x937b5af52362e0c8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41051>


>> If everyone hated the old behavior, old users should already be careful
>> about not git-pull'ing (without options) from any branch but master.  So
>> they won't see any difference.
> 
> except for .git/config growing uncontrollably

While I am probably going to modify the patch to satisfy Junio, have you 
noticed that "git branch -d" will delete the section, hence .git/config 
will not be growing uncontrollably?

Paolo
