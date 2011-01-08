From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: different name and email address depending on folder
Date: Sat, 8 Jan 2011 13:59:59 +0530
Message-ID: <20110108082957.GE27334@kytes>
References: <3178E076-FA22-4C3C-BEB2-2581A0E12086@gmail.com>
 <20110108073928.GD27334@kytes>
 <A1770B45-1A98-49C3-8CD0-C61A51FFB66E@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rich Eakin <reakinator@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 08 09:29:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbUAr-0001WV-VK
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 09:29:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403Ab1AHI3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jan 2011 03:29:05 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54319 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366Ab1AHI3D (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jan 2011 03:29:03 -0500
Received: by iyi12 with SMTP id 12so16417019iyi.19
        for <git@vger.kernel.org>; Sat, 08 Jan 2011 00:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=rysiRyrhrW01OZxPOyam/I4o5B17uTJKFR5etOEFUj4=;
        b=Xoll48kFGZhfAQFXi6H1V1v/jyJJsNSMxLwAJqL3dM7b3DaCCLfXoZhiKtlZAt3ACf
         6CYE41q0Q6VdIztw0tkyW/a7OrSduUFTlSZql3AMyRQZ6Egrtz/0wsZaNgVkDmj+PiB2
         hE5DpjIFBuT2Rq+7GNBgaOfkI2CSnP/xsvWA8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CeOan0c68R0UcWq+p/2Ydu3HAvCsItR8SOfXCENGcYHVBFRQScCbWBPy7kIM4eKI1P
         8RuV2OBQX6/GsA7MKn4se9WZIMoacNcL0vi5tYWSlL23Sy35VDofwy/s8KhrE3faIXZm
         9lWUpy8I+8A00AHzwC55JWS5BdUdt7qRKHWgk=
Received: by 10.42.2.139 with SMTP id 11mr1811653ick.490.1294475342712;
        Sat, 08 Jan 2011 00:29:02 -0800 (PST)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id d21sm23781326ibg.3.2011.01.08.00.28.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 Jan 2011 00:29:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <A1770B45-1A98-49C3-8CD0-C61A51FFB66E@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164811>

Hi Rich,

Rich Eakin writes:
> I am currently using git-config in a bash script to set my user / email.  I was wondering if it was possible to tell git that if I am in a certain directory to use a specific user / email other than what is in my global config.  

It's possible on a per-repository basis, as I pointed out in the last
email; but no- I don't think it's possible on a per-directory basis
within the same repository. You might consider separting your private
work from your company's repository.

p.s- I think you've used the term "global" incorrectly here. Global
configuration applies to all repositories. Per-repository
configuration overrides the global configuration for that repository.

-- Ram
