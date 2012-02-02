From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 1/4] completion: be nicer with zsh
Date: Thu, 2 Feb 2012 02:16:22 -0600
Message-ID: <20120202081622.GB3823@burratino>
References: <1328145320-14071-1-git-send-email-felipe.contreras@gmail.com>
 <1328145320-14071-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 09:16:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsrqX-0007Yq-FU
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 09:16:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754288Ab2BBIQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 03:16:41 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:58490 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753981Ab2BBIQk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 03:16:40 -0500
Received: by obcva7 with SMTP id va7so2434760obc.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 00:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=geaOmtCehrmqxZB/ePbhV88JFHbQX8MdnC3Ms8R69u8=;
        b=bA5zAMwJiZcrfpneFfBFtYad7yMYGwwzPhmoyhmLFebGDFAJKd0M9zCG/Wtr1bRZMF
         gBmesTP+lrP+Vy1dsmGf2eAhthsbeECPJiWjr2YF23fgVpC6ZbTpDWFSeR7CKOWzNALo
         AG+z3VAQ9AXQTnw6u+wCf3ZwSnTA62IRf7uS4=
Received: by 10.50.10.225 with SMTP id l1mr2130516igb.9.1328170599694;
        Thu, 02 Feb 2012 00:16:39 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id f8sm3639782ibl.6.2012.02.02.00.16.38
        (version=SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 00:16:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1328145320-14071-2-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189590>

Felipe Contreras wrote:

> And yet another bug in zsh[1] causes a mismatch; zsh seems to have
> problem emulating wordspliting, but only on the command substitution.

Patches didn't hit the list again.  Any idea why?
