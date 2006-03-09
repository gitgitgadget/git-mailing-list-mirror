From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Allow git-repack to optionally run git-prune-packed.
Date: Thu, 9 Mar 2006 15:48:28 +0100
Message-ID: <81b0412b0603090648w4a3e4e4bwceb0ad19a2a4d15f@mail.gmail.com>
References: <11417445722524-git-send-email-matlads@dsmagic.com>
	 <20060307212918.GA9474@steel.home>
	 <20060309102419.GA9961@igloo.ds.co.ug>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Mar 09 15:49:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHMRN-0007Sl-7W
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 15:48:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbWCIOsa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 09:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWCIOsa
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 09:48:30 -0500
Received: from nproxy.gmail.com ([64.233.182.194]:65481 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751077AbWCIOsa convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Mar 2006 09:48:30 -0500
Received: by nproxy.gmail.com with SMTP id a27so337304nfc
        for <git@vger.kernel.org>; Thu, 09 Mar 2006 06:48:28 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qr52e37mmkbkAPGec5H/cFNHQ99eqU0QZthwntV86YNZgF692F3liEXtLLSAh/me0dI/qJKEcwdUAJ4XGpzPasLFNjoFcWMubvukWu1m0Jg0ZYddhUdEFwCLNRteRIG4f+UnpV8VTGUjqqgtdL4Uoab70D0joDcYwF8AsKBCHUA=
Received: by 10.49.56.20 with SMTP id i20mr885657nfk;
        Thu, 09 Mar 2006 06:48:28 -0800 (PST)
Received: by 10.49.88.16 with HTTP; Thu, 9 Mar 2006 06:48:28 -0800 (PST)
To: "Alex Riesen" <raa.lkml@gmail.com>, git@vger.kernel.org
In-Reply-To: <20060309102419.GA9961@igloo.ds.co.ug>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17417>

On 3/9/06, Martin Atukunda <matlads@dsmagic.com> wrote:
> Your suggestion has merit, though it's different from the behaviour I
> desired. I _sometimes_ need the pruning, and it felt appropriate to make
> it an option as opposed to default behaviour.
>
> What do you think?
>

I think that my patch didn't change the default. git-prune-packed is called
only if -d is given, which is not the default.
