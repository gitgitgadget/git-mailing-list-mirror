From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 3/4] fast-export: don't handle uninteresting refs
Date: Tue, 30 Oct 2012 14:45:31 -0700
Message-ID: <20121030214531.GN15167@elie.Belkin>
References: <1351617089-13036-1-git-send-email-felipe.contreras@gmail.com>
 <1351617089-13036-4-git-send-email-felipe.contreras@gmail.com>
 <20121030185914.GI15167@elie.Belkin>
 <CAMP44s3LP65XOYFg-tBe_rzT1+gXp=714C-u14mkwxY26r4b=g@mail.gmail.com>
 <CAMP44s1tFhh3Xqe9tqoDAdtwnGc=kFT6OmAreeP1nbTstweaQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 22:45:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTJd7-0003dv-ME
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 22:45:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934742Ab2J3Vph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 17:45:37 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33431 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756232Ab2J3Vpg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 17:45:36 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so460204pad.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 14:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qhx81F0leDytEjKNd4lRQaZRd8H9fR78DAp+5W2UySU=;
        b=Me34TF1luhvAemL/ZyZX33A3xfeDbeKP5RtaqryiEdyQsy8Jxh+7PIpzkU91MNYD8M
         +9NmqvZ9Hkz1VKVfNUk8uSgCNMtEcYCWRMSW8HJVVWTMC3HJ2tMFbZ5rHaPZIi+0wpA5
         VLYfk1+mMSFJqPIEWcVtjs5izWE0iTtW7nvt9GQhoUD4BZC8hyHQM7qdxXmC3IRtL+cE
         millIGKFDVG/MMGfNV19q8W8+ljIvpjT4CCHHXd97HKLKjwJCCodcnqyIEe36olEGXJN
         lCBVvmmR+fJxtLTEWl0FJQdv48cQshRpx8d2SbSNpMpW5ycMTxXCJWz2HY64/gzmAfsE
         xmFQ==
Received: by 10.68.245.37 with SMTP id xl5mr25198533pbc.120.1351633536325;
        Tue, 30 Oct 2012 14:45:36 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id hs1sm1116340pbc.33.2012.10.30.14.45.34
        (version=SSLv3 cipher=OTHER);
        Tue, 30 Oct 2012 14:45:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s1tFhh3Xqe9tqoDAdtwnGc=kFT6OmAreeP1nbTstweaQQ@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208751>

Felipe Contreras wrote:

> So you think what we have now is the correct behavior:
>
> % git fast-export master ^master
> reset refs/heads/master
> from :0

No, I don't think that, either.

Hope that helps,
Jonathan
