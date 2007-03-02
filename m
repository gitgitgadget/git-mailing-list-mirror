From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Memory overrun in http-push.c
Date: Fri, 2 Mar 2007 15:48:48 +0000
Message-ID: <200703021549.05761.andyparkins@gmail.com>
References: <20070228151516.GC57456@codelabs.ru> <200703021523.37010.andyparkins@gmail.com> <vpqd53racjg.fsf@olympe.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 02 16:49:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNA0S-0003xq-I5
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 16:49:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992531AbXCBPtN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 10:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992532AbXCBPtN
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 10:49:13 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:21765 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992531AbXCBPtM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 10:49:12 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1328144nfa
        for <git@vger.kernel.org>; Fri, 02 Mar 2007 07:49:11 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QdimwGaQmSRW6yMFLR8D9UMRp61ZcQ7tE9TqiB/TNDrNVK//F0lZ6VVeseqF1FAOjAO+RdgmZNkmiUgEiWhgQmIIGgI9FVmBR/jhulc3finedRSsFEdGaBQuwhsIxBMWgZcLvT1fV/HTfAne8Qm7/tAznAVRklPV405+w5fC7ng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qzCxEITy1eOKwUECQh08uwd/7sILfBCX5cH0IcTtAJMTyTXlKCuz8BkVo2m4ELnyBAn9bhbDRxpB3Cwy8bwXUCGphgrlWppLzOC6bbhCjKGC/w2L3ceuTup0iyeKwuhxsO82HeNVZjYd/bxOA0+G/XJVq7oilS+3it1fm4n+w4Q=
Received: by 10.49.41.12 with SMTP id t12mr7976834nfj.1172850551021;
        Fri, 02 Mar 2007 07:49:11 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id c10sm12630711nfb.2007.03.02.07.49.08;
        Fri, 02 Mar 2007 07:49:08 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <vpqd53racjg.fsf@olympe.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41221>

On Friday 2007 March 02 15:30, Matthieu Moy wrote:

> A (dirty too) solution is to have a pre-commit hook that would update
> the keywords for each modified file. Then, the keyword is in the
> source itself.

That would be bad for merges though.  I think it's got to be filtered out in a 
pre-commit or equivalent script.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
