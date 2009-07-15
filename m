From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: Make a non-bare repo bare.
Date: Wed, 15 Jul 2009 23:48:42 +0200
Message-ID: <4A5E4EBA.4050708@gnu.org>
References: <c115fd3c0907151443h49aaac60r3462c69f55ed2d9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 15 23:48:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRCLQ-0003m2-PU
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 23:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754848AbZGOVss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 17:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754433AbZGOVss
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 17:48:48 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:8062 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754215AbZGOVss (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 17:48:48 -0400
Received: by fg-out-1718.google.com with SMTP id e21so1199330fga.17
        for <git@vger.kernel.org>; Wed, 15 Jul 2009 14:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:newsgroups:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=ncg6jJoK1i1Lhy3xBAf9PZsxDcQ/ErapYDF1d45P/fY=;
        b=KBnOEsuNOHVGEpBdDj06aFg3R2Ty/OuMOMrXf+ussc6k+9qIB7BqifklgK7nQxGfIu
         BuJvZae4WdLSZs1yrJaDMa6bvulUYOBmhCcEl6sGsCFTw/ApVpR7pd2PlDeJkX4bIiYI
         9OkU2r4nowQ3MX05Kq2NGUlGX+APOlXnvYjV0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:newsgroups:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=eMTjUhyW1BjHk64qmcpShtINfbOY1b1hxo5CdwBEb/s/tHz5oDRLZTeLhzvRBIvAOg
         RvXBI2dxQgba2P9CSJkwLWEE5j1lGWNTN12KK8ZJBsmf0zZ4cCDAbMQYMtW/HkjC5qNQ
         DkXKMFr3JWOf7w2Of5v12w4FGkhqXueYT0VY0=
Received: by 10.86.1.1 with SMTP id 1mr5415362fga.42.1247694525810;
        Wed, 15 Jul 2009 14:48:45 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-str.redhat.com [66.187.229.200])
        by mx.google.com with ESMTPS id l19sm11000381fgb.6.2009.07.15.14.48.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Jul 2009 14:48:44 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090513 Fedora/3.0-2.3.beta2.fc11 Lightning/1.0pre Thunderbird/3.0b2
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <c115fd3c0907151443h49aaac60r3462c69f55ed2d9f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123336>

On 07/15/2009 11:43 PM, Tim Visher wrote:
> Hello Everyone,
>
> I recently had occasion to make a previously non-bare repo bare.  Is
> there any way to do this?  It will not allow me to delete a branch
> that I'm on so I wasn't sure how to proceed.

Just do "mv repo/.git repo.git; rm -rf repo" (with care!).

Paolo
