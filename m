From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: [PATCH 0/7] contrib/subtree: Testsuite cleanup
Date: Fri, 13 Nov 2015 18:23:20 +0300
Message-ID: <20151113152320.GA8336@dell-note>
References: <1447381956-4771-1-git-send-email-greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: git@vger.kernel.org, techlivezheng@gmail.com, davvid@gmail.com,
	cbailey32@bloomberg.net, danny0838@gmail.com, prohaska@zib.de,
	th.acker@arcor.de, sschuberth@gmail.com, peff@peff.net,
	gitter.spiros@gmail.com, nod.helm@gmail.com, gitster@pobox.com
To: David Greene <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Fri Nov 13 16:23:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxGCG-0001Sh-Sl
	for gcvg-git-2@plane.gmane.org; Fri, 13 Nov 2015 16:23:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932765AbbKMPXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 10:23:25 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34127 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932478AbbKMPXY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 10:23:24 -0500
Received: by lffz63 with SMTP id z63so5507299lff.1
        for <git@vger.kernel.org>; Fri, 13 Nov 2015 07:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=vG99/SJNDEQ1u2ElfSZRCTPSMV9cxZTiv9zd7Uw0Xsc=;
        b=aXMTFcnAdCUzv0CIYQRjjdaxwDeR1h7vfS/GGEr90AMGbBSjR85REBHJ44UW8YnEGb
         s8V5wcCWTlsMdzh6Y5b2xeM7K6/JYTPfW3jb6wTQUeIRw2pfVahe3euWFSG1U0VZcqoI
         88IlxhNJXBS/q0u/MAUTuXOVcxKYSfGddVPg6DQg7CLVeyWbKNvG2wor63No6/387Z6u
         obMdR/fM3lXYGpXKhx3wRYfa5JTVHKJRUURid1YDtrRLHr+ygXfNBs8aygcTRcbvshuX
         9U6bcaBqOT2K9YnHFSL4qZ7RsLFVZQ7GMWL8fA6fuNyljONVgSvGrPr0fWe/XWIU4o+N
         eklA==
X-Received: by 10.25.168.140 with SMTP id r134mr10929167lfe.34.1447428203062;
        Fri, 13 Nov 2015 07:23:23 -0800 (PST)
Received: from localhost ([213.108.22.197])
        by smtp.gmail.com with ESMTPSA id i3sm3175564lbj.0.2015.11.13.07.23.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2015 07:23:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1447381956-4771-1-git-send-email-greened@obbligato.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281251>

On Thu, Nov 12, 2015 at 08:32:29PM -0600, David Greene wrote:
> Sending again with a proper From: address after rebasing on latest master.
> 
> Copying the maintainers because the origin patchset didn't get any
> comments and I'm unsure of how to proceed.
> 
> These are some old changes I have lying around that should get applied
> to clean up git-subtree's testbase.  With these changes post-mortem
> analysis is much easier and adding new tests can be done in an orderly
> fashion.
> 
> I have a number of future patches and further development ideas for
> git-subtree that require these changes as a prerequisite.
Please, could you take a look to the following thread
http://thread.gmane.org/gmane.comp.version-control.git/277343
to take into account the mentioned bug for your futher work?

Thank you
> 
>                         -David
> 
>  contrib/subtree/git-subtree.sh     |    2 +-
>  contrib/subtree/t/Makefile         |   31 +-
>  contrib/subtree/t/t7900-subtree.sh | 1366 +++++++++++++++++++++----------
>  3 files changed, 956 insertions(+), 443 deletions(-)
> 

-- 
Alexey Shumkin
E-mail: Alex.Crezoff@gmail.com
