From: Alexey Muranov <alexey.muranov@gmail.com>
Subject: Re: Feature request: fetch --prune by default
Date: Thu, 19 Jul 2012 23:57:21 +0200
Message-ID: <81C40C14-0CAD-41E1-AD16-ABA4D9002D00@gmail.com>
References: <2C63E314-2EF5-4B8E-B96A-5306E317E045@gmail.com> <20120719115558.GC29774@sigill.intra.peff.net> <88300470-AB41-4317-8B97-81DC18FD5899@gmail.com> <20120719213438.1cc7ca77a9cb3367a3be0539@domain007.com> <E94B0D74-2BB8-4B3E-BFB9-A2CFE9C2A7BB@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Jul 19 23:57:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sryiw-0001fp-Om
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 23:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973Ab2GSV50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 17:57:26 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:33785 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887Ab2GSV5Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jul 2012 17:57:25 -0400
Received: by wgbdr13 with SMTP id dr13so2920105wgb.1
        for <git@vger.kernel.org>; Thu, 19 Jul 2012 14:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=gmfauNzthzAWqQGOyG0xGjjTq4bUs5mY/RslqagC9e4=;
        b=eOzajKZwY/oi+d6zbt4QimBpP2NbpEabIfSkptPzmTg0y3IpK0cQ9nNx0JZAHCNRLo
         587ABoFHdAEmjX2EmEUY2wgly9pvRBQo3W9v+4K+dBuzH6Eyu9Q3EdsOd0CweBjyNVQf
         J6hj1qJprvsOMQ6VJwnsjDyGXda3zniqlTNIw5wvSCPj8QSB9rbOfgDWUBPD0A6fqpTD
         SK1ojQMZdKBWBLVlmNRSP11IlD/0HHftX02Wj3Rsqu6zMuNqRUBAGxWviemM4+qLLASd
         luZq1JLvqS2LDksgc+hkagHw5+2LoM3Me1N4hpU3eUS7JHDYmw1Ge0g4waIc0U1fxCQo
         Uruw==
Received: by 10.180.104.197 with SMTP id gg5mr8156501wib.9.1342735044005;
        Thu, 19 Jul 2012 14:57:24 -0700 (PDT)
Received: from [192.168.6.127] (bi1.roaming.dfn.de. [195.37.234.61])
        by mx.google.com with ESMTPS id h9sm40774445wiz.1.2012.07.19.14.57.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Jul 2012 14:57:23 -0700 (PDT)
In-Reply-To: <E94B0D74-2BB8-4B3E-BFB9-A2CFE9C2A7BB@gmail.com>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201756>

I just want to correct my mistake in what i've just sent:

On 19 Jul 2012, at 23:20, Alexey Muranov wrote:

> because the owner of the branch can reset or rebase it anytime.  I do not develop on tracking branches.  In fact, i am not even using "git pull".

> I do not develop on tracking branches.

Of course i develop on "tracking" branches, i just got confused once again by pull/push thing: i develop on branches that track origin, not upstream.
I think they should be called "remotely tracked branches", so there would be "remote tracking branches" for pull and "remotely tracked branches" for push.

Alexey.