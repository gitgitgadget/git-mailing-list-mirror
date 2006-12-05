X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: filesystem encodings and gitweb tests, was Re: Moving a directory into another fails
Date: Tue, 5 Dec 2006 15:29:56 +0100
Message-ID: <200612051529.57174.jnareb@gmail.com>
References: <9e4733910607260800v618edf0em7b0f5c3332bf8fc5@mail.gmail.com> <200612051036.13645.jnareb@gmail.com> <Pine.LNX.4.63.0612051507170.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 5 Dec 2006 14:28:29 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Np6QneFP+jFYS6QNUWRSjTYkMQ+XQ4WfYs8nD/FmdLYRqo8gqiCjhTZtlVs4uan13lKX1X5C+fEVJifnWfVWYMsUFkpkHb8jX4XLoxJK4iSNisvCMifVs0TdrZtTN/GmNwQdOvEE2F7qPeyZvfMzgdyn4Uyla/3RdxEjeL3IqEQ=
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.63.0612051507170.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33344>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrbHN-0006Pt-RY for gcvg-git@gmane.org; Tue, 05 Dec
 2006 15:28:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937468AbWLEO17 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 09:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937467AbWLEO16
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 09:27:58 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:56485 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S937464AbWLEO1y (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec
 2006 09:27:54 -0500
Received: by ug-out-1314.google.com with SMTP id 44so3342130uga for
 <git@vger.kernel.org>; Tue, 05 Dec 2006 06:27:52 -0800 (PST)
Received: by 10.67.91.6 with SMTP id t6mr13727116ugl.1165328872340; Tue, 05
 Dec 2006 06:27:52 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id h1sm29031236ugf.2006.12.05.06.27.51; Tue, 05 Dec
 2006 06:27:52 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin wrote:

> On Tue, 5 Dec 2006, Jakub Narebski wrote:
> 
>> No, the problem showed with stupid HFS+ which uses different encoding
>> for creating file, and different for readdir.
> 
> This is just one of the problems. I described another problem in this 
> thread, namely a repo on a usb stick being accessed from different hosts.

That is not much a problem. Yes, the filenames on different hosts would
_look_ different, but shouldn't be detected as new file.
-- 
Jakub Narebski
