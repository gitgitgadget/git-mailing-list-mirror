From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 3/9] cherry-pick: add --skip-empty option
Date: Thu, 6 Jun 2013 13:34:55 -0500
Message-ID: <CAMP44s3b2K0nbfuhNqB6FNevdPjVByQCpAie5nzAjx8bw5Y+RQ@mail.gmail.com>
References: <1370509144-31974-1-git-send-email-felipe.contreras@gmail.com>
	<1370509144-31974-4-git-send-email-felipe.contreras@gmail.com>
	<7vbo7jytv5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 06 20:35:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukf1Z-0000iI-KP
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 20:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700Ab3FFSe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 14:34:57 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:42247 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129Ab3FFSe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 14:34:56 -0400
Received: by mail-lb0-f181.google.com with SMTP id w10so705189lbi.12
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 11:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OO9vKtUAIeXP3bnx3Ipq+AUZpUuxk0WSCJufTi92tWI=;
        b=nIcJ3P0VmqgCqO3Wj/uJUMlCubECP5CIPFpiyfPquaZaU/4BETG6TR59ckKG3bjWL8
         N5K2hKC8VKPjcEdc5eBGTah2iw62h5w6JjfgSflk6IeyLiEGhWv4xTyU/1OtQCJv8pb1
         KVv1BzO0006Arsccps71nPNFZ/YgUIY8mpxZqBvcTOkUptfMaHJLAPKZCBh/c4jj/rqT
         iQc4IZUKMP1huMoxiPgvL2DiQ8DMDaYOtzV0YMVZzAZzrv2EKAl351xCwCYHXPtCKH8X
         PowOnoWBfYD7KXFNEsz+9Y89l3I4mAOUPpJ4LxPHMPHFy2nf3QeC8G59L3UAo1uoJwBk
         mj8A==
X-Received: by 10.112.16.163 with SMTP id h3mr442918lbd.85.1370543695495; Thu,
 06 Jun 2013 11:34:55 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Thu, 6 Jun 2013 11:34:55 -0700 (PDT)
In-Reply-To: <7vbo7jytv5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226526>

On Thu, Jun 6, 2013 at 1:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Pretty much what it says on the tin.
>
> And a bit more, isn't it?
>
> The --keep-redundant-commits option implies the --allow-empty option
> and it was perfectly acceptable to give both.  By making sure that
> only at most one of -k-r-d, -a-e or -s-e is given, this forbids that
> usage.
>
> "It is implied so there is no *need* to give it redundantly" is
> different from "It is implied so you shouldn't give it redundantly".

Remove that line then.

> Like 7 and 8 that adds --quiet/--skip, don't we want this also for
> revert?

If we don't want --allow-empty in revert, we don't want --skip-empty
either. That is a separate patch.

-- 
Felipe Contreras
