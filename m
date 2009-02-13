From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] send-email: handle multiple Cc addresses when reading 
	mbox message
Date: Fri, 13 Feb 2009 18:44:00 -0500
Message-ID: <76718490902131544kd4c2d83w64c062d8705ef61d@mail.gmail.com>
References: <1234566313-36478-1-git-send-email-jaysoffian@gmail.com>
	 <200902140032.19922.trast@student.ethz.ch>
	 <76718490902131539o15439f12l7d4a8113f482c6ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ryan Anderson <ryan@michonline.com>,
	gitster@pobox.com
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Feb 14 00:45:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY7iv-0006U5-By
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 00:45:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753254AbZBMXoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 18:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753005AbZBMXoE
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 18:44:04 -0500
Received: from rv-out-0506.google.com ([209.85.198.226]:43176 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752746AbZBMXoC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 18:44:02 -0500
Received: by rv-out-0506.google.com with SMTP id g37so856670rvb.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 15:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4yQf+MKiQil3uGnkE2RlOzdRu9+FpTWskKdcE9Kn5mE=;
        b=donR/ZVD1eGe8ZjIYVynBJiTVq13dEB6iwCM1xB++UkzESbGbZgu6LMLDBb1JzEGHn
         pzPdZYAnYP82VKTLGTSxE0JYV37m4zzb8kiFXaSv9K850UENsPdDL5/xzJ+Tj/VZf+RI
         XobCoRUqR/pRatSVmcyLobFukjWace+TJh7rw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sO/U0tv7ETYQcVrY+PoiTg841Ryr8Lql3Ktr1Ri8dvT5gEMsuwtuOMVzuMJnl6qSQH
         wLX2wduUU6Q7Krx0FSO9kvt+nrtUEClDZ4zTvnWzHZbxsk632iMIVcd3sfu9npHfiqzt
         oOSKYHCSOTCwPTgpKZ9Pwqvhep4VQ/8aESPtg=
Received: by 10.140.187.14 with SMTP id k14mr1373671rvf.246.1234568640675; 
	Fri, 13 Feb 2009 15:44:00 -0800 (PST)
In-Reply-To: <76718490902131539o15439f12l7d4a8113f482c6ee@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109787>

On Fri, Feb 13, 2009 at 6:39 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> I think it would be nice if send-email had different settings for
> extracting Cc lines and extracting SOB lines from the message body,
> but I don't call that a bug, but rather an enhancement request.

Oh, I see it does now that I looked at that commit. Hmphf. I'll fix
that on-top of the patch I just sent.

j.
