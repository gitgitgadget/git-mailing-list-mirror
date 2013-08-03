From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] submodule: fix confusing variable name
Date: Sat, 3 Aug 2013 11:14:15 -0700
Message-ID: <20130803181415.GF2893@elie.Belkin>
References: <1375550060-5406-1-git-send-email-sandals@crustytoothpaste.net>
 <1375550060-5406-2-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, judge.packham@gmail.com, iveqy@iveqy.com,
	Jorge-Juan.Garcia-Garcia@ensimag.imag.fr, gitster@pobox.com
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sat Aug 03 20:14:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5gLQ-0001Om-6C
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 20:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752457Ab3HCSOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 14:14:20 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:58339 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385Ab3HCSOT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 14:14:19 -0400
Received: by mail-pb0-f42.google.com with SMTP id un15so1847026pbc.1
        for <git@vger.kernel.org>; Sat, 03 Aug 2013 11:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Dh7ZXZFNLxuROg9VnBbOTBAyy74EEMH+mZvgXOusWMo=;
        b=JWnODNFiWfJ4KFK+QH320pdjdlAdMRy4zdwoI6Exd3gHYqyyVc1yx+5mDvaDSQaOBi
         pTf0MPwlwy9uS/yuuDB6D/7fMNdzXHkwcVHoCHIp3sfkc9dV8zq6vh9pOC5azjuVRB0v
         O6peLsXmHY0Y1NkrJv/iyUs4YSx92DxDKQVirO7Otu82D2y5I9kQOkJDzQLurR/qnAiR
         puNf+DssL3DHc1S/zoGklYVuh8mCL4vCN2QyxJCwJZm82HYvKaRpx67Gy4ReUaxAy2e+
         md9a8r8SJx/A4fDe3G3VfZiPA6S7FwaJaFzrM0ejy96sSsa63PKeiBVuca24oZ27FU3E
         CaGg==
X-Received: by 10.66.122.167 with SMTP id lt7mr16363933pab.190.1375553659288;
        Sat, 03 Aug 2013 11:14:19 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id om2sm15113088pbb.34.2013.08.03.11.14.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 03 Aug 2013 11:14:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1375550060-5406-2-git-send-email-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231613>

brian m. carlson wrote:

> cmd_summary reads the output of git diff, but reads in the submodule
> path into a variable called name.  Since this variable does not
> contain the name of the submodule, but the path, rename it to be
> clearer what data it actually holds.

Nice.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
