From: Frank Li <lznuaa@gmail.com>
Subject: Re: [msysGit] git-svn.perl should check GIT_ASKPASS environment
Date: Fri, 11 Feb 2011 19:34:13 +0800
Message-ID: <AANLkTim3fdevQYuE5R12D0b-AxVKaksPWDcMUedG-t6+@mail.gmail.com>
References: <1c47e93c-5b7c-4aed-8a78-807d3aff2700@n36g2000pre.googlegroups.com>
	<AANLkTinkv0dNxNxehud0Byuu9tpqxp1kBMJ1OyEcfVQ_@mail.gmail.com>
	<AANLkTik9mFNsqFQn5SEZkYd_uxDeoY-9nqgV_PJ+nNsi@mail.gmail.com>
	<AANLkTinWLTfU_WmxTCvz+P=rcXY=2u25Eo2QZWmDMdSh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jose Roberto Garcia Chico <jose@toro-asia.com>,
	msysGit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Feb 11 12:40:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnrMO-0001kf-C8
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 12:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756047Ab1BKLkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Feb 2011 06:40:18 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45895 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755759Ab1BKLkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Feb 2011 06:40:16 -0500
Received: by iyj8 with SMTP id 8so2320824iyj.19
        for <git@vger.kernel.org>; Fri, 11 Feb 2011 03:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=z1acqsSrMhJONGamYUNFyKyUxN8GLzz1AvoSCZCieKM=;
        b=AXyKpEJguhgHY767z7tMJTLjXm88mpWJPe2GvB5VFhW6i9flJ8qeV2P5HawMIck0/F
         jWCZb3INr++ciOwx0vfJ60Xjh4AP9T0PRjmoDIjfArCS0qwfLIRiEek/KJ5sfKtjAImc
         tkcCo2PR78UAjawUrt8TBbj+eci7r7WEK94TM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=VuuGeD0ww4G6VRisRj/eGmfIvE6z+gicIR7Kr98dHvTzMcpQZLqzS7LAgSevSdvmNq
         WLgq3FVqAWeeLbitjF+FGyb5SRW4dN49URfIXeu3KNcHV0kF/jYoD/yw/dc4P4HX/TG6
         j8uIeru6+nuC/NQiGBX+yeWgmq2hjmHGcl1sE=
Received: by 10.231.10.200 with SMTP id q8mr276381ibq.122.1297424053619; Fri,
 11 Feb 2011 03:34:13 -0800 (PST)
Received: by 10.231.33.73 with HTTP; Fri, 11 Feb 2011 03:34:13 -0800 (PST)
In-Reply-To: <AANLkTinWLTfU_WmxTCvz+P=rcXY=2u25Eo2QZWmDMdSh@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166552>

>> SSH_ASKPASS is used to accept "Enter your OpenSSH passphrase".
>> refer to git-gui/git-gui--askpass
>>
>
> git-gui--askpass can ask for a password, or yes/no questions. But this
> is neither, it's a reject/accept temporary/accept permanently
> question.
>
> Perhaps the prompt could be rewritten as two yes/no questions, though?
> Something like "Accept certificate? (yes/no)" and if the answer is
> "yes", query with something like "Store certificate? (yes/no)".

I think that's fine.
Frank Li
