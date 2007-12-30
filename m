From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH WIP] sha1-lookup: make selection of 'middle' less aggressive
Date: Sun, 30 Dec 2007 23:04:19 +0100
Message-ID: <e5bfff550712301404g273dd092w9b36b48d94ed1e70@mail.gmail.com>
References: <7vd4soa3cw.fsf@gitster.siamese.dyndns.org>
	 <7vtzm08l9w.fsf@gitster.siamese.dyndns.org>
	 <alpine.LFD.1.00.0712301150120.32517@woody.linux-foundation.org>
	 <7vodc77t0o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 30 23:05:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J96HO-0005W3-0C
	for gcvg-git-2@gmane.org; Sun, 30 Dec 2007 23:05:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758070AbXL3WEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2007 17:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758061AbXL3WEV
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Dec 2007 17:04:21 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:48810 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757536AbXL3WEU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2007 17:04:20 -0500
Received: by rv-out-0910.google.com with SMTP id k20so4316233rvb.1
        for <git@vger.kernel.org>; Sun, 30 Dec 2007 14:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=XoKzV3osmUeaEUPXhyKT931dxjKuAULp7AbpQ7ZkFo8=;
        b=vU9QEoXjSDR2Bs73Ogp17wHzgVJnsOFClJnXqiOq04Ek1YHyNXFsDrdKjwyGUjyUdW2zBq3EF/Q2t/OlXwPBv/DNSvjjmUzcK8OdSyw3SACbcCeBFxpyRozHHs5D09du37JbW7b5cpm2DgXfasbPWgg0JZfJqDSORSdpHso3LPA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kIaEyG1n4Q9L7ouVjHolS/XXg/Ti571JWRk1vgu7yvi82wMd4Qg9sF0OWEHT39AGoKrQ35o9u9o3L2lZnwNmafFNZUQFu9maO7c5OW/u0nFtOrhPR+syM739gqznQ2avD/3/hrNL9vS3+Sa/nGJhblUummC+0IoNHB8mR2g/Bx8=
Received: by 10.140.173.15 with SMTP id v15mr6023255rve.218.1199052259778;
        Sun, 30 Dec 2007 14:04:19 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Sun, 30 Dec 2007 14:04:19 -0800 (PST)
In-Reply-To: <7vodc77t0o.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69381>

On Dec 30, 2007 10:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>
> The cost of the key comparison done in each round is
> insignificant compared to the actual cost of accessing the
> object data through zlib.

Sorry to ask, but just out of curiosity, what were the reasons to
choose zlib compression algorithm among the possible ones?

There is a thread where this has been discussed in the past? Sorry to
ask but I didn't find such a thread myself.

Thanks
Marco
