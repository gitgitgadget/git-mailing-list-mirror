X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Trim hint printed when gecos is empty.
Date: Tue, 28 Nov 2006 11:46:54 +0000
Message-ID: <200611281146.56201.andyparkins@gmail.com>
References: <ekh2uh$nk2$1@sea.gmane.org> <ekh4cu$q6e$2@sea.gmane.org> <ekh5k8$vih$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 11:47:38 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=uaZZopIvgTBiOi67dqySIeDqcq/sWMxAZpQ3yibqj0Y/JWcapP/Q5CVeN2sVgWjbWpQvP++4UphipgqH6u83jD5ZLpAoMq/SBeQmnLyg4Npil+wEvDNixvxKjC5xWocWgQ22yZqww3AMPTe7V9LstWJPUayZDEau1dJTbltO1XY=
User-Agent: KMail/1.9.5
In-Reply-To: <ekh5k8$vih$1@sea.gmane.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32512>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp1Qe-0002z5-VO for gcvg-git@gmane.org; Tue, 28 Nov
 2006 12:47:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935852AbWK1LrF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 06:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935870AbWK1LrE
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 06:47:04 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:58345 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S935852AbWK1LrC
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 06:47:02 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1450507uga for
 <git@vger.kernel.org>; Tue, 28 Nov 2006 03:47:01 -0800 (PST)
Received: by 10.66.248.5 with SMTP id v5mr1369899ugh.1164714420925; Tue, 28
 Nov 2006 03:47:00 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id 53sm19354851ugd.2006.11.28.03.47.00; Tue, 28 Nov 2006 03:47:00 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Tuesday 2006 November 28 11:15, Jakub Narebski wrote:

> Yes. You are supposed to add Signed-off-by on commit (I hope that
> git-format-patch doesn't dulicate signoff lines), using git-commit -s.

> But perhaps a config option...

I achieve reasonable results by having the following in my .git/config

[format]                                                                                                                                                              
    headers = "To: git@vger.kernel.org\n"                                                                                                                             
                                                                                                                                                                      
[alias]                                                                                                                                                               
    email=format-patch --signoff --stdout                                                                                                                             

By tuning this per-project I know that a "git email" will generate the correct 
sort of patch for this project.

The thing that's missing is a config option to make git-commit add the signoff 
automatically.  I think this would be useful, as "signing off" is probably a 
per-project decision rather than a per-commit decision.  It seems awkward to 
require the user to remember what the project policy is and always get the 
right git-commit for each project.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
