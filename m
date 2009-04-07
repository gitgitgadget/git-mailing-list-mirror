From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] for-each-ref: remove multiple xstrdup() in 
	get_short_ref()
Date: Tue, 7 Apr 2009 09:44:47 +0200
Message-ID: <36ca99e90904070044p48a4fe7bwb7278bde2d64837c@mail.gmail.com>
References: <20090407070254.GA2870@coredump.intra.peff.net>
	 <1239089599-24760-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 07 09:46:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr619-00040E-PJ
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 09:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754143AbZDGHow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 03:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754136AbZDGHov
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 03:44:51 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:61185 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754200AbZDGHou (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 03:44:50 -0400
Received: by bwz17 with SMTP id 17so2177736bwz.37
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 00:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MlRl54smIottzt3nzUMRv4b60ufEA+RRLPz4y5pJdBE=;
        b=HYgZifvf6TUDtzstkyD2n+++DEqaiVzazBtTOL25SloicN1aavAIdR6ypovAah6lxg
         SzBB6Fm8b8qAZ/RobXegT/Abcu/S3Wv/kiSpM5YrqxX6+krRULLp1RekbZ1hIUZ0rWHH
         7enbkz7kf5s7yS2znT1A2RHL2Kj7F/i50aCZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nL/3Ly0worGAVLa9Df3TJg0c27TTVF/i5Il4PEIi4tS9BWDzC0JVpuRyNnPvdwXJ1H
         d6PXF3UoiZwYXwYG319uxQZviPzKTTDN2UkVSnM7FV+uN3Q2/JCEKnOW5xvSZzO1WxKQ
         BjlNwq7MmCamw8kcFFYBEy3M0eWOP8SCjtRgA=
Received: by 10.204.117.141 with SMTP id r13mr2456920bkq.207.1239090287594; 
	Tue, 07 Apr 2009 00:44:47 -0700 (PDT)
In-Reply-To: <1239089599-24760-1-git-send-email-bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115922>

On Tue, Apr 7, 2009 at 09:33, Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> Now that get_short_ref() always return an malloced string, consolidate to
> one xstrcpy() call.
>
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>
> ---
> Also an
>
> Acked-by: Bert Wesarg <bert.wesarg@googlemail.com>
Sorry, wrong Message-ID for In-Reply-To, this Ack is for:

[PATCH 1/5] for-each-ref: refactor get_short_ref function

with Message-ID <20090407070501.GA2924@coredump.intra.peff.net>

Bert
