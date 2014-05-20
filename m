From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: Re: GIT and large files
Date: Tue, 20 May 2014 12:08:34 -0500
Message-ID: <537B8C12.9020002@gmail.com>
References: <C755E6FBF6DC4447BEF161CE48BDE0BD2F0CD53E@XMBVAG73.northgrum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Stewart, Louis (IS)" <louis.stewart@ngc.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 20 19:08:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmnWp-0001Mf-63
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 19:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612AbaETRIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 13:08:35 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:41566 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300AbaETRIe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 13:08:34 -0400
Received: by mail-oa0-f50.google.com with SMTP id i7so873964oag.9
        for <git@vger.kernel.org>; Tue, 20 May 2014 10:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=1C8wKsbYUPk+VU03AVfNIqvFoUNYIxpbGNoSoKF9474=;
        b=Lz0huMw2KrJohQdEy+9wtRjPijhw6tMSWa9MX17in5Vxy4zFoYYhkBVuev+0ExFJex
         KWq+TyTPe+Ov1xK+hg3WCzC+Xcu2yOeTqvhAaoNTB7rsUg9AGleOymqCy6SDw4+gkI2m
         LssocWpkHvRPFXSbBWI8vQsb3ciSWECyNaUKQNkO8InHD60E3REEPtgJpRzdPfhKUSIP
         5+4mIIejlGN5sLGSzjiGYDiTcbBJ04FgqBVc5GQD0OIknnv6yRQIavrE4BF5UXxJBOH/
         WCyIOR/pCHOgWd3fDPk7QmOo3GbkNT1wRr7rR5hc72zXjrTcmEjW8rBaNnNzl4G0+bmw
         Ypfg==
X-Received: by 10.60.159.232 with SMTP id xf8mr31286020oeb.22.1400605714217;
        Tue, 20 May 2014 10:08:34 -0700 (PDT)
Received: from [10.3.3.221] ([199.227.34.94])
        by mx.google.com with ESMTPSA id rt4sm38793058obb.12.2014.05.20.10.08.33
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 May 2014 10:08:33 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <C755E6FBF6DC4447BEF161CE48BDE0BD2F0CD53E@XMBVAG73.northgrum.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249704>

On 5/20/2014 10:37 AM, Stewart, Louis (IS) wrote:
> Can GIT handle versioning of large 20+ GB files in a directory?

Maybe you're looking for git-annex?

https://git-annex.branchable.com/

-- 
.marius
