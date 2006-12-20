X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC/PATCH] Implement poor-man's submodule support using commit hooks
Date: Wed, 20 Dec 2006 13:48:24 +0000
Message-ID: <200612201348.25897.andyparkins@gmail.com>
References: <200612201309.02119.andyparkins@gmail.com> <20061220133648.GQ12411@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 20 Dec 2006 13:48:46 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=EylXAKR2cSAPtHeHI2toUDX5NEOlkESBCULvAhJRtZs+cOMVbczI9GCYG5g5LK1E1sXWcMoIrRUvgruT0GdmK5edbtZFKDZXr8rYOP7ECaCu9EPclwvhVbuFZsFkm7/zKALzVVeKKUALkrx5HrutTYf1LgCo+Lc0PWBFg+2Ec90=
User-Agent: KMail/1.9.5
In-Reply-To: <20061220133648.GQ12411@admingilde.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34929>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx1oE-0003SE-Iz for gcvg-git@gmane.org; Wed, 20 Dec
 2006 14:48:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965063AbWLTNsd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 08:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965060AbWLTNsc
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 08:48:32 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:58541 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S965063AbWLTNsb (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec
 2006 08:48:31 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2232236uga for
 <git@vger.kernel.org>; Wed, 20 Dec 2006 05:48:30 -0800 (PST)
Received: by 10.67.22.14 with SMTP id z14mr9326560ugi.1166622508751; Wed, 20
 Dec 2006 05:48:28 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id 39sm10685684ugb.2006.12.20.05.48.27; Wed, 20 Dec 2006 05:48:27 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Wednesday 2006 December 20 13:36, Martin Waitz wrote:

> I started with something similiar, too.
> You can have a look at http://git.admingilde.org/tali/git.git/module
> which tries to implement submodules without changing the core.

I wasn't really trying to do away with the need for core changes; I just 
wanted something simple that I could use today.

If this is old news - no problem.  Drop it.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
