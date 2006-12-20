X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC/PATCH] Implement poor-man's submodule support in pre-commit hook
Date: Wed, 20 Dec 2006 10:08:47 +0000
Message-ID: <200612201008.49045.andyparkins@gmail.com>
References: <200612200901.30584.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 20 Dec 2006 10:09:03 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=GDVb3IZyu8ye8SSbu2LQQh3/ApIGn7ROd6DpTyK6WjcgjTTV7x8/TciAaN431moKz+flN6QRcpfqx1ls57NLUp98h1NQNpmeEkWx7o7w++kWloMYSaltIGiHy+Y1wxf+l5xaH6gDvvGu9DZj+dxHcVKiWmvI+0FwuWyvEiEboVQ=
User-Agent: KMail/1.9.5
In-Reply-To: <200612200901.30584.andyparkins@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34915>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwyNf-0006JS-9n for gcvg-git@gmane.org; Wed, 20 Dec
 2006 11:08:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964967AbWLTKI4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 05:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbWLTKI4
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 05:08:56 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:33560 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S964967AbWLTKIz (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec
 2006 05:08:55 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2165526uga for
 <git@vger.kernel.org>; Wed, 20 Dec 2006 02:08:54 -0800 (PST)
Received: by 10.66.244.11 with SMTP id r11mr8949878ugh.1166609332123; Wed, 20
 Dec 2006 02:08:52 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id 54sm12444758ugp.2006.12.20.02.08.51; Wed, 20 Dec 2006 02:08:51 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hello,

Help...

> +if [ -f .gitmodules ]; then

This doesn't work because git-commit is not necessarily in the root of the 
working tree.  How do I safely get that root?  While ${GIT_DIR}/.. would work 
it is not guaranteed.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
