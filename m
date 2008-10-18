From: William Pursell <bill.pursell@gmail.com>
Subject: Re: [PATCH] feature request: git-mergetool --force
Date: Sat, 18 Oct 2008 19:44:47 +0100
Message-ID: <48FA2E9F.3090305@gmail.com>
References: <48F91E59.50202@gmail.com> <20081018154824.GA20185@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 18 20:46:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrGob-0003fU-HY
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 20:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbYJRSox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 14:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbYJRSox
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 14:44:53 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:64341 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155AbYJRSow (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 14:44:52 -0400
Received: by ey-out-2122.google.com with SMTP id 6so382208eyi.37
        for <git@vger.kernel.org>; Sat, 18 Oct 2008 11:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=5n2003h62RGKjuiB9+lUswbVusrXz85i+gRo3XlvmD0=;
        b=rR3OEnMSM9VcDw+F2jYt6MRV6czjj3FYX3RUx4bF1pQ+7QuNZiRvtx4jz41elp4JLl
         rZDgVqEmuvxQSymfxBBydy2PWNzIZ035ZV0kUnpnE3egK5eJu2enMx+7mzrAN15p0iht
         NVfz2KwTdOVmL5ssOCmJfRD3ao8aQCirgQ78o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=UhWByZRLwnd9ZyjLQsyTnykbuZMjpDrGBedHmifZ1ImYrv9rmHY41tbR65mff+hUwq
         x+/S8tfOFPtRLn7nvMBnpvLFmvKe9JMJMt2ALRZM16I6dWnvepZ4QdEUQp+tM7ssV2GC
         zEL3nKeEuA3rtGxc/i29vSdf1Y2VTfWL4FwSc=
Received: by 10.210.137.14 with SMTP id k14mr6259480ebd.173.1224355490774;
        Sat, 18 Oct 2008 11:44:50 -0700 (PDT)
Received: from clam.local (5ad934a0.bb.sky.com [90.217.52.160])
        by mx.google.com with ESMTPS id p10sm4628774gvf.7.2008.10.18.11.44.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 18 Oct 2008 11:44:49 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.17 (Macintosh/20080914)
In-Reply-To: <20081018154824.GA20185@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98566>

Jeff King wrote:
> On Sat, Oct 18, 2008 at 12:23:05AM +0100, William Pursell wrote:
> 
>> I occasionally use commands like 'cp $REMOTE $MERGED' with
>> mergetool, and would prefer to not be prompted to start
>> the tool on each file.  A --force option would be handy.
> 
> I think it is reasonable to want to skip this prompt, but I am not sure
> "--force" is the right name for such an option. Usually we reserve
> --force for "the tool is trying to prevent something destructive or
> unusual, and the user wants to override it".
> 
> Something like --no-prompt makes more sense to me, though probably
> something a little easier to type would be nice (or maybe alias "-n").

Actually, perhaps an "interactive=no" configuration setting,
which might imply trustExitCode = true.

-- 
William Pursell
