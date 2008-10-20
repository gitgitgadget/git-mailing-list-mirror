From: "Leo Razoumov" <slonik.az@gmail.com>
Subject: Re: [PATCH] git-fetch should not strip off ".git" extension
Date: Mon, 20 Oct 2008 11:08:49 -0400
Message-ID: <ee2a733e0810200808y657fe3d7y3158bfc00aa5e82a@mail.gmail.com>
References: <ee2a733e0810180459m5fd20365s3c27bea5c1f3f704@mail.gmail.com>
	 <48FC5F1B.1050608@op5.se>
Reply-To: SLONIK.AZ@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Oct 20 18:27:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrwOU-0007YG-GC
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 17:10:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbYJTPIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 11:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbYJTPIx
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 11:08:53 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:34431 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbYJTPIx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 11:08:53 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1429461fgg.17
        for <git@vger.kernel.org>; Mon, 20 Oct 2008 08:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=qBoCDhx1aROpA4GJoCHKs5pVO6Sy7vvSA1DESBit5uE=;
        b=akCWnjFdxWlusCbBxAj3P6wzYu//EeZgCwmq1RtJd7eWYA8cQF70kVSl1Zt3YtL+6W
         M/bHSRqYiotmid7GvzRw+vCTmFTCEOuVrNNq88cCMNvUmBIGWE4S4DgRFHcJD3bGxIyq
         zDA1ZQqE7vXC3W0/60dZUsYXsQxj3852t/ZJE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=xK5TQATZo+JScht+mH+n4KA5xGG0I15oA8+2vREcyKs4urgw7aP5tMTw6Qmo9+bELQ
         eX+4VcNPobUZmCUf65i7NZhffmTzf0rmEohUugeGm/nDBSAnAfpvnk4/6XnU/YkmpY63
         DOjy9fWmxjBEHrlr/GiZrNP9PAZxgFbaij/aM=
Received: by 10.187.251.11 with SMTP id d11mr1145971fas.104.1224515329194;
        Mon, 20 Oct 2008 08:08:49 -0700 (PDT)
Received: by 10.187.193.16 with HTTP; Mon, 20 Oct 2008 08:08:49 -0700 (PDT)
In-Reply-To: <48FC5F1B.1050608@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98677>

On 10/20/08, Andreas Ericsson <ae@op5.se> wrote:
> [..snip..]]
>  Will this still play nicely with
>
>   git clone foo.git
>
>  ?
>
>  Otherwise, please also fix the fallout from this patch.
>
>  --

Andreas,
thanks for the comment. I have been testing this patch for over two
weeks already and so far encountered no problems. I routinely perform
"git clone foo.git" and it works correctly creating new repo "foo" and
properly populating it.

--Leo--
