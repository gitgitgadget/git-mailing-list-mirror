X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC/PATCH] Implement poor-man's submodule support using commit hooks
Date: Wed, 20 Dec 2006 14:35:48 +0000
Message-ID: <200612201435.49685.andyparkins@gmail.com>
References: <200612201309.02119.andyparkins@gmail.com> <20061220133648.GQ12411@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 20 Dec 2006 14:36:23 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=IKNi27FzYqgjDvyPqMrMbSTYtSfztY+lwOKm3q+u1XKc0A/7XAXYVoXrbB/Rym4PdvrBmUJ1aJOtz8G35Quo3A8E33ndbN+gzJI7g+k5Hq4Tu5PqNKreorgu92Lymi5uM68mriqeJrroBaFNoikgerWrwKiRepBmape4IEfdyak=
User-Agent: KMail/1.9.5
In-Reply-To: <20061220133648.GQ12411@admingilde.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34934>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx2Y3-0003wV-Nn for gcvg-git@gmane.org; Wed, 20 Dec
 2006 15:36:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965095AbWLTOf5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 09:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965107AbWLTOf4
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 09:35:56 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:8727 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S965095AbWLTOf4 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec
 2006 09:35:56 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2246540uga for
 <git@vger.kernel.org>; Wed, 20 Dec 2006 06:35:55 -0800 (PST)
Received: by 10.66.219.11 with SMTP id r11mr10880413ugg.1166625354729; Wed,
 20 Dec 2006 06:35:54 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id m1sm12817957uge.2006.12.20.06.35.53; Wed, 20 Dec 2006 06:35:54 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Wednesday 2006 December 20 13:36, Martin Waitz wrote:

> I started with something similiar, too.
> You can have a look at http://git.admingilde.org/tali/git.git/module
> which tries to implement submodules without changing the core.

I had a look at that; and my previous objection still applies: it blends two 
repositories.  I'd rather they were separate.

Having them separate is what makes my little hook scripts really simple; there 
is no special initialisation script needed, and the neither the supermodule 
nor the submodule needs special treatment; and there is no need for any 
alternates or new object type.  If I want to forget about submodule support I 
just delete the .gitmodules file and it's all back to normal.

I don't say you're wrong in your chosen method, and I don't say I'm right.  I 
wasn't really planning on going much further with these scripts, they 
actually represent all that I personally want from a submodule system, I am 
sure others would want far more sophistication.



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
