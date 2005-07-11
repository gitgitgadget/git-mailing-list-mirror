From: Bryan Larsen <bryan.larsen@gmail.com>
Subject: Re: [PATCH 3/6] git-gnu-progs-Makefile: git Makefile update
Date: Mon, 11 Jul 2005 16:22:08 -0400
Message-ID: <42D2D4F0.4050203@gmail.com>
References: <20050711101417.10318.64006.sendpatchset@bryan-larsens-ibook-g4.local>	<20050711101454.10318.70399.sendpatchset@bryan-larsens-ibook-g4.local>	<7vk6jxupxs.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.58.0507111206240.17536@g5.osdl.org>	<42D2CBA2.8060705@yahoo.com> <7virzhrtfy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Bryan Larsen <bryanlarsen@yahoo.com>,
	Linus Torvalds <torvalds@osdl.org>, pasky@suse.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 01:56:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds88H-0008KV-9u
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 01:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262678AbVGKUnF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 16:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262617AbVGKUWz
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 16:22:55 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:19863 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262593AbVGKUWL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2005 16:22:11 -0400
Received: by zproxy.gmail.com with SMTP id f1so429151nzc
        for <git@vger.kernel.org>; Mon, 11 Jul 2005 13:22:10 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=iqtIlKvKvMGOIegNtEfsVTruHe0g8+RBaFHY/CY9dChfvWoGbeJ0k5KyHd/v7nKsYjLlIu+3l5uszvCoEktWgAstoQyXqlDFSXaV2cz3gtJUYhwHTSF/IAphw3Ms3qXwbkgjpv4q+JTBGrqoJPDTghzeYSgdOBweIGlYQtN8SXY=
Received: by 10.36.222.33 with SMTP id u33mr1233856nzg;
        Mon, 11 Jul 2005 13:22:10 -0700 (PDT)
Received: from ?192.168.2.80? ([69.159.204.165])
        by mx.gmail.com with ESMTP id 15sm1933988nzp.2005.07.11.13.22.09;
        Mon, 11 Jul 2005 13:22:10 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virzhrtfy.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> 
> The only user of "cp -l" in the Linus GIT is git-clone-script
> local optimization.  I could revert it to the version that I
> originally sent to the list, which uses cpio -pld, if your cpio
> groks that flag.

Those options are in the man page, at least.

Bryan
