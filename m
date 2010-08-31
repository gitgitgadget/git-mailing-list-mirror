From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC 07/17] gettext.c: work around us not using
 setlocale(LC_CTYPE, "")
Date: Tue, 31 Aug 2010 10:49:24 -0500
Message-ID: <20100831154924.GL2315@burratino>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
 <1283203703-26923-8-git-send-email-avarab@gmail.com>
 <20100831151800.GG2315@burratino>
 <alpine.BSF.2.00.1008311534390.12745@x.fncre.vasb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Marcin Cieslak <saper@saper.info>
X-From: git-owner@vger.kernel.org Tue Aug 31 17:51:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqT7s-0004YD-Gq
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 17:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476Ab0HaPvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 11:51:10 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:40510 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932368Ab0HaPvI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 11:51:08 -0400
Received: by pxi10 with SMTP id 10so2493233pxi.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 08:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=4R/1RgKJz3fdRQWkXJrfHekzhoDyS9of8JG0sNcVsm8=;
        b=Bv4hDFEKNOOoSXARL6kILHHxCn8UgYnWudnFVTy+UayLBfyDbDRW0fl0QgwBRIhPfo
         kUWNfif0auMCU5P9Nw5sfhDSTx5rbXAjJDg2qcfLB9UEyj7XQFBFpa4XxzdEfvyMEf7v
         drxD0l4po3iPUarR9/hm33TW49qHWXmJ0eQSM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dqAx+NmmeOiNLBNrqj/E7r0OHivLFpqMjasTv2XvbPr6ofQZteAPXsZPIIn6ykfgkp
         jP6wJpee2Dk+xg3EbtDlG4AGYkRUpo7eO7GaqKLiqGlQTRuOKOaFfj7ld0PT3huNSyut
         TrvZoVAzEoxykXqQiukeE1mOPuNsNBOM7a8Bo=
Received: by 10.142.216.6 with SMTP id o6mr6141778wfg.105.1283269868074;
        Tue, 31 Aug 2010 08:51:08 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id e18sm2901038vcf.36.2010.08.31.08.51.06
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 31 Aug 2010 08:51:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.00.1008311534390.12745@x.fncre.vasb>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154919>

Marcin Cieslak wrote:

> Speaking for FreeBSD:
> 
> % svn log -r21674 printf.3 ------------------------------------------------------------------------
> r21674 | jkh | 1997-01-14 08:31:39 +0100 (wto) | 8 linii
> 
> The following patch to lib/libc/stdio implements positional arguments in
> a manner consistent with other implementations.
[...]
> Solaris 9 has it, too.

Thanks for checking.  That's good to hear.
