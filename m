From: Benjamin Kramer <benny.kra@googlemail.com>
Subject: Re: [PATCH] Makefile: Use libc strlcpy on OSX
Date: Sat, 24 Jan 2009 19:51:53 +0100
Message-ID: <7f978c810901241051m752a0b97s8ce76c3d2ece0695@mail.gmail.com>
References: <7f978c810901240741k201f954dx1c0470186094ae24@mail.gmail.com>
	 <7vfxj8o8fq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 19:53:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQndA-0006Hv-H7
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 19:53:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755060AbZAXSv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 13:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754945AbZAXSv4
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 13:51:56 -0500
Received: from mu-out-0910.google.com ([209.85.134.188]:14073 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754769AbZAXSvz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 13:51:55 -0500
Received: by mu-out-0910.google.com with SMTP id g7so3370872muf.1
        for <git@vger.kernel.org>; Sat, 24 Jan 2009 10:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FD+6yzHy9U3e5IRGXrozQGfkpHiVfL/uRRPYn8kvV6s=;
        b=o73jIi/MPVD61AL0QE/FLgVC6W+mG221ZDvahC7WfK9LneD078//aYP4QCaP1zTt6g
         fWe1rEBGFKPLoFO1S/ndjln6euMJAEDIrbQveXP9oGFPt0wByiRsA4oNQgZVcBWSqVgs
         BRQvMzOKTxjc8zZAu4dUARqZ7LndKroxz+bVo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ayQKsuAS3fzqPBqxkM8S3JMbQsA2IQwn9SPMvZBDed26gFeH9Q8IUObIAdXSdRH2Xh
         5chCITxzxV8OyNfoyfNB8udwWE0gEVDRjM9Xia5zYR5UBjwzyKMmLR0l00WBCykz/CZP
         BUrdLwBxEsyjkkDDYYilc1FNIdEmxMbXsVqyc=
Received: by 10.103.11.7 with SMTP id o7mr1119156mui.103.1232823113750; Sat, 
	24 Jan 2009 10:51:53 -0800 (PST)
In-Reply-To: <7vfxj8o8fq.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106989>

On Sat, Jan 24, 2009 at 19:39, Junio C Hamano <gitster@pobox.com> wrote:
> How does your patch to Makefile refrain from kicking in for people with
> OSX older than 10.2, so that their builds are not broken?

I'm not even sure anyone uses <= 10.1 nowadays. But of course you're right,
I'll write a better patch.

-- Benjamin
