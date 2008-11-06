From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: Bug: "git-svn fetch" segfaults on unknown user
Date: Thu, 6 Nov 2008 15:43:18 +0100
Message-ID: <237967ef0811060643g1037b8dbuf3660dfa8e3ff625@mail.gmail.com>
References: <20081106143826.GA26900@merkur.sol.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jens Seidel" <jensseidel@users.sf.net>
X-From: git-owner@vger.kernel.org Thu Nov 06 15:44:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ky666-0005A7-QN
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 15:44:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbYKFOnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 09:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbYKFOnV
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 09:43:21 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:5422 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbYKFOnU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 09:43:20 -0500
Received: by ug-out-1314.google.com with SMTP id 39so849613ugf.37
        for <git@vger.kernel.org>; Thu, 06 Nov 2008 06:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=SF6RTZEEZxedfoZ3Y6Zn/SVmu7KmEWKgZ51JrIHOPTo=;
        b=UAlMQuoeL5HIqDN0fDW1wIj2oc7hfLoxNw6Tuhs7Vaw96ZVMSko19gqc78TyY4jzTb
         UK+Lb7mfh2qx0d7b87T09xkeTvu12p0iCph6msfcPSpcP0Ic2yqGdgI6bHFBw1DSIh9Z
         ZPlomY5lxRq+NTtDE3u5cFedWwDx/uyt2elhg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=MtuYPWAm3iGMpnHIgdDG/wlfgkxzwz3xgmXmfOo4iVc99i3msUP7uXEBRYwr+IsjA1
         B50cuBiHlVxvxVZZJ4Obr/qYjLOmzXE88U6EZ99yZq/WcgQ3EjqtS+/e0m4bPa9iWFbS
         lCR4w4F+2YrXpYzwhQnxAH+BI+kytRR6jwdIU=
Received: by 10.210.19.11 with SMTP id 11mr298136ebs.168.1225982598673;
        Thu, 06 Nov 2008 06:43:18 -0800 (PST)
Received: by 10.210.73.14 with HTTP; Thu, 6 Nov 2008 06:43:18 -0800 (PST)
In-Reply-To: <20081106143826.GA26900@merkur.sol.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100238>

2008/11/6 Jens Seidel <jensseidel@users.sf.net>:
> Hi,
>
> I noticed the following bug in git-svn version 1.6.0.3 (svn 1.5.5):
>
> "git-svn fetch" segfaults if I provide an incomplete svn.authorsfile config
> file setting with account<-->email mappings. This happens if an unknown user
> account is found in the Subversion log.
>
> If I do not provide svn.authorsfile at all, it doesn't crash.

Are you sure this isn't the regular svn 1.5.x crash? Ie, does
compiling subversion with --disable-runtime-module-search fix it?

-- 
Mikael Magnusson
