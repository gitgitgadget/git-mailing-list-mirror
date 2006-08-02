From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] gitweb.cgi: Customization
Date: Wed, 2 Aug 2006 21:31:17 +1200
Message-ID: <46a038f90608020231l37de81f0i5f14c7c264fc40bd@mail.gmail.com>
References: <20060801225352.26998.qmail@web31801.mail.mud.yahoo.com>
	 <7v8xm8xbaa.fsf@assigned-by-dhcp.cox.net>
	 <E1G8ArX-0006r2-6D@moooo.ath.cx> <E1G8CUz-0002KI-VW@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Aug 02 11:31:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8D4U-0000ya-2d
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 11:31:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWHBJbT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 05:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWHBJbT
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 05:31:19 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:29543 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751278AbWHBJbS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Aug 2006 05:31:18 -0400
Received: by nf-out-0910.google.com with SMTP id o25so576846nfa
        for <git@vger.kernel.org>; Wed, 02 Aug 2006 02:31:17 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dz+mzFuooEUnGKKYXbot0nwqibg8sCJCOQfvCUdG+26HowpqyJzxYoA1WzFzkbeJgaAlSWi1lX3Szr76/6T52oUAeA97o/hMnaEU5kRxPWo8SgoxlE9o3QPPVDEnOe91sA+XWUYJyInJV6Z5prsUDjtgLqDlhpjRCP53/65AILo=
Received: by 10.78.193.19 with SMTP id q19mr231244huf;
        Wed, 02 Aug 2006 02:31:17 -0700 (PDT)
Received: by 10.78.120.17 with HTTP; Wed, 2 Aug 2006 02:31:17 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	"Martin Waitz" <tali@admingilde.org>,
	"Luben Tuikov" <ltuikov@yahoo.com>
In-Reply-To: <E1G8CUz-0002KI-VW@moooo.ath.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24642>

On 8/2/06, Matthias Lederhofer <matled@gmx.net> wrote:
> Just another idea: add something like @@FOO@@ on a line of its own and

We kind-of had that in a few Perl scripts before, and it's a mighty
pain to develop and debug from your git repo because it makes your
checked-in code invalid.

You might want to see this patch:
http://kernel.org/git/?p=git/git.git;a=commitdiff;h=e923effb43fa952f9cb72ffe4c3625fce7655bff;hp=ced9456a27197fc038fbc5b5ebad87e55f1920d2

cheers,



m
