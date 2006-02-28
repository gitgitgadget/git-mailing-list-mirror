From: Sam Vilain <sam@vilain.net>
Subject: Re: [ANNOUNCE] quilt2git v0.2
Date: Wed, 01 Mar 2006 09:55:05 +1300
Message-ID: <4404B8A9.4020303@vilain.net>
References: <20060228111115.GA32276@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 21:55:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEBsQ-000388-VR
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 21:55:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWB1UzS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 15:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbWB1UzS
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 15:55:18 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:37800 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S932393AbWB1UzQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Feb 2006 15:55:16 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id CC57060B2; Wed,  1 Mar 2006 09:55:14 +1300 (NZDT)
Received: from [127.0.0.1] (longdrop.watts.utsl.gen.nz [192.168.255.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 78B045D93;
	Wed,  1 Mar 2006 09:55:06 +1300 (NZDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Tejun Heo <htejun@gmail.com>
In-Reply-To: <20060228111115.GA32276@htj.dyndns.org>
X-Enigmail-Version: 0.92.1.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.watts.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16952>

Tejun Heo wrote:
> Hello, v0.2 of quilt2git available.  New in v0.2.
> 
> * handles new git HEAD file format properly (regular file storing ref: ...)
> 
> * makes use of mail format header from quilt patch description.  From:
>   becomes the author, Subject: the subject of the patch.  All commit
>   information should be maintained through git2quilt -> quilt2git now.
> 
> * --signoff option added.  This option is simply passed to git-commit.
> 
> * little fixes
> 
> http://home-tj.org/wiki/index.php/Misc
> http://home-tj.org/files/misc/quilt2git-0.2
> http://home-tj.org/files/misc/git2quilt-0.1
> 
> Thanks.
> 

FWIW, I have a similar script to import a quilt export as an stgit patch 
series, it's really simple but quite useful:

   http://vserver.ustl.gen.nz/scripts/import-quilt

Sam.
