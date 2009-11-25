From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] gitweb.js: Harden setting blamed commit info in incremental
 blame
Date: Tue, 24 Nov 2009 20:01:50 -0800
Message-ID: <4B0CAC2E.1060105@gmail.com>
References: <1258659887-5244-1-git-send-email-bebarino@gmail.com> <200911210132.44649.jnareb@gmail.com> <200911211556.52175.jnareb@gmail.com> <200911250145.16472.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 05:01:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ND94o-0003Sw-Nd
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 05:01:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934284AbZKYEBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2009 23:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934275AbZKYEBr
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 23:01:47 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:63188 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934212AbZKYEBr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 23:01:47 -0500
Received: by yxe17 with SMTP id 17so6268476yxe.33
        for <git@vger.kernel.org>; Tue, 24 Nov 2009 20:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=7xK23nIb19S72J6/zYSqCnaas3DcpmELDTUkbMloMf8=;
        b=xsPNE0r9YtVotGLWHhr+CIrAyaE/DvPUM9CikVXhlNVQiqYKJEtWVZl9V+i4fpC5/N
         HA33F1azYmbx7ECVCa129JqYBmW4WArrlkHGSetxCR6geQRctPakv8Gx7TIa1NdJmpSn
         p9PtQ0sfiXei1kzvY03xwdSO6lJzqjpkJ95jQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=VgLuDtj4eRzv7zY+FMGF+0E8KC8rpI/d0aS6UhjsZE9I5xp8yFPj+rLBtcVVcsmUVs
         nm+NYwQ6hBVa7/p7qraDwVAZ41qhDMVuIR29dJmcajyB4eL6dHHXKrtSGjHopAzwWpGe
         JUyFEJu6NwDT6qw6yh2Ndig2wdVSenNwHag+I=
Received: by 10.150.38.3 with SMTP id l3mr11785894ybl.239.1259121713435;
        Tue, 24 Nov 2009 20:01:53 -0800 (PST)
Received: from ?192.168.0.5? (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 9sm2112092ywf.50.2009.11.24.20.01.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Nov 2009 20:01:52 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20091026)
In-Reply-To: <200911250145.16472.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133612>

Jakub Narebski wrote:
>
> Debugging this is serious PITA.  After fix below it appears that this bug
> is some intermittent bug, depending on XMLHttpRequest timing.  It more
> often than not (at least when I tried to debug it using build-in IE8
> debugger) works correctly for the folowing files: README, GIT-VERSION-GEN,
> revision.c (once even it did fail when first running for given file, and
> then running correctly when reloading from debugger; fun it is not).
>
> It does consistently fail for gitweb/gitweb.perl... but when I tried
> to debug it IE8 would hang up when trying to use debugger (with around
> 600MB available RAM).  Perhaps somebody else would have more luck...

Interesting. I don't have time to look into this until early December, 
but if it's still around then I'll take a look. I wonder if IE6 or IE7 
works (I don't think everyone is on version 8 yet).
