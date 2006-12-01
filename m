X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 08:49:09 +0000
Message-ID: <200612010849.11176.andyparkins@gmail.com>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <20061130170625.GH18810@admingilde.org> <456F29A2.1050205@op5.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 08:49:26 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=oEI22estaOJowAyaYW0ZvNBsTMZ6k2QitJhyJvR+XudAWuY5TLhmQCPIQRI7lj7HNJbKL5gwDvHdZgyhdFh0/9PmXL7gKCXUstYovaxLUD1rByX2ieGw10iXcy9rOKVhH6UhhSYOmDCG01A4K5egScG05ggP4bCSGA/0/ryGnw8=
User-Agent: KMail/1.9.5
In-Reply-To: <456F29A2.1050205@op5.se>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32874>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq45A-0003gh-Tq for gcvg-git@gmane.org; Fri, 01 Dec
 2006 09:49:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967559AbWLAItR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 03:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967560AbWLAItR
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 03:49:17 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:14149 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S967559AbWLAItR
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 03:49:17 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2360540uga for
 <git@vger.kernel.org>; Fri, 01 Dec 2006 00:49:15 -0800 (PST)
Received: by 10.67.21.11 with SMTP id y11mr6885011ugi.1164962955327; Fri, 01
 Dec 2006 00:49:15 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id y1sm14075551uge.2006.12.01.00.49.14; Fri, 01 Dec 2006 00:49:14 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Thursday 2006 November 30 18:57, Andreas Ericsson wrote:

(agree with everything in your mail)

> The only problem I'm seeing atm is that the supermodule somehow has to
> mark whatever commits it's using from the submodule inside the submodule
> repo so that they effectively become un-prunable, otherwise the
> supermodule may some day find itself with a history that it can't restore.

What about submodule/.git/refs/supermodule/commit12345678, where "12345678" is 
the hash of the supermodule commit?  This gives a convenient route in the 
submodule to which commit contains that commit from the submodule; but 
doesn't write anything into the submodule repository itself.  It's just a tag 
with a different intent.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
