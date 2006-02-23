From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: PATCH: simplify calls to git programs in git-fmt-merge-msg
Date: Thu, 23 Feb 2006 13:40:59 +0100
Message-ID: <81b0412b0602230440j24ab1ecfwf35921236b905f2b@mail.gmail.com>
References: <81b0412b0602230226j12e88682h303d466a273bec09@mail.gmail.com>
	 <Pine.LNX.4.63.0602231335420.3726@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 23 13:41:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCFmP-0001Dv-0X
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 13:41:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWBWMlB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 07:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWBWMlB
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 07:41:01 -0500
Received: from nproxy.gmail.com ([64.233.182.194]:6130 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751143AbWBWMlB convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2006 07:41:01 -0500
Received: by nproxy.gmail.com with SMTP id c31so27072nfb
        for <git@vger.kernel.org>; Thu, 23 Feb 2006 04:40:59 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aD4NqVjP1AjY10p7Egyi9xUNaKD5T8P7uLVMcmqOszrGB0os1fIOWUQLWs/ccLU+wMYxtEEM9qRSum4CcXgMRVz4rV77S3HVpay3C8LhQC6jdLlsMIbdJVNj4kNh6gSmtlw6BJuc/bFQZBWh97UARM/TEsei5aNRVrq3WGQa5Z0=
Received: by 10.49.33.14 with SMTP id l14mr2334151nfj;
        Thu, 23 Feb 2006 04:40:59 -0800 (PST)
Received: by 10.49.88.16 with HTTP; Thu, 23 Feb 2006 04:40:59 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0602231335420.3726@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16644>

On 2/23/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > It also makes it work on ActiveState Perl.
>
> Thank you for teaching me this very valuable construct: qx{ ... }.

You're welcome. That's the same as shells old `` (backquote).
