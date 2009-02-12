From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 2/3] builtin-remote: teach show to display remote HEAD
Date: Wed, 11 Feb 2009 20:48:42 -0500
Message-ID: <76718490902111748j58f80591ma149f8ec9fb8b352@mail.gmail.com>
References: <1234332083-45147-1-git-send-email-jaysoffian@gmail.com>
	 <1234332083-45147-2-git-send-email-jaysoffian@gmail.com>
	 <1234332083-45147-3-git-send-email-jaysoffian@gmail.com>
	 <20090212002612.GC30231@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 12 02:50:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXQiR-0007me-CV
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 02:50:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756639AbZBLBso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 20:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756562AbZBLBso
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 20:48:44 -0500
Received: from rv-out-0506.google.com ([209.85.198.225]:49357 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756561AbZBLBsn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 20:48:43 -0500
Received: by rv-out-0506.google.com with SMTP id g37so134377rvb.1
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 17:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=L1yzSRGXppNaxPTe4PI7fZesl+sQmBo9WxjvlTtwERg=;
        b=GeQ41JuBl6sCWvQq2FAt56s313SLRnKIMZJVrE6PNYCy/8I15y0pMbLlz6QixT4Ldi
         dMgboWFrEUdB7yn64cyxDon9swuASbM2vM4Zd1xn3oGNSoJ7KeZ+yaHahuL1lyQ8DEC1
         8wjkIKYNXvwmpX9Lt2wjBfaAK4OtpSyxdSxpM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=w011eH5OJ+9+8UcsDUrMhIq6IxaUhKA06fd96aOMnwpL6JNzQb+WT/guuPKdpXQXKy
         vf04D7YvSev7cC2rVm4fULY4brkmv7bbSyssV5/9l9Bz6k6I/ss8KgHv2jqaC5OUrAV4
         dtlmNiDQ4lEk0KSaZK6RKhpAFFj9HVP/WLtrQ=
Received: by 10.141.161.6 with SMTP id n6mr196503rvo.31.1234403322509; Wed, 11 
	Feb 2009 17:48:42 -0800 (PST)
In-Reply-To: <20090212002612.GC30231@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109556>

On Wed, Feb 11, 2009 at 7:26 PM, Jeff King <peff@peff.net> wrote:

> Yuck.

Damn, I knew I wasn't going to slip that one by. :-)

> I see that the inputs and outputs aren't exactly the same in both cases,

Which is why I didn't refactor it. The extra code needed to massage
what builtin-remote.c has to the existing function in builtin-clone.c
would've been more LOC than the duplicate code (I think...).

BUT

I'll try. :-)

j.
