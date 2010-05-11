From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: [PATCH/RFC] autocrlf: Make it work also for un-normalized repositories
Date: Tue, 11 May 2010 18:31:38 +0200
Message-ID: <13E8F544-9351-4B1F-9E4B-B625D20E2A8C@gmail.com>
References: <20100510171119.GA17875@pvv.org> <20100510194321.GG14069@dpotapov.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org,
	msysgit@googlegroups.com, Junio C Hamano <gitster@pobox.com>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 11 18:31:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBsNA-0002mH-Pn
	for gcvg-git-2@lo.gmane.org; Tue, 11 May 2010 18:31:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754664Ab0EKQbn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 May 2010 12:31:43 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:58102 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752699Ab0EKQbl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 May 2010 12:31:41 -0400
Received: by ey-out-2122.google.com with SMTP id 9so259754eyd.5
        for <git@vger.kernel.org>; Tue, 11 May 2010 09:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=s9ZMn77XHfNFK7xllF6Nl9A70Fk5Cn8WdAkWtLVWruA=;
        b=H1rWdV6mwJiUCEcwdkOpbDSkhfhv0oVcYAwJS/yLkokTggtyayvZ0DlguY2xJbCFXW
         91nRRozre8cRLzvAQTDgD3g294rljUHiIzC+eJIPxdfNQ5MHKA11I3tWmsOXmu96EvVs
         RqSFG/zjUWGE0uCGkqmqo+1mLB0R4HwYeBJyg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=hIgWluqD2mkE8gsuo8w/alO1LiIGTVmfTmS5OTtYvoEOAMX/SBwXOs/rvCxe7J7PDx
         EE/NvX53ZGBYjWk5Dt3WM6K4gEQTVxynWc/AiWkk30yLLcz+2MzQ0wxItZSStuxCHn3+
         vx8nT4xVZook5eQCThGoJ+TbIABpcZI4eG0Zk=
Received: by 10.213.59.77 with SMTP id k13mr2245834ebh.38.1273595500267;
        Tue, 11 May 2010 09:31:40 -0700 (PDT)
Received: from vredefort.d.eyvind.bernhardsens.net (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 13sm3183113ewy.5.2010.05.11.09.31.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 11 May 2010 09:31:39 -0700 (PDT)
In-Reply-To: <20100510194321.GG14069@dpotapov.dyndns.org>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146901>

On 10. mai 2010, at 21.43, Dmitry Potapov wrote:

> It does not really solve #2, because you will have the wrong ending for
> files that must be LF, such as shell scripts, and then these scripts
> fail with some weird error...

That's okay, because I'll solve that in my next iteration with "crlf=crlf" and "crlf=lf" (yes, I know).  Finn Arne's patch is about fixing the current broken behaviour when autocrlf is enabled in a repository containing CRLFs, while mine's the one you need if you want normalized text files in your repository.
-- 
Eyvind
