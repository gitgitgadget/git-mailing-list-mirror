From: Gabriel Filion <lelutin@gmail.com>
Subject: Re: Storing (hidden) per-commit metadata
Date: Mon, 22 Feb 2010 00:11:30 -0500
Message-ID: <4B821202.8070700@gmail.com>
References: <1266599485.29753.54.camel@ganieda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Jelmer Vernooij <jelmer@samba.org>
X-From: git-owner@vger.kernel.org Mon Feb 22 06:51:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjQa9-0007At-0v
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 06:11:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150Ab0BVFLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 00:11:35 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:26403 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940Ab0BVFLe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 00:11:34 -0500
Received: by qw-out-2122.google.com with SMTP id 8so409455qwh.37
        for <git@vger.kernel.org>; Sun, 21 Feb 2010 21:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=m9TwgWcDaJR5sMpzQuvOV2rx4TxU06EooBVIBqGaqEo=;
        b=RfkDzgxGNVIJuXWNAyg6M5O8KKpi0g62b2a56MqXTRewig/jWAg1P8pfqtJIeNvn5m
         oaVUpYE0X0QOjgduhwVJoOfSutakuscbb075/5hetdIjOMjsO+x56G8lRn0piLPwb9HF
         48HuTcSGkO55bv94pPCUhqyXNUavxiDT+yDF8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=SlL0jOm1N7IdzZYFwoqqyGwZ2cDCQcQ++wSLUwf3gYkWxi6CpbxL/vNlLihlF2WG/X
         n8XDp2OK77x+qTig4e5fBdizklJC6yo3Z53bKVWJ56Gq3l4KTxplVsTF3WQID8L+mLJ2
         B+u9BNnG8xIrvO2iT6ezlR2mQGLJOmySNKo6s=
Received: by 10.224.109.1 with SMTP id h1mr4554377qap.131.1266815493868;
        Sun, 21 Feb 2010 21:11:33 -0800 (PST)
Received: from ?192.168.2.202? (dsl-147-130.aei.ca [66.36.147.130])
        by mx.google.com with ESMTPS id 20sm2331670qyk.13.2010.02.21.21.11.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Feb 2010 21:11:33 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.5) Gecko/20100108 Lightning/1.0b1 Icedove/3.0
In-Reply-To: <1266599485.29753.54.camel@ganieda>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140607>

Hello,

On 2010-02-19 12:11, Jelmer Vernooij wrote:
> To allow round-tripping pushes from Bazaar into Git, I'm looking for a
> good place to store Bazaar semantics that can not be represented in Git
> at the moment. This data should ideally be hidden from the user as much
> as possible; it would e.g. contain mappings from git hashes to Bazaar
> ids. 
> 
What are you currently using for interacting with Bazaar repositories?

If you already have code for a remote helper, I would be interested in
helping you out. I started a discussion recently on this list about
staring such a script. Would you be willing to collaborate on having
this implemented?

-- 
Gabriel Filion
