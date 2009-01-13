From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Re: the meaning of keephardlinks
Date: Tue, 13 Jan 2009 14:00:07 +1030
Message-ID: <93c3eada0901121930n16dd2e83v452c38fd30da5054@mail.gmail.com>
References: <93c3eada0901121617m43af82a7te946b1607fbf3f77@mail.gmail.com>
	 <alpine.DEB.1.00.0901130141190.3586@pacific.mpi-cbg.de>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 13 04:31:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMa06-0001Br-9e
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 04:31:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753518AbZAMDaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 22:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752643AbZAMDaJ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 22:30:09 -0500
Received: from rv-out-0506.google.com ([209.85.198.228]:41821 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752593AbZAMDaI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 22:30:08 -0500
Received: by rv-out-0506.google.com with SMTP id k40so10533267rvb.1
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 19:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=SmeGsvFoiTre8Vq9WiEquKhg4ntl69t/PnlrvDBa/vM=;
        b=DUVKPjtrA5Oke8RYrH/ktq/yqWxZKUL8ytSHm3SkZXge6VboXAW4zDl20Z7U6U9HuN
         hPcmMfl9nxRTlZBbz11bQwyhLeWbYzx4kR9h84lQUcvXHaotD42VMRN/SwqUPSlb4m/K
         ecjzlFu7mmOlolARdn/tn8RNgsvjHyYGHEmEo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=PMTuMUvJ0soRemNn25P8IcBu/RdIfkYgPStstmPHEs6fYgkt6Pj0ES5jH1mZax7euk
         MgVZXCOhLpXdhYO60wB4sTJfTrAYU2FVXdCQc4PxAZXpzYq5wwq9aFK9Yttsi+lhcC92
         1t+Es6+Gqmow6dHAmIrHo/6hlTXKC4udt2Smg=
Received: by 10.140.139.6 with SMTP id m6mr15026505rvd.242.1231817407496;
        Mon, 12 Jan 2009 19:30:07 -0800 (PST)
Received: by 10.140.136.16 with HTTP; Mon, 12 Jan 2009 19:30:07 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901130141190.3586@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105449>

On 1/13/09, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
>
>  On Tue, 13 Jan 2009, Geoff Russell wrote:
>
>  > I'm curious about what keephardlinks means.
>  >
>  > If I do: "ln X Y ; git add Y ; git commit" in my origin and then
>  > "git pull" in my cloned repository,
>  > should I get a hard linked file in the clone
>  > when core.keephardlinks is set to true?
>
>
> Nope.
>
>  It means that if you have a hard link locally, it will stay a hard link
>  (and if it is modified, the other linked files will obviously change,
>  too).
>
>  Note that this feature is not even in 'next'.
>
>  Ciao,
>  Dscho


Fine. Thanks,

Geoff.
