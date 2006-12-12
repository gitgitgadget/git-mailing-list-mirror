X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Colourise git-branch output
Date: Tue, 12 Dec 2006 11:03:29 +0000
Message-ID: <200612121103.31110.andyparkins@gmail.com>
References: <200612120641.52556.andyparkins@gmail.com> <457E6C65.4B6D131@eudaptics.com> <7vpsapwhl2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 12 Dec 2006 11:03:44 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=HW1ERGDDJ7kYaQs+LHbe1/MLtukOFmjLN7agcl+oo3oRsB1I5Ep7r6dIXrTanXPr9X42Giw58FmsMS9u6nWLj+BTjTgN+VbRiOOtRspjbAkZbRdChNdqVmFECyaPtZLGBN3WNMWh5qvQE3576i7xicdCQuUH0Gfj5ZQV+poURoc=
User-Agent: KMail/1.9.5
In-Reply-To: <7vpsapwhl2.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34079>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gu5QC-0005et-Gq for gcvg-git@gmane.org; Tue, 12 Dec
 2006 12:03:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932193AbWLLLDi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 06:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWLLLDi
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 06:03:38 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:2212 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932193AbWLLLDh (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec
 2006 06:03:37 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1627490uga for
 <git@vger.kernel.org>; Tue, 12 Dec 2006 03:03:36 -0800 (PST)
Received: by 10.66.244.10 with SMTP id r10mr11508819ugh.1165921415953; Tue,
 12 Dec 2006 03:03:35 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id m4sm6649768ugc.2006.12.12.03.03.35; Tue, 12 Dec 2006 03:03:35 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Tuesday 2006 December 12 10:10, Junio C Hamano wrote:

> Even without red-green blindness issue, I think that makes
> sense.  colored-diff uses green/red for added/deleted but that

I certainly don't have any objection.  For me, the use of colour is not to 
make things look pretty it's to give visual queues.

> is shown against the context in plain.  A sane thing to do for
> branch listing would be to show the usual case (i.e. local) in
> plain and show the remote ones differently.

The only reason I picked red and green was to indicate "can be checked out" 
and "cannot be checked out".  However, when git eventually allows arbitrary 
commits to be checked out that green/red, can/can't distinction will be 
meaningless anyway.

> +	"",		/* LOCAL (normal) */
> +	"\033[32m",	/* CURRENT (green) */

In keeping with the "don't use green" idea - can I suggest just bold normal 
for the CURRENT?  That way there is the most minimal use of colour for the 
default git-branch output, but still retaining a visual indicator.

Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
