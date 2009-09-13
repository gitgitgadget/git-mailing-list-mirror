From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 4/4] reset: add test cases for "--merge-dirty" option
Date: Mon, 14 Sep 2009 00:15:01 +0200
Message-ID: <4AAD6EE5.20508@gnu.org>
References: <20090910200334.3722.20140.chriscool@tuxfamily.org> <20090910202333.3722.13214.chriscool@tuxfamily.org> <alpine.LNX.2.00.0909101757530.28290@iabervon.org> <200909110705.35083.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Sep 14 00:15:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmxLi-000378-Vf
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 00:15:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751944AbZIMWPB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 18:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbZIMWPB
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 18:15:01 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:58110 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572AbZIMWPA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 18:15:00 -0400
Received: by fxm17 with SMTP id 17so498241fxm.37
        for <git@vger.kernel.org>; Sun, 13 Sep 2009 15:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=veDo9E0zxhQ6QVm9SvRz5b7/Cmyv4VF4BtraAE1RDx4=;
        b=szDfwYulOyW7xkRAIXdM7rsnb0/Brk/kp7oTSL050/ughOhrNTxoYMJYPa9Apt95wE
         elEZQIdGq7svvrfNv98NZiHhZoNBWck2T7winucrT/iC3cWaNPRxalWn/l90VdiR3izA
         8UVI7tIWNwah75slwAD98+Ro9u7kU3jxOpWTg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=rAp53noyH7WcM4VIn1RyGsQYSfl1CUbJnJ4pPcfUD/gF+JxmWnu+QmV1GH0YNnDsfT
         +DkczeZnF7NyeZ6BewaF2TAK5hwzwt4lWkelH2nbA/0MBJvsrZ87NuQKnmttRXKt4bfU
         8eva5KsfrF0Tmu2k3j8axLbVf00gjGYIvw+u8=
Received: by 10.86.220.1 with SMTP id s1mr4306394fgg.50.1252880103485;
        Sun, 13 Sep 2009 15:15:03 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-str.redhat.com [66.187.229.200])
        by mx.google.com with ESMTPS id e11sm938164fga.26.2009.09.13.15.15.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Sep 2009 15:15:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1) Gecko/20090814 Fedora/3.0-2.6.b3.fc11 Lightning/1.0pre Thunderbird/3.0b3
In-Reply-To: <200909110705.35083.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128423>


> If they get merged, the option name '--merge-dirty" will probably be changed
> to something else like "--merge-safe" so I will have to change some patches
> anyway.

--merge-index or --merge-staged?

Also, it would be great if you would prepare tables like these for all 
cases of git-reset.

Paolo
