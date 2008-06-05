From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT PATCH 5/5] Add stack creation and deletion support to the new infrastructure
Date: Thu, 5 Jun 2008 10:43:40 +0100
Message-ID: <b0943d9e0806050243j141a5998j4800f633ba471927@mail.gmail.com>
References: <20080604210655.32531.82580.stgit@localhost.localdomain>
	 <20080604211352.32531.10821.stgit@localhost.localdomain>
	 <20080605073429.GE23209@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 11:45:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4C1d-0005Gp-BG
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 11:44:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755905AbYFEJnp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jun 2008 05:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754629AbYFEJnp
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 05:43:45 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:60799 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753994AbYFEJnn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jun 2008 05:43:43 -0400
Received: by rv-out-0506.google.com with SMTP id l9so623981rvb.1
        for <git@vger.kernel.org>; Thu, 05 Jun 2008 02:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Li820L9LcVTSkv/HdeVmu3cCFeH/BS/veUhwNE1+1qI=;
        b=Xj/Xlu/C7MnQvmQPiJQiOKyCwc33uw/s8LPo4Ap0mmQ2+exhDyC0rkwOcxounlC9Nr
         KZPU1Fliy18MsrT1bWcvdd4rZ8zR89UvTKdvrxxmvZtdy/V2pPULaIQqkso+SQKZJl7D
         aInjP5zX/fBN5Ejlh9herE0trd/N/tc6EQLrc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=kSnMvvrKmxK/PUOVnUbHJMOjxRb9i1oQYv9eUX92Ok+OH1vjAHCMyIlj2NzVVscs+5
         HruLFRpbm90x0ys8UCuDpGnlov/zX6/CAX4/ycYc2uysZfBUHvEdhRcWvaVXqMlbw5l9
         SW5GdTKDfX2e5QxZTJ/UaRFYXHcTmH+z7pOks=
Received: by 10.114.166.1 with SMTP id o1mr1229069wae.119.1212659020984;
        Thu, 05 Jun 2008 02:43:40 -0700 (PDT)
Received: by 10.114.171.16 with HTTP; Thu, 5 Jun 2008 02:43:40 -0700 (PDT)
In-Reply-To: <20080605073429.GE23209@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83891>

2008/6/5 Karl Hasselstr=F6m <kha@treskal.com>:
> The commit message is misleading. What this patch does is make "stg
> init" _use_ the new-infrastructure stack init support added in your
> previous patches.

Yes, it's misleading. I had a big patch containing the previous 3-4
patches and split it afterwards. This being the last one, I forgot to
change the commit message.

> On 2008-06-04 22:13:52 +0100, Catalin Marinas wrote:
>> -    crt_series.init()
>> +    stack.Stack.initialise(directory.repository)
>
> This would need minor tweaking if you decide to take my advice for
> 4/5.

I'll reply to 4/5 separately.

--=20
Catalin
