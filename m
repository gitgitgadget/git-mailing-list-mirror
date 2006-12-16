X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git-fetch fails with error code 128
Date: Sat, 16 Dec 2006 13:29:56 +0000
Message-ID: <200612161329.57605.andyparkins@gmail.com>
References: <200612142308.45376.andyparkins@gmail.com> <7vy7p8omdh.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0612151706150.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 16 Dec 2006 13:32:55 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Rx7r0TheCEciKN/T85iUTN6bn62yjwmE78R8+A5JcFtBXHHpKy0ZkHzcSMcbO2d40SKmW8OWCIQZgR2l1w7RdB10dlymimJNH+I2NRdz/56sgcG4Rkqgqk9QfN6WckiqkX9+5YzZeix636pXGsX4DANI7ld5s/2DU3qYXvpscEM=
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0612151706150.18171@xanadu.home>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34615>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvZei-000490-6y for gcvg-git@gmane.org; Sat, 16 Dec
 2006 14:32:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753668AbWLPNcp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 08:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753700AbWLPNcp
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 08:32:45 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:34857 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1753668AbWLPNco (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec
 2006 08:32:44 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1084601uga for
 <git@vger.kernel.org>; Sat, 16 Dec 2006 05:32:43 -0800 (PST)
Received: by 10.66.244.11 with SMTP id r11mr1710100ugh.1166275963377; Sat, 16
 Dec 2006 05:32:43 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id u6sm5992953uge.2006.12.16.05.32.42; Sat, 16 Dec
 2006 05:32:42 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Friday 2006, December 15 22:13, Nicolas Pitre wrote:

> And since patch-delta is really simple, it doesn't have many reasons for
> returning NULL: either the object store on either the remote or local
> side is corrupted in which case a git-fsck-objects --full should catch
> that, or the system ran out of memory.

It's not conclusive, but the system its failing on has more memory than the 
system it is working on.


Andy

-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
