X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Make new builtin cherry match documentation for "+" and "-"
Date: Thu, 26 Oct 2006 08:45:22 +0100
Message-ID: <200610260845.23850.andyparkins@gmail.com>
References: <E1Gck4m-0003J1-00@dvr.360vision.com> <7vk62ob5mp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 26 Oct 2006 07:45:54 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=grqL3Fi0e/Q7liRlfdgnbaiNhSahcVv88lX4fwfADhC5juyfE6FtslMrxT9v9faJmEA4ly6He4ibc4URa/ysKoqeZ8egGK67GwxqAlC8BIzejAvVda9kvut+aCeEMBJOxHaNs9LTouTusjGhOJEvihddK6r8rOvWcfLsNHz6rWs=
User-Agent: KMail/1.9.5
In-Reply-To: <7vk62ob5mp.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30145>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gczvu-0001f7-AW for gcvg-git@gmane.org; Thu, 26 Oct
 2006 09:45:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751849AbWJZHpa (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 03:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870AbWJZHpa
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 03:45:30 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:8260 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1751849AbWJZHp3
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 03:45:29 -0400
Received: by ug-out-1314.google.com with SMTP id 32so302189ugm for
 <git@vger.kernel.org>; Thu, 26 Oct 2006 00:45:28 -0700 (PDT)
Received: by 10.67.119.13 with SMTP id w13mr2317167ugm; Thu, 26 Oct 2006
 00:45:28 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id 28sm35407ugc.2006.10.26.00.45.27; Thu, 26 Oct 2006 00:45:27 -0700
 (PDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Wednesday 2006 October 25 19:41, Junio C Hamano wrote:

> > "+" and "-" don't match the documentation, where "+" means the patch /is/
> > in upstream, "-" means it isn't
>
> The documentation was utterly wrong.  The comment at the
> beginning of git-cherry.sh was better but slightly wrong.

Seriously?  In git-cherry output a "-" means that a patch is in?  Seems 
counter-intuitive to me.

Or is it meant to be analogous to a diff so "+" means "in order to make this 
branch like the comparison branch you would have to /add/ this patch"?


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
