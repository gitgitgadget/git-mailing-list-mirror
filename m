From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/4] pull: use --quiet rather than 2>/dev/null
Date: Mon, 22 Mar 2010 22:23:44 -0500
Message-ID: <20100323032344.GA12424@progeny.tock>
References: <1269051518-25099-1-git-send-email-bmeyer@rim.com>
 <1269051518-25099-2-git-send-email-bmeyer@rim.com>
 <20100320123520.GA29041@progeny.tock>
 <818FE4EC-5AE9-4F05-B9AD-E1753F7ED9E6@meyerhome.net>
 <20100321043330.GA9803@progeny.tock>
 <E2F911AD-19C6-43BF-BBBD-735D30885F21@meyerhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Benjamin Meyer <ben@meyerhome.net>
X-From: git-owner@vger.kernel.org Tue Mar 23 04:23:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ntuig-0006Az-Te
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 04:23:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754120Ab0CWDXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 23:23:50 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:39017 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754084Ab0CWDXt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 23:23:49 -0400
Received: by ywh2 with SMTP id 2so2144777ywh.33
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 20:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Z3fgTREXedbDPNvCdo8dpqJgQsYV1vAoqNtQo7qz+S0=;
        b=q8m35M8SNTvWujhjVwYfakkLINyhUBRfhNc2KUHyTqISvsHTuAeODl20OtPXOcrEk8
         4YqnHYz4yWwMtU68XFVcqPm5jh7auIoWqCwDrrhQbd1+6cT/WGAPeAuRzzA43NYG7rxq
         b5jDp3U2F9pRPp4/q6YhEDQCQnc3/vnNKnZ00=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ej9NB2uqE6ML9dGWsI8VfvrL76aog5/t7gm6NwtJOYWmpz7KDnT1Fl5dHV7NAR86fQ
         6yQp+JgbBDBbZi4rnBk2plxSRPxpPUONG9m9l3rHNjuNKzav7pcxw+RIPIKvLPplWZ3n
         MGO/drRoZtQeoVoD8ElknXQGoMD47Zf97eHDY=
Received: by 10.101.106.1 with SMTP id i1mr3174030anm.24.1269314627359;
        Mon, 22 Mar 2010 20:23:47 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm3971703iwn.0.2010.03.22.20.23.46
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 22 Mar 2010 20:23:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <E2F911AD-19C6-43BF-BBBD-735D30885F21@meyerhome.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142986>

Benjamin Meyer wrote:

> Thanks for the example.  I will try to include a more full
> explanation for my changes in the future so it can be more easily
> reviewed.

Thanks for your work!  I got a kick out of reading
<http://meyerhome.net/icefox/git-achievements>, by the way.

Jonathan
