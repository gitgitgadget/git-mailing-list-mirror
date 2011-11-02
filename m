From: Pat Thoyts <patthoyts@gmail.com>
Subject: Re: [msysGit] Re: [PATCHv2] Compile fix for MSVC
Date: Wed, 2 Nov 2011 00:48:37 +0000
Message-ID: <CABNJ2G+Km4wob4_uNYQLkQUL61-ohZg5cL2yu7j1cngoL9W7Cw@mail.gmail.com>
References: <1320088364-25916-1-git-send-email-vfr@lyx.org>
	<7vd3dcq4s5.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.1.00.1110311908240.1930@bonsai2>
	<CABPQNSaCRRRpEQPG1Mb4DovkMdQSBhHTm-i7y5M4iT+ndHX4XA@mail.gmail.com>
	<alpine.DEB.1.00.1111011332400.32316@s15462909.onlinehome-server.info>
	<CAAH6HY8WfOQQ4g54y7mriq6BKoJCWYsVPrQUTMndqpKdniLAtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	ramsay@ramsay1.demon.co.uk, msysgit@googlegroups.com,
	Karsten Blees <blees@dcon.de>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Wed Nov 02 01:48:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLP0X-0003Qq-Jv
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 01:48:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753413Ab1KBAsj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Nov 2011 20:48:39 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35462 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041Ab1KBAsj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2011 20:48:39 -0400
Received: by vws1 with SMTP id 1so19838vws.19
        for <git@vger.kernel.org>; Tue, 01 Nov 2011 17:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2JFvQbIM8U0LjlyH8Alrokf17l5r+7MqRAYRGg7v180=;
        b=RQQvlP+qFgeRZUfPN0mkXMY8LfFrcDPtq736M+b6hXGfMDf3dbOekjGNMyDZlC1Ety
         bpXk0KswPg6D53ScFjAdNf/AnwLwgqxz5sdS96/A8vDTS0wt7xQcWGp/rXfJAzmAvHWV
         zvRS0GTgUu8LiTFQjH9PU332JH05+VSyiuc4c=
Received: by 10.52.114.232 with SMTP id jj8mr2030755vdb.94.1320194918315; Tue,
 01 Nov 2011 17:48:38 -0700 (PDT)
Received: by 10.52.114.73 with HTTP; Tue, 1 Nov 2011 17:48:37 -0700 (PDT)
In-Reply-To: <CAAH6HY8WfOQQ4g54y7mriq6BKoJCWYsVPrQUTMndqpKdniLAtw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184609>

On 1 November 2011 22:32, Vincent van Ravesteijn <vfr@lyx.org> wrote:
>
>> Maybe if someone donates Jenkins resources, we could make an automatic
>> branch in the future that has git.sln in it (similar to the 'html' branch
>> in git.git).
>>
>
> As long as this means to just run a not so complicated perl script, this
> Could even be done in a commit hook.
>
> Just another question. How does the (msys)git community feel about adding
> CMake support ? I can probably do that quite easily.
>
> Vincent
>

-1. We have a make. We don't need two of them.
