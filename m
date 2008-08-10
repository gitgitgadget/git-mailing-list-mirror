From: "Ken Pratt" <ken@kenpratt.net>
Subject: Re: pack operation is thrashing my server
Date: Sun, 10 Aug 2008 16:34:27 -0700
Message-ID: <a6b6acf60808101634n2d8c5610vdeeb17865457eb0f@mail.gmail.com>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
	 <46a038f90808101606j7534b855j9205ae219c350c94@mail.gmail.com>
	 <a6b6acf60808101612l300227e9od97e767fe4621dc5@mail.gmail.com>
	 <46a038f90808101630k4bcdef91h64189a2991106174@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 01:35:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSKRe-00086N-Q6
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 01:35:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918AbYHJXe2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 19:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752778AbYHJXe2
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 19:34:28 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:2932 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546AbYHJXe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 19:34:27 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1980969rvb.1
        for <git@vger.kernel.org>; Sun, 10 Aug 2008 16:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=cpMZMITK+gzf+JhUkdjwPHub9NNo1O8eBzKSDO0ow/w=;
        b=FlmfkGU9Fbq1TiUDprloqw1Kcaq1nKID24gjpDkIqNPFxnRaOebh+H45FFFsiYGWGZ
         kShxh2lBN6Cw8OFUChfNn5MNlcD9j2zNw4lzJgmSuuMgIWB+PoZjfdYWFT+5gsiXZYcV
         zRI0QAF5w1ruLiGn1PlWodew74/D4zZzmrGAU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=klhSzVUIpn+3GUyUqywGvFm3HniBBRktdrrwtfWbHkpiEmNGcXDPEnQhf1xMLOnhqx
         ncW4RnfNbWnfj8Z7kcq7mfp8xgdNVpcGPTz5Ov0W3TgkIv4FfGhpfuUdN2qsihzJlTsw
         K+R7646rI+RQaG1Mjim/pgDtiJwYV7BDTls6g=
Received: by 10.141.137.16 with SMTP id p16mr3047563rvn.192.1218411267415;
        Sun, 10 Aug 2008 16:34:27 -0700 (PDT)
Received: by 10.141.42.15 with HTTP; Sun, 10 Aug 2008 16:34:27 -0700 (PDT)
In-Reply-To: <46a038f90808101630k4bcdef91h64189a2991106174@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: bc51feee13324229
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91904>

Sounds good.

>> How does git over rsync work? It is unauthenticated, like git over
>> http? Or authenticated, like git+ssh?
>
> I've always used it as rsync+ssh. Not sure about bare rsync.

Do you use file-level rsync+ssh? Or rsync+ssh with git?

When I try a "git clone rsync+ssh://foo.bar.com/var/git/bar", I get a
"fatal: I don't handle protocol 'rsync+ssh'" error.

I know git supports the rsync protocol, but I don't think installing
an rsync server and using bare rsync will be an option in this case.

Thanks again,

Ken
