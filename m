From: William Pursell <bill.pursell@gmail.com>
Subject: Re: [PATCH 2/3] Add -n/--no-prompt option to mergetool
Date: Fri, 24 Oct 2008 23:32:17 +0100
Message-ID: <49024CF1.5040406@gmail.com>
References: <1224583999-26279-1-git-send-email-charles@hashpling.org> <1224583999-26279-2-git-send-email-charles@hashpling.org> <48FDC1CA.2080800@op5.se> <20081021122655.GA29294@hashpling.org> <20081022211720.GA23146@hashpling.org> <7vr668tdvy.fsf@gitster.siamese.dyndns.org> <20081023064455.GA10675@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Andreas Ericsson <ae@op5.se>,
	Theodore Ts'o <tytso@mit.edu>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Sat Oct 25 00:34:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtVEJ-0006i9-Ql
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 00:34:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbYJXWc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 18:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbYJXWcZ
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 18:32:25 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:53034 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbYJXWcY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 18:32:24 -0400
Received: by nf-out-0910.google.com with SMTP id d3so477416nfc.21
        for <git@vger.kernel.org>; Fri, 24 Oct 2008 15:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=8DIpvQgqeJqBil5erZ/VrdDOXbEtGJpmjmdR601DklM=;
        b=lMSBpMHMEm0NWNOONPSA7v/wkY4YxlyodjYauigo/MK5SOcBU5U7FBCO3gbD7TWd9N
         ewmX2Lo5eBXbRo1JThs77bgq4aR4rzUGjF32hvEBA6VpAk76jD14eEt9A0mHFQPDYofy
         M12AKKdI30h0jsXevwjZwe1NzhA9EVPLrikQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=HWkM7VIkEhCCfOoqj6cVJTX3YltzLdd+YD+wdVwRbm5suN53Ip6UC4wfncY4hMFMaL
         ITKBtc7FtOSn1TpC3kfrc10quwQ5zE598tm+vbfpUa05BOg+kKkLJSMLBrAS/fG7fB3N
         0N5Q6PlF4TPxn9MNw0s+ZwQPpHJxLsIMSyXt0=
Received: by 10.210.43.11 with SMTP id q11mr3016482ebq.51.1224887542677;
        Fri, 24 Oct 2008 15:32:22 -0700 (PDT)
Received: from clam.local (5ad934ac.bb.sky.com [90.217.52.172])
        by mx.google.com with ESMTPS id t2sm1362256gve.5.2008.10.24.15.32.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Oct 2008 15:32:20 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.17 (Macintosh/20080914)
In-Reply-To: <20081023064455.GA10675@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99076>

Charles Bailey wrote:
> 
> After more thoughts, I'm somewhat in favour of dropping the short
> switch altogether. As it just saves a single keypress per merge I
> imagine that most mergetool users, once they discover this new
> feature and decide that they want to use it, will prefer to use a user
> config option to switch it on. The command line option then becomes
> something that you would only need to use to override your normal
> default and something on which to hang the option description in the
> man page. 

If the short option is dropped, the config option should
probably associated with mergetool.<tool>.interactive rather
than mergetool.interactive.  (s/interactive/whatever)


-- 
William Pursell
