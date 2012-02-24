From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: git gui:  how to fetch a single branch
Date: Fri, 24 Feb 2012 10:57:17 -0600
Message-ID: <4F47C16D.4080208@gmail.com>
References: <70952A932255A2489522275A628B97C31294E91C@xmb-sjc-233.amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Matt Seitz (matseitz)" <matseitz@cisco.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 17:57:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0ySd-00034k-GQ
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 17:57:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757910Ab2BXQ5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 11:57:21 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59738 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753660Ab2BXQ5T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 11:57:19 -0500
Received: by ghrr11 with SMTP id r11so1228835ghr.19
        for <git@vger.kernel.org>; Fri, 24 Feb 2012 08:57:19 -0800 (PST)
Received-SPF: pass (google.com: domain of nkreitzinger@gmail.com designates 10.236.136.4 as permitted sender) client-ip=10.236.136.4;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of nkreitzinger@gmail.com designates 10.236.136.4 as permitted sender) smtp.mail=nkreitzinger@gmail.com; dkim=pass header.i=nkreitzinger@gmail.com
Received: from mr.google.com ([10.236.136.4])
        by 10.236.136.4 with SMTP id v4mr5953924yhi.44.1330102639126 (num_hops = 1);
        Fri, 24 Feb 2012 08:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=QtcrHdX9CfEf2j752TpEUpHAebUtimRFRLbhiixUP6M=;
        b=EhjNZVm+LkDwOniyP/pk5GE71GHFW+Nm9eD+Dx5WB8dJYnmtGH+ygv7FLB3ZBphoVE
         nO0/J+FVxUXqJvI3KWSIKucDELUZwU1njm7cpcpiRgpM6KycWTV0cR4gPaieB9VUyyk+
         pAt0/zzODxe5FxS+WqC9Z7sHwe+TXnm89rTM4=
Received: by 10.236.136.4 with SMTP id v4mr4565582yhi.44.1330102639083;
        Fri, 24 Feb 2012 08:57:19 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id v21sm4249223yhk.3.2012.02.24.08.57.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 24 Feb 2012 08:57:17 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
In-Reply-To: <70952A932255A2489522275A628B97C31294E91C@xmb-sjc-233.amer.cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191442>

On 2/23/2012 5:58 PM, Matt Seitz (matseitz) wrote:
> How can I use "git gui" to fetch a single branch from a remote
> repository?
>
> If I select Remote->Fetch From, and then a remote repository, it appears
> to always fetch all the branches from the remote repository with no
> option to select which branch I want to fetch.
>
One way you can do it is to create a remote to that branch (see -t 
option of git remote manpage).  Then fetching that remote only fetches 
that branch.  Of course, this is practical if you are interested in 
fetching certain branches consistently, but not as practical for 
fetching random single branches frequently.

v/r,
neal
