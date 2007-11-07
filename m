From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 0/5] some shell portability fixes
Date: Wed, 7 Nov 2007 23:05:35 +0700
Message-ID: <fcaeb9bf0711070805x49228d8dq7e8e6f26060c47ab@mail.gmail.com>
References: <20071106201518.GA6361@ins.uni-bonn.de>
	 <7v8x5bgl04.fsf@gitster.siamese.dyndns.org>
	 <fcaeb9bf0711070758w5832ab83ic16e8fb4edb80972@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Ralf Wildenhues" <Ralf.Wildenhues@gmx.de>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 07 17:06:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpnPj-00013p-8z
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 17:06:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753535AbXKGQFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 11:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753435AbXKGQFi
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 11:05:38 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:50828 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbXKGQFh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 11:05:37 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2051580nfb
        for <git@vger.kernel.org>; Wed, 07 Nov 2007 08:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=pB3cJsrqNim3DLkti/3qczuI200UM6SPS/joJmxQszM=;
        b=o2DKow2sBqhPl6fbMHeOxzPJaqMc7vMheGEzJEIN/JQ6Pu1wDpCFRYW4ETxAF4KTewLtXCLepqeGSEprgS3Hr1oWje30gLr/BexNyxuLxYY365o9T2S40bN3y4MVGum8pZaYePumeOQm1Acjr2cf4qi1QmKYhXmNIbynkO+1660=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jPkDtoYaYPmqODt+1wndHoSYXT+EgYfrib9BPbXaZIZ7K2sV9oUYOeBsJ1H0xjL4nSZZb0Al7sLuiheYVcG1LZoJEt5tyOpEjXoHfjs3mw3teo/Jabb6IBebvQAMuc0OcSaKu/7U0cB2hkJkJSNsyN4VH943bx/RCu/GrdLRZCM=
Received: by 10.86.4.2 with SMTP id 2mr5375337fgd.1194451535899;
        Wed, 07 Nov 2007 08:05:35 -0800 (PST)
Received: by 10.86.66.20 with HTTP; Wed, 7 Nov 2007 08:05:35 -0800 (PST)
In-Reply-To: <fcaeb9bf0711070758w5832ab83ic16e8fb4edb80972@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63831>

On 11/7/07, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On 11/7/07, Junio C Hamano <gitster@pobox.com> wrote:
> > [2/5] Gaah, AIX sed X-<.  I am not opposed to this patch but
> >       would want to get Yays from people with non GNU sed.  Is
> >       busybox sed good enough to grok our scripts these days?
> >       Please ask help and collect Acks at least from folks on
> >       Solaris, MacOS, FBSD, and OBSD.
>
> I haven't extensively used all the scripts. There seems to be no
> sed-related failure from git testsuite results in my git-box branch.
> So I would say for now it's good enough.

Argh, should have made it clear, busybox sed is good enough.

-- 
Duy
