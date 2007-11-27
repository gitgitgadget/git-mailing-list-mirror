From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git bug/feature request
Date: Tue, 27 Nov 2007 14:38:57 +0100
Message-ID: <200711271438.57950.jnareb@gmail.com>
References: <200711271127.41161.gapon007@gmail.com> <200711271350.38468.gapon007@gmail.com> <200711271431.21516.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Benoit Sigoure <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: gapon <gapon007@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 14:39:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix0f1-0001Fv-Vm
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 14:39:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752477AbXK0NjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 08:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbXK0NjF
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 08:39:05 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:5782 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbXK0NjD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 08:39:03 -0500
Received: by nf-out-0910.google.com with SMTP id g13so951003nfb
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 05:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=gq4eiSA7Rsd/4zHcwtH3Q736yEdixxxjfsl8SEbtFFE=;
        b=OieTAUxGHVIxg35hGpTIPa/7ZYpRMLhB1G9VOWlV4hAZuR/MKFNecLpDelsRwPgbRYX3LUwSUeIIHE9K0xTN5+NTbDVHYMW8TLHL/v337R2uGv7RaF6o9hMHdSyDcn4KTq9lbf+y+guAAdePu+ZsrPNHSeO7+N2rhKCSUqH8KFM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=wlEvUOl80k794sGTU34UFTAgIEg52S08NcklsmolfZXkrTnHUWz+hDFs9+yaUktNTmtt/kLhiKHa6LLnxwKtMUbVCxwMnVsKzwF4nOv/eLziyaXvOsWnrZhSzRc488Q76w7tqX3FDEbVWvmDUtrvHCZiOw5P4dowwFsSdYL/4HU=
Received: by 10.86.60.7 with SMTP id i7mr3864304fga.1196170741125;
        Tue, 27 Nov 2007 05:39:01 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.221.114])
        by mx.google.com with ESMTPS id l19sm3712282fgb.2007.11.27.05.38.58
        (version=SSLv3 cipher=OTHER);
        Tue, 27 Nov 2007 05:38:59 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200711271431.21516.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66207>

Jakub Narebski wrote:

> git-clone sets up repo B (the clone) for one direction of transfer,
> from repo A (cloned repo) to repo B (the clone). If you want to push
> to repo A, you should configure repo B to do so.
> 
> See also comments below.

What I forgot to add that git encourages "with integrator" workflows:
either send requests to pull to project maintainer, or send patches
(which allow peer review of them) to maintainer, perhaps via public
project mailing list.

You can do "centralized repository" or "peer to peer" aka "star
topology" workflows, but it is not optimized for those workflows;
you have to work a bit harder.

-- 
Jakub Narebski
Poland
