From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v6 00/32] refs backend
Date: Thu, 25 Feb 2016 14:32:08 -0500
Organization: Twitter
Message-ID: <1456428728.18017.41.camel@twopensource.com>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
	 <56CE460A.4020505@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org,
	mhagger@alum.mit.edu, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu Feb 25 20:32:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ1e9-0007rH-FY
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 20:32:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933641AbcBYTcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 14:32:11 -0500
Received: from mail-qg0-f48.google.com ([209.85.192.48]:34459 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933401AbcBYTcK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 14:32:10 -0500
Received: by mail-qg0-f48.google.com with SMTP id b67so48272601qgb.1
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 11:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:organization
         :content-type:mime-version:content-transfer-encoding;
        bh=p+Nx07qu9vUvMHfZhuhp/TDIUHmqWuUFOaLNjAVIy/w=;
        b=jp1IQVjegJEQQxsLOKKL4xd6xcUtua6JxyGC8MuMUNRDrVvuPpWjCkhprL0cnzGXJV
         ynCnlgwp/XirnWiUVrp34avmxq3f5GaVH9hxRk01qsjiz8mK9S7r9x5GInEwl3rGYX4W
         5WBx+K45Pow5+InVml22gDBAsmC95pskR1alTQf/75678AlVmSUbu9k89QEsobWJLAOH
         NRoTeRmKy48k9muX/v8lftVIKHqZ1xM+4p3fwwW2EhdrxkuasVg7bmuIrqVFES0Bvx7h
         HFEra37B4eaPTLzgHIQ9LIrQDNmOoJEa+bkddFhCeMx5lI3ECWvh5SN8+PpM5wicHOm4
         ebSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=p+Nx07qu9vUvMHfZhuhp/TDIUHmqWuUFOaLNjAVIy/w=;
        b=YBr4/o1SQ+AQaeENaX1lfwT2FD92H02hKD0jPVDRkZ8KcXVIaHnJJULsEbvzsT17Sq
         b0bWVZwyfdreQudDev2S/CswdwwkYCzOXQDFFtFfMKiyBMf+oIwT1B6wGDMWBGJYfxiQ
         Sz6unYS+s2yU1gmtCksjkiKGb+WEEFy1hQjePet3vi3uY409K/Q9YDyygXoibSMtGAi0
         Qaj2a1RTA6exNhFxTJVdvRn/OuJ6Zw9WJWr+xmlwM4uZRmdNaqLKTdfQTa4v/I5hRTW2
         kdoJP+C+u/6k7Ry3qRhOTC35uWn0+GO/zUHoKt8MfgIPqu6+lzNev+S0qDPuKt5gMspi
         CEJA==
X-Gm-Message-State: AG10YOTwhpEsnePVFZIUAL4gqslZQr3N4PFVJbnomyqOKaHhiJzafV0TQLWMgnmAnBqg3w==
X-Received: by 10.140.44.38 with SMTP id f35mr58690159qga.49.1456428729640;
        Thu, 25 Feb 2016 11:32:09 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id e11sm3848426qkb.39.2016.02.25.11.32.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 25 Feb 2016 11:32:08 -0800 (PST)
In-Reply-To: <56CE460A.4020505@ramsayjones.plus.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287423>

On Thu, 2016-02-25 at 00:08 +0000, Ramsay Jones wrote:
> > Ramsay Jones (1):
> >   refs: reduce the visibility of do_for_each_ref()
> 
> Ah, sorry if it wasn't clear, but there is no need to keep this
> as a separate patch - it should simply be squashed into the relevant
> patch in your series.
> 
> ATB,
> Ramsay Jones

It actually seemed cleaner to do it this way for some reason.
