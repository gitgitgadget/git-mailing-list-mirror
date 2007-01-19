From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git ls-files -o under .git/ prints all repository files
Date: Fri, 19 Jan 2007 07:27:24 +0000
Message-ID: <200701190727.26505.andyparkins@gmail.com>
References: <87r6trsu7n.wl@mail2.atmark-techno.com> <7vwt3jjywc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Yasushi SHOJI <yashi@atmark-techno.com>
X-From: git-owner@vger.kernel.org Fri Jan 19 08:30:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7oCc-00065r-7R
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 08:30:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbXASHaR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 02:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbXASHaR
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 02:30:17 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:32458 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964898AbXASHaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 02:30:16 -0500
Received: by ug-out-1314.google.com with SMTP id 44so388812uga
        for <git@vger.kernel.org>; Thu, 18 Jan 2007 23:30:14 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=rKSO9JicsTPoTh0w0nWNuBpBrw3b1z7gIVOb9NjDczEQPcAWrJXeTLkspSKwXjrDN9GB+cGrzEiDBbgrkiPdY0j+GAEPd0iNoyW853AToLBb1B+tIk28fLU9obzxwDV1c4H15V7Q6ioDVIGi5J5j17lck2f5eNEoqtEBKSfu2Zo=
Received: by 10.67.96.14 with SMTP id y14mr2608911ugl.1169191814627;
        Thu, 18 Jan 2007 23:30:14 -0800 (PST)
Received: from ?192.168.1.48? ( [84.201.153.164])
        by mx.google.com with ESMTP id k30sm2168173ugc.2007.01.18.23.30.12;
        Thu, 18 Jan 2007 23:30:12 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <7vwt3jjywc.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37155>

On Friday 2007, January 19 06:47, Junio C Hamano wrote:

> +	mode = share ? 0777 : 0333;

So if the repository is shared we're allowed to shoot ourselves in the foot?

Also; what does this do to .git/config .git/description?

On ocassion I've found myself doing
  mv .git/refs/remotes/origin .git/refs/remotes/up

Which this patch would break.  (Maybe I shouldn't be doing that though, so 
perhaps it should break :-))


Andy

-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
andyparkins@gmail.com
