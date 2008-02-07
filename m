From: "Jay Soffian" <jaysoffian+git@gmail.com>
Subject: Re: [PATCH] allow setting GIT_WORK_TREE to "no work tree"
Date: Thu, 7 Feb 2008 02:13:39 -0500
Message-ID: <76718490802062313jdbd0e84xc9f36d703bb86c44@mail.gmail.com>
References: <20080206102608.GA1007@coredump.intra.peff.net>
	 <47A98F07.4000402@viscovery.net>
	 <20080206110131.GA4167@coredump.intra.peff.net>
	 <7v4pclvmae.fsf@gitster.siamese.dyndns.org>
	 <7vwsphu7gr.fsf@gitster.siamese.dyndns.org>
	 <20080207051317.GA32296@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Sixt" <j.sixt@viscovery.net>, git@vger.kernel.org,
	"Lars Hjemli" <hjemli@gmail.com>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 07 08:14:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN0xb-0003Gv-Ck
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 08:14:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753430AbYBGHNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 02:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753438AbYBGHNl
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 02:13:41 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:52269 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752971AbYBGHNk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 02:13:40 -0500
Received: by wa-out-1112.google.com with SMTP id v27so928892wah.23
        for <git@vger.kernel.org>; Wed, 06 Feb 2008 23:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=b0laWu7cx1nSAMENPPJqEwAsWyzPLRTkoEQG/G2CO6A=;
        b=W0fo5qa0PTLk5fSXUphu1zHAWVFW8z/Zlyq6p/UJeAaRJVkhD1Zo/W8b9W42JOOTSoyaaJfcYIG04+MaBJlk2u229L1Grlcw6mY0lnhfhuGLa4jXaB/cVkfX0XcXOy9DcVgqTpyUKnO2r+TFAC1SxTgKKc9c0A55wedVK3MX6so=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=lRtM0VFRJM+jScu8cyQNJyW1XhS6w1Jp0kJuLYoRnU9V0FrLXb1DRlBSXugFhJDs6dccDM6R0VqdS1lv8gYV3gkQeD1cuNDXZVEMEOTlU+SCjAHYpiJ66Bp5hStrVd2WBF08KolgFty6DxIkvkcgsTE9Xz1CpVwu+KXz4hebFnA=
Received: by 10.114.121.1 with SMTP id t1mr5707213wac.67.1202368419979;
        Wed, 06 Feb 2008 23:13:39 -0800 (PST)
Received: by 10.114.255.11 with HTTP; Wed, 6 Feb 2008 23:13:39 -0800 (PST)
In-Reply-To: <20080207051317.GA32296@sigill.intra.peff.net>
Content-Disposition: inline
X-Google-Sender-Auth: 7bd07496278b392c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72901>

On Feb 7, 2008 12:13 AM, Jeff King <peff@peff.net> wrote:
>
> On Wed, Feb 06, 2008 at 12:59:32PM -0800, Junio C Hamano wrote:
> >
> > I was tempted to suggest GIT_WORK_TREE=/dev/null because that is
> > what "diff" uses to mark "this does not even exist", but that
> > feels dirty.
>
> It feels dirty to me, too. I would rather choose something that doesn't
> even look like a path. I think GIT_WORK_TREE=" " is too ugly, too.

Is using something like "__GIT_WORK_TREE_NOT_SET__" that terrible?

j.
