From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 1/3] for-each-ref: utilize core.warnambiguousrefs for strict refname:short format
Date: Sat, 18 Oct 2008 08:55:30 +0200
Message-ID: <36ca99e90810172355n2c578b07pd2868b15e6631ef7@mail.gmail.com>
References: <1222074591-26548-1-git-send-email-bert.wesarg@googlemail.com>
	 <7vod1ieptr.fsf@gitster.siamese.dyndns.org>
	 <20081018015010.GA14786@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	szeder@ira.uka.de
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Oct 18 08:56:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kr5jz-0007Te-0I
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 08:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbYJRGzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 02:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbYJRGzc
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 02:55:32 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:62826 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbYJRGzc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 02:55:32 -0400
Received: by gxk9 with SMTP id 9so2037351gxk.13
        for <git@vger.kernel.org>; Fri, 17 Oct 2008 23:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=96bSSIfLlZ+zy9dyejjdI7l4IpET45TdWljUI+gFlMc=;
        b=YiDt/YvrPOQFNDQQ9k6cAVZOzhaT69oDhUf/JahHGJK530YBLAFY4mLWRe/Qd+qST5
         gPW/5/PeRvmhkltytmj8d4uw1yHrqS0CVwz0RTZAjL5LisHPkyljU4895JZr/Jy9SF6e
         3dEWSy/a1w2LndWHeLmWMCaaMY94t1BU1jhHI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=g8cRgNmpODfn5djvLPcdAyzQ0vKWB+789vtCgNd0mDRCY6XmF10te4p2D/fHr8i2NE
         KhRU3ELMMWnOhgadjmyowQvLmOwVvUgcgPayF6UXJAYpYsfgmxuL8hcUP1IEf4OS6ilu
         o898QiYFMzsrsZ2Zwv/ozpLaIyzpR0oZxkI2E=
Received: by 10.151.112.3 with SMTP id p3mr7469447ybm.116.1224312930887;
        Fri, 17 Oct 2008 23:55:30 -0700 (PDT)
Received: by 10.150.204.17 with HTTP; Fri, 17 Oct 2008 23:55:30 -0700 (PDT)
In-Reply-To: <20081018015010.GA14786@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98526>

On Sat, Oct 18, 2008 at 03:50, Shawn O. Pearce <spearce@spearce.org> wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
>> Shawn, was there any issue with this one?  The patch changes the function
>> signature for no good reason (at least, it does not have anything to do
>> with the stated purpose of the change), but other than that, I think what
>> it attempts to do makes sense.
>
> No, aside from the signature issue I think its reasonable.
Ok, I will post a new single patch, that does only this.

Bert
>
> --
> Shawn.
>
