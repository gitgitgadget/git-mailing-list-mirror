X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Using git as a general backup mechanism (was Re: Using GIT to store /etc)
Date: Wed, 13 Dec 2006 12:15:25 +1300
Message-ID: <46a038f90612121515l77c77376xd98e148498e889c4@mail.gmail.com>
References: <787BE48C-1808-4A33-A368-5E8A3F00C787@mac.com>
	 <Pine.LNX.4.64.0612111837210.20138@iabervon.org>
	 <8900B938-1360-4A67-AB15-C9E84255107B@mac.com>
	 <200612121553.37499.andyparkins@gmail.com>
	 <457F31E6.8090701@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 12 Dec 2006 23:15:44 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VC71M4UXaPmCHTin1THFIoFx6iWYmlYly2y3dPMqmfOYu65Vf8KqX5Wtt6dUjxSpqDFCdpW7w16pFJ4QlVWW4osdpp3oVYBR+D1NrBbK3fVCdSP+pLXUPIeYBYTyS95klWKeigeeWnsLIw0LJm6MOjmsOQc8nUX88qiJXadzS3Y=
In-Reply-To: <457F31E6.8090701@midwinter.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34165>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuGqa-0003jR-Vq for gcvg-git@gmane.org; Wed, 13 Dec
 2006 00:15:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932531AbWLLXP2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 18:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbWLLXP2
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 18:15:28 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:39106 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932531AbWLLXP1 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec
 2006 18:15:27 -0500
Received: by nf-out-0910.google.com with SMTP id o25so364029nfa for
 <git@vger.kernel.org>; Tue, 12 Dec 2006 15:15:26 -0800 (PST)
Received: by 10.49.20.5 with SMTP id x5mr2019830nfi.1165965325971; Tue, 12
 Dec 2006 15:15:25 -0800 (PST)
Received: by 10.49.60.1 with HTTP; Tue, 12 Dec 2006 15:15:25 -0800 (PST)
To: "Steven Grimm" <koreth@midwinter.com>
Sender: git-owner@vger.kernel.org

Steven,

I've been thinking myself of writing a pdumpfs lookalike that uses git
internally. Sounds you you've got one already ;-)

In terms of getting rid of old history, have you considered moving a
graft point "forward" in time, and running git-repack -a -d? With your
history being (mostly?) linear this could be a workable scheme, but I
don't have much practice with using grafts.

cheers,


