From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH] git-p4: add failing tests for case-folding in p4d
Date: Tue, 28 Apr 2015 10:19:10 +0100
Message-ID: <553F508E.3010603@diamand.org>
References: <1430212081-16146-1-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Lex Spoon <lex@lexspoon.org>,
	"fusionx86@gmail.com >> FusionX86" <fusionx86@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 28 11:19:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yn1gA-0000Lu-Mb
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 11:19:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbbD1JTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 05:19:42 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:34753 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753285AbbD1JTl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 05:19:41 -0400
Received: by wicmx19 with SMTP id mx19so103183907wic.1
        for <git@vger.kernel.org>; Tue, 28 Apr 2015 02:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=cb3IUjTBJKtUgw+my5ge4CDc4hU4ju3cxMWoQEn3BIs=;
        b=WnePvp7inAz43k5aEsAE7/7hfE+WTxTsC+Sn/nXjZYvjFS+NOIM+JbymMRWDyKLuJZ
         o7mr6YYSFzmHl4xZ6Tluu0Mk12K8ycr6BLFNANIe3hRd/m1IL5rZOCfUXYNmyx57ay2M
         5TYjT7tZApCMlGtolzFEr1AEp1rwF5vwK8/c4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=cb3IUjTBJKtUgw+my5ge4CDc4hU4ju3cxMWoQEn3BIs=;
        b=XBBO7YCMROnzWsEc0CIlgTEhVVFwm+ZPttpirMYMz8jQjuzXUQaCo4HL87554LYCxo
         lul5JUHxac/AwTIqRtxRJhBRQTATgv4LkkhsW+7oO7r/nAuiLfGbyNuPWnYRZMaZetac
         sHxAFLz5uz5yO73JF4614ydq2RYPI0f/ukCijJ2+wpTwT9uQyAB2Ox4GYB1nfDl9ehTa
         DDiEJCOW/tjoZOQMYF4rJwg/6RPlTBMTXMvOosYvojGrdS327TNxWVIZINq8ue6GqKQm
         gs0j8rq8JZu1jQfGe5l9srSUnZjhpKkHeGno54nPC0cmrVn61y3ytrQ6ZGzO8Rr5JjSZ
         kmiQ==
X-Gm-Message-State: ALoCoQnkb/C6ZFju0kzS0+L6EXF8dL4zi4cry0YBWNY6iWw3IA7zC/tF833lIjgUazxRWpPqW4xg
X-Received: by 10.194.91.129 with SMTP id ce1mr30889820wjb.53.1430212780183;
        Tue, 28 Apr 2015 02:19:40 -0700 (PDT)
Received: from [192.168.245.128] (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id nb9sm15424082wic.10.2015.04.28.02.19.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2015 02:19:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.3.0
In-Reply-To: <1430212081-16146-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267917>

On 28/04/15 10:08, Luke Diamand wrote:
> Lex found out recently that when git-p4 is asked to clone a repo
> and the case of the repo is incorrect (but otherwise correct) that
> git-p4, instead of reporting an error, appears to work fine, but
> actually produces an empty repo. This can be quite confusing.

Oops, not Lex, but Fusion, noticed the problem!

Thanks!
Luke
