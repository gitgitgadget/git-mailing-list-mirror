From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [Patch] Prevent cloning over http from spewing
Date: Mon, 20 Jul 2009 23:24:04 +0800
Message-ID: <be6fef0d0907200824r68402229vac88e46a8e70603a@mail.gmail.com>
References: <m3vdnda9f7.fsf@localhost.localdomain>
	 <20090603191555.GL3355@spearce.org>
	 <be6fef0d0906040545j7bd754e0j2c60af833e2ac4a4@mail.gmail.com>
	 <20090604160152.GA13984@sigill.intra.peff.net>
	 <be6fef0d0906070331y5fd596d1k67893a96a4d872ac@mail.gmail.com>
	 <be6fef0d0906070421j7913b0d7w6f7bb97aa7fd6814@mail.gmail.com>
	 <20090608122430.GD13775@coredump.intra.peff.net>
	 <be6fef0d0906100703j57d109d5mb38e41330caa089b@mail.gmail.com>
	 <20090611111141.GB4409@coredump.intra.peff.net>
	 <be6fef0d0906220510r416d66aaoc2171bdcc61ec3a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, sparse@infidigm.net,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 20 17:24:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSuis-0001eI-25
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 17:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262AbZGTPYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 11:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751765AbZGTPYH
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 11:24:07 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:55220 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082AbZGTPYE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 11:24:04 -0400
Received: by wf-out-1314.google.com with SMTP id 26so742597wfd.4
        for <git@vger.kernel.org>; Mon, 20 Jul 2009 08:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3GPGaO/ruk7SUwemTLdQw6AXZJM6fXW0H/fLz5XhGsI=;
        b=QUs06s2UiPr6KD+D+fqo80PECYXFn0y1GIAdxws2JKBBdkK4TMQiTQCf20k8nbivIF
         N1/k3R5fSoPrNhZnqYN32nANd9t+LInLUcseuvzVLuVrmI0LYBeG0U+vjSmhbd681y2b
         g4zHjdJ2z6sAw7NGfpUbkjqRf5AUxB6wX7tW8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tD4SFdDTjw9VI2yYr+bCFYN9lzdo8X/3PFg2Zohqc9G5oWbJhuc+Ru5ZT+ZXXOGZhP
         8fqTeNEd0OIXgnQwU/R6ozaSgGm8yphO5Ow+rAQcNBhxIIosnc5r0xPR6dcAesXNLwr0
         V3KHCym5HjL/EpkFmxoIkMjDSOrHKGRuTbQ/0=
Received: by 10.142.173.6 with SMTP id v6mr1366041wfe.40.1248103444998; Mon, 
	20 Jul 2009 08:24:04 -0700 (PDT)
In-Reply-To: <be6fef0d0906220510r416d66aaoc2171bdcc61ec3a4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123612>

Hi,

On Mon, Jun 22, 2009 at 8:10 PM, Tay Ray Chuan<rctay89@gmail.com> wrote:
> note: this time, I haven't anything to show for in my repo; sorry.

I've got some stuff, as per the last email, at my git repo (branch
'http-progress-indicators' at git://github.com/rctay/git.git).

-- 
Cheers,
Ray Chuan
