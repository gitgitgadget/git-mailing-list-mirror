From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: BUG! missing .idx causes .pack to be removed
Date: Fri, 6 Aug 2010 11:24:43 +0800
Message-ID: <AANLkTi=bjM7rGSXv0eB5+6VEX=wY84upkzDcBJ6C9KdK@mail.gmail.com>
References: <20100805170137.GA2630@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: weigelt@metux.de
X-From: git-owner@vger.kernel.org Fri Aug 06 05:24:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhDYB-0001TE-G1
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 05:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932814Ab0HFDYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 23:24:47 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51225 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759148Ab0HFDYp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 23:24:45 -0400
Received: by iwn33 with SMTP id 33so823438iwn.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 20:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=CED9aYMETQQcMJL2kDhpPXa2ptZkER+q6MNGmQbBELU=;
        b=d4d51Dh3ZnY2EwsGAhBaWC+pq6nsFJk2OQfHuIoeRHfQczAInYJxBGgwyX9aqKWO8g
         RU3oDxGNpLUwvw8aojHJr0aBFXL3mLH3NQkJdIjRTbap+FMMlqvSNkxycxuQs6a84nH1
         UJkNgwy9XhPu9teNrRiJxymTPG1modHFT5eck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=r2LKl6J4MraIGfw68Ax8s51w2o7NFLZXZTuz4XS5Qzd2XzrXFfKL6eTI54qfdBeeN/
         vUg4gwZEc4X/rViAYUZISz6RbEg4H8Ajh+BKYnUyFgSMUXPTjfR3u2JS93iumGnum2C5
         b29SM6nA5ZuwV80a5pzFmPpdYbaEKSWiUu+10=
Received: by 10.231.162.13 with SMTP id t13mr5197710ibx.160.1281065083703; 
	Thu, 05 Aug 2010 20:24:43 -0700 (PDT)
Received: by 10.231.158.141 with HTTP; Thu, 5 Aug 2010 20:24:43 -0700 (PDT)
In-Reply-To: <20100805170137.GA2630@nibiru.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152757>

Hi,

On Fri, Aug 6, 2010 at 1:01 AM, Enrico Weigelt <weigelt@metux.de> wrote:
> while doing some experiments I've removed the *.idx files and
> ran git-repack - that complained about missing objects and removed
> all *.pack files !
>
> I'm sure that's a bug - an ugly one ;-o

IIRC, a .pack file is useless without its corresponding .idx file. So
the removal of a .pack file makes sense here - to me, at least.

-- 
Cheers,
Ray Chuan
