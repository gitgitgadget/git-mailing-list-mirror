From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] t1200: cleanup and modernize test style
Date: Tue, 03 Nov 2009 22:50:49 -0800
Message-ID: <4AF12449.7050905@gmail.com>
References: <1257282328-6491-1-git-send-email-bebarino@gmail.com> <7vr5seltyi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 07:51:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5Zi0-0004bw-Lo
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 07:51:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753092AbZKDGu5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 01:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752701AbZKDGu5
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 01:50:57 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:40811 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654AbZKDGu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 01:50:56 -0500
Received: by yxe17 with SMTP id 17so6128455yxe.33
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 22:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=2sY+nSZwybh7Tb4JAeWoeXsqJu8tManuUFj0sl2ZTsQ=;
        b=b3DBd4wV9N6AUehqekLhBy5A0VS3pFZEH10kbdIdv8P7u19F8l9SAG5w/S+Y8abkC8
         vIVZ2vo4rWgYyeFrFbwEaceF8ukPwbRDPxaiPXAAH9MsiFSYMWf75VP4XFKmBC/8vOUb
         snm+0V8IvzgIcZHpIVDxpIqgjNqK9h5flBe1A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=x3/X9Y0CXrNoIKJxrJ8d88QDniJG5qE3PnFb+BUeKfgsDQMZcUO9KfbAMwkFBt1pSw
         1otMoRP4fj6fxhthfAnh7XGbPvFx0uqxCWNE6svvpKZbpPNJbUfnkI35EcbQhbJ+1k+j
         KWS0JFWVLwELKuiG4tmHJbb1F43nj9XaXRIY0=
Received: by 10.90.37.36 with SMTP id k36mr2118675agk.111.1257317452761;
        Tue, 03 Nov 2009 22:50:52 -0800 (PST)
Received: from ?192.168.0.5? (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 8sm391653yxb.43.2009.11.03.22.50.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Nov 2009 22:50:51 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20091026)
In-Reply-To: <7vr5seltyi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132046>

Junio C Hamano wrote:
> Thanks.
>
> The sequence of commands are suppopsed to match what the user manual
> teaches, and I suspect we have had quite a many updates to the manual
> since this test script was last touched.  Do you happen to know if they
> still match the manual?

I just read through it and it's different. I'm ignoring the cloning, 
fetching, pushing, and gitk parts too. There is a whole section on 
merging which isn't really covered. I'll resend sometime soon (the last 
test is broken too, sorry).
