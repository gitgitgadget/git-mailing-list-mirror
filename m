From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] Introduce rename factorization in diffcore.
Date: Sat, 8 Nov 2008 11:32:35 +0700
Message-ID: <fcaeb9bf0811072032y21b6b505t9b91dda18e8776e2@mail.gmail.com>
References: <20081030220532.3325.54457.stgit@gandelf.nowhere.earth>
	 <20081030221645.3325.78288.stgit@gandelf.nowhere.earth>
	 <fcaeb9bf0811072030u272a6732g2450e1854b96ca18@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sat Nov 08 05:33:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyfWB-00033Q-Gr
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 05:33:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbYKHEch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 23:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752492AbYKHEch
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 23:32:37 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:48182 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbYKHEcg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 23:32:36 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1299608fgg.17
        for <git@vger.kernel.org>; Fri, 07 Nov 2008 20:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=x914GroESHaasZaCHlJSACGaeajIXQJQuRDQDCiL/dw=;
        b=XJ8AuoJJTVaUnRPAdoyFcHaauJ/jKaobG2KYEvD8uQ26T2ibwl1+aEAm4SUYFX2vlp
         bnINlflqrF7YyGyuIUIqA5fOWdh2Yd0WvM5HSILMyfnN+tj+hh2MIRuZaWx4iUdRCWH4
         utpf7nhwRD5y3cz7Ou+h2XVpYT4tSELGwHifg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=aOd2Qj/LIvt9qCfKvqWMj2djL/kIfvVCDYjTX1n3XtzJoPXAPY/PUaV66O5T3xw6YE
         DBN/FgaDoq4JqJS99s5PvJQd//hi77OnKgr3Jk7hwNWzqKer0er9e99gBYM9VQ34XSRH
         sGVPxnicH+BxlOi4uSsa1S9uSb3dOWdu9PuXU=
Received: by 10.86.4.14 with SMTP id 14mr4639840fgd.27.1226118755101;
        Fri, 07 Nov 2008 20:32:35 -0800 (PST)
Received: by 10.86.27.20 with HTTP; Fri, 7 Nov 2008 20:32:35 -0800 (PST)
In-Reply-To: <fcaeb9bf0811072030u272a6732g2450e1854b96ca18@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100375>

On 11/8/08, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> Hmm.. how about turn on a special flag for these rename_dst items?
>  Otherwise --group-renames and --find-copies-harder combination would
>  become hell: you have to compare all src with all dst. It could exceed
>  rename_limit, therefore no rename detection will be done.

Nevermind. I read an old version.
-- 
Duy
