From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [msysGit] Re: [PATCHv2] Compile fix for MSVC
Date: Fri, 04 Nov 2011 16:39:43 +0100
Message-ID: <4EB4073F.6070100@gmail.com>
References: <1320088364-25916-1-git-send-email-vfr@lyx.org> <7vd3dcq4s5.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.1110311908240.1930@bonsai2> <CABPQNSaCRRRpEQPG1Mb4DovkMdQSBhHTm-i7y5M4iT+ndHX4XA@mail.gmail.com> <alpine.DEB.1.00.1111011332400.32316@s15462909.onlinehome-server.info> <CAAH6HY8WfOQQ4g54y7mriq6BKoJCWYsVPrQUTMndqpKdniLAtw@mail.gmail.com> <CABNJ2G+Km4wob4_uNYQLkQUL61-ohZg5cL2yu7j1cngoL9W7Cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Vincent van Ravesteijn <vfr@lyx.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	ramsay@ramsay1.demon.co.uk, msysgit@googlegroups.com,
	Karsten Blees <blees@dcon.de>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Pat Thoyts <patthoyts@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 04 16:42:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMLu3-0007VN-EO
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 16:41:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296Ab1KDPly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Nov 2011 11:41:54 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55405 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755419Ab1KDPlx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2011 11:41:53 -0400
Received: by bke11 with SMTP id 11so2051563bke.19
        for <git@vger.kernel.org>; Fri, 04 Nov 2011 08:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=+VPzu5Gv+5U144Iimd6Upr+BRQ6lmUxfla33iW8v3+M=;
        b=oLFupZWJGk+fMlbAnCniIGb5F1yz4wma1sjMFkHT79GAVUeTFCO5MlFZYY0kf6jDyO
         CxMxo6vaOwpaDS47zGEq5Xz0VbPEFWInjXFsthY1twPs93Yjzp5EUojpmCtdqGLasCgk
         btLCsKZnHZm5yFRSUoVu/iE2TIzyKkK2/Zl6c=
Received: by 10.204.141.211 with SMTP id n19mr12438469bku.71.1320421312464;
        Fri, 04 Nov 2011 08:41:52 -0700 (PDT)
Received: from [130.73.68.203] (jambul.zib.de. [130.73.68.203])
        by mx.google.com with ESMTPS id x14sm9185735bkf.10.2011.11.04.08.41.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 Nov 2011 08:41:50 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git,gmane.comp.version-control.msysgit
In-Reply-To: <CABNJ2G+Km4wob4_uNYQLkQUL61-ohZg5cL2yu7j1cngoL9W7Cw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184776>

On 02.11.2011 01:48, Pat Thoyts wrote:

>> As long as this means to just run a not so complicated perl script, this
>> Could even be done in a commit hook.
>>
>> Just another question. How does the (msys)git community feel about adding
>> CMake support ? I can probably do that quite easily.
>
> -1. We have a make. We don't need two of them.

I don't see CMake as an alternative to make as CMake would be used to 
generate the Makefile, which is currently hard-coded and committed.

However, I don't see any benefit in using CMake as long as the Linux 
guys don't use it to create their Makefile, too.

-- 
Sebastian Schuberth
