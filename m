X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git and bzr
Date: Wed, 29 Nov 2006 10:40:06 +1300
Message-ID: <46a038f90611281340u521fb5fct745ebe1ded9a630e@mail.gmail.com>
References: <45357CC3.4040507@utoronto.ca>
	 <Pine.LNX.4.64.0610260753090.3962@g5.osdl.org>
	 <456B7C6A.80104@webdrake.net>
	 <845b6e870611280410j58bdcd99nc05d0f67489293e4@mail.gmail.com>
	 <ekhaeg$etk$1@sea.gmane.org>
	 <Pine.LNX.4.63.0611281433270.30004@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.64.0611280754050.30076@woody.osdl.org>
	 <456C7592.6020700@ableton.com> <ekhtnt$rkk$1@sea.gmane.org>
	 <456C9DFF.1040407@onlinehome.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 21:40:38 +0000 (UTC)
Cc: "Jakub Narebski" <jnareb@gmail.com>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rov5qdV7vFq8lAPEevwAzphsakAMTTeVCUKHuE2QFRtWjCEWDiphhVeEf45uRMFONMR6FWLs3VwmDypGMlZ713hmQmE2I1NfNUt41/P5pcvb9x2phd97L+V4qEgRGR5hIE5PAya64OMf8ir9N51xDbkRuwuRXFaqG9Bq1GdyiLE=
In-Reply-To: <456C9DFF.1040407@onlinehome.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32582>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpAgY-0004gm-K7 for gcvg-git@gmane.org; Tue, 28 Nov
 2006 22:40:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756794AbWK1VkK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 16:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756797AbWK1VkK
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 16:40:10 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:8331 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1756794AbWK1VkI
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 16:40:08 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2698953nfa for
 <git@vger.kernel.org>; Tue, 28 Nov 2006 13:40:07 -0800 (PST)
Received: by 10.48.217.20 with SMTP id p20mr5244972nfg.1164750006789; Tue, 28
 Nov 2006 13:40:06 -0800 (PST)
Received: by 10.49.60.1 with HTTP; Tue, 28 Nov 2006 13:40:06 -0800 (PST)
To: "Nicholas Allen" <nick.allen@onlinehome.de>
Sender: git-owner@vger.kernel.org

On 11/29/06, Nicholas Allen <nick.allen@onlinehome.de> wrote:
> Having not used git I can't really say whether git is better than bzr or
> not in this regard. I know in the kind of development I do the case
> where a file with the same name has been added independantly in 2
> different branches is a pretty rare one. Usually, when it has happened
> the files should have been 2 separate files with different names anyway
> - so bzr would have no problem with this.

Not so rare in a true DSCM scenario where people submit patches via
email or a bug tracker. Say two developers apply the same patch to
their trees, and one of them tweaks it a bit. While I don't personally
do kernel development, I understand that's reasonably common in the
linux dev team.

It also happens quite a bit if you cherry pick across branches patches
that create files.

In such cases, I find GIT does the right thing 99% of the time,
including spotting situations where the file got added at different
patchlevels in different branches.

cheers,



