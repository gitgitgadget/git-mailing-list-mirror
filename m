From: "Sitaram Chamarty" <sitaramc@gmail.com>
Subject: Re: detecting rename->commit->modify->commit
Date: Fri, 2 May 2008 07:36:18 +0530
Message-ID: <2e24e5b90805011906g769723f0g3ffbbe6588cf23d0@mail.gmail.com>
References: <4819CF50.2020509@tikalk.com>
	 <20080501144524.GA10876@sigill.intra.peff.net>
	 <4819DCF1.7090504@tikalk.com>
	 <20080501152035.GB11145@sigill.intra.peff.net>
	 <20080501203940.GA3524@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, "Ittay Dror" <ittayd@tikalk.com>,
	git@vger.kernel.org
To: "Teemu Likonen" <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Fri May 02 04:07:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jrkg1-0003Ij-Ll
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 04:07:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755849AbYEBCGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 22:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755740AbYEBCGV
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 22:06:21 -0400
Received: from ti-out-0910.google.com ([209.85.142.187]:65383 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181AbYEBCGU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 22:06:20 -0400
Received: by ti-out-0910.google.com with SMTP id b6so239991tic.23
        for <git@vger.kernel.org>; Thu, 01 May 2008 19:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=cTrcldlpBkfjs38JOur/VQC3nVVTTuCK9s2ZhCUVVVY=;
        b=aNTurL0yWUvvLaG5qMBelEam2E+dC8drhgbkorZ8yZ1MTFkoMt9Rp9LdPnFvtiIyUZP/+dAVhdS5Hysh+3LgXpKof4/HJLQJLZ7C5nsbNal22YHqzEZY2tCXUNkyPPXu0sAzTdWDhIlSRXRGZTFwv7UKb35KkCY79YPvzNb/FXA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eKWelwQ3HUPbEnuBjg8HvbdjtbDofq/4E3Yia/8yAlflKJBvNGvT7fVw+lP7VPONG/UpFw4fytK/TkzXtrYm5+wuY5fPbCxIZxPJIihuu4k9dBOlpCm0Q6Jh4Q6Cl8DDeyHRM6vwVssckFoqhg+O3m7auGcpXVfoibSlWBsaUaE=
Received: by 10.110.5.14 with SMTP id 14mr247911tie.10.1209693978899;
        Thu, 01 May 2008 19:06:18 -0700 (PDT)
Received: by 10.110.52.10 with HTTP; Thu, 1 May 2008 19:06:18 -0700 (PDT)
In-Reply-To: <20080501203940.GA3524@mithlond.arda.local>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80948>

On Fri, May 2, 2008 at 2:09 AM, Teemu Likonen <tlikonen@iki.fi> wrote:

>  -M" didn't detect the rename but "git diff -M4" did. To me it looks like
>  this works nicely, better than I expected, actually.

err... I didn't realise -M had an option, and I just double checked
the man pages for diff, diff-files, diff-index, and diff-tree.  What
does the 4 mean?

Sitaram
