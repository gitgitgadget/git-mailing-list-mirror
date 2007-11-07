From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 0/5] some shell portability fixes
Date: Wed, 7 Nov 2007 22:58:50 +0700
Message-ID: <fcaeb9bf0711070758w5832ab83ic16e8fb4edb80972@mail.gmail.com>
References: <20071106201518.GA6361@ins.uni-bonn.de>
	 <7v8x5bgl04.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Ralf Wildenhues" <Ralf.Wildenhues@gmx.de>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 07 17:00:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpnJM-0006yD-UK
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 16:59:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753966AbXKGP6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 10:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753831AbXKGP6x
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 10:58:53 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:44196 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753608AbXKGP6w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 10:58:52 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2050983nfb
        for <git@vger.kernel.org>; Wed, 07 Nov 2007 07:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=zb76afmIJQCy2f5MSvRfCAeWjfAvuFt4duNHHLZkJKw=;
        b=nhZHi/YU0LW1Xz1PzKkwQvTrSKwB13j4bp4zksB6G/ourUUvy3LUd5CFHYwVB1vCBhvvb4sIpgkSMn4qPsbDnxc6Ngo+tM8R0nJLnUEgPjNepBBn3weBZgoJQz3r0289KDH9bKgPB7E8/hqp8BtZDawlUttMfCVqdzqF6CVz2tI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j8lx1snR7ND9uyv4ufdRPJhfbmbJOnKa+sdIRuV3PWwHmFXh9tKbcU0MSXmM0HpE/MHP6Yby6+ZMR67EXNJlx/ieGjoZIhGs/WVEcEhHV+yUTSB5NQQHrdXaBsd+9HiqJi5ZRH2ap95wA1+Q3Ay4qBkrafLJQs9kCLT5qsbXq3A=
Received: by 10.86.90.2 with SMTP id n2mr909353fgb.1194451131029;
        Wed, 07 Nov 2007 07:58:51 -0800 (PST)
Received: by 10.86.66.20 with HTTP; Wed, 7 Nov 2007 07:58:50 -0800 (PST)
In-Reply-To: <7v8x5bgl04.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63830>

On 11/7/07, Junio C Hamano <gitster@pobox.com> wrote:
> [2/5] Gaah, AIX sed X-<.  I am not opposed to this patch but
>       would want to get Yays from people with non GNU sed.  Is
>       busybox sed good enough to grok our scripts these days?
>       Please ask help and collect Acks at least from folks on
>       Solaris, MacOS, FBSD, and OBSD.

I haven't extensively used all the scripts. There seems to be no
sed-related failure from git testsuite results in my git-box branch.
So I would say for now it's good enough.
-- 
Duy
