From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: RFC: git pull or git rebase?
Date: Mon, 23 Jul 2007 11:07:44 +0200
Message-ID: <81b0412b0707230207k2fa33eb3hdc23319d1f8dbd80@mail.gmail.com>
References: <20070723052223.GA20614@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Mon Jul 23 11:08:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICttV-0003wN-Uo
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 11:07:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755363AbXGWJHr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 05:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755216AbXGWJHr
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 05:07:47 -0400
Received: from ik-out-1112.google.com ([66.249.90.179]:9822 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754749AbXGWJHq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 05:07:46 -0400
Received: by ik-out-1112.google.com with SMTP id b32so1070247ika
        for <git@vger.kernel.org>; Mon, 23 Jul 2007 02:07:44 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PrUOsr9zZo5LpKFZtAbJp0RtBrynFQndaK2lW3rTKN8X0DseGVbXwVdtsH76fuFyLC+/fK2snf1vqLui+TL9AfNrxFEG7yBiepS66PbmEv6dvjlxFj9Dsmq4xbFQYu467d7IZ0y5x5tzmPdac5B3QPDicbngVfdjGaDW6chqgPg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bZ2CenFP3gpcY+KRHI7z91Q1Zz2yv8XR4mAV+Hq+c04NKSqdptsL41qKSThQL+CbBDKOiwqI1xdUqOHZRcp/B3/5JFOnRky2AALCfQ59QRtzu582RJ0IMuZb+wCKK8ARHwsn5HzhfOSeIN0HPe9sNQTp+jdowaGURCTYHUVFFq4=
Received: by 10.78.201.10 with SMTP id y10mr717699huf.1185181664483;
        Mon, 23 Jul 2007 02:07:44 -0700 (PDT)
Received: by 10.78.118.19 with HTTP; Mon, 23 Jul 2007 02:07:44 -0700 (PDT)
In-Reply-To: <20070723052223.GA20614@mellanox.co.il>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53416>

On 7/23/07, Michael S. Tsirkin <mst@dev.mellanox.co.il> wrote:
> However, I wonder whether this happens to others, too.
> Would it make sense to add a branch attribute that says
> "do not pull this branch" or "do not rebase this branch"?
> Maybe even make git do the right thing automatically,
> so that git would look at this attribute and perform
> pull or rebase as appropriate?

If you have a recent enough git, it will refuse to pull into
a branch for which there is no configured remote branch.
Exactly for a reason like yours.
