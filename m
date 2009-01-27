From: Tim Visher <tim.visher@gmail.com>
Subject: Re: Building Documentation in Cygwin
Date: Tue, 27 Jan 2009 14:27:21 -0500
Message-ID: <c115fd3c0901271127q2a7f0f58i59ff446060982fd7@mail.gmail.com>
References: <c115fd3c0901270741h2f213b99s31bac8829bd182c2@mail.gmail.com>
	 <be6fef0d0901270832o1a176691nab5500a86c531795@mail.gmail.com>
	 <c115fd3c0901270944p7a4b6cc5n5dfe9b2f268f038c@mail.gmail.com>
	 <c115fd3c0901271027s61a33273lfe9dd702a66aac6@mail.gmail.com>
	 <7vskn4y4zt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 20:28:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRtcC-0006DR-HJ
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 20:28:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755809AbZA0T1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 14:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755698AbZA0T1Z
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 14:27:25 -0500
Received: from mu-out-0910.google.com ([209.85.134.191]:21603 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755204AbZA0T1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 14:27:24 -0500
Received: by mu-out-0910.google.com with SMTP id g7so4635176muf.1
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 11:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qrpH+BAdwdBmVB/4ZBwVirTIXcYxjL/6XDzxCAfjTBw=;
        b=TjzEq2ottPZkYd3WmoE16ngr9Vova/KfRV4Ng7ZkjZ6Osn8YiGewwhLFVhJTfSMB7i
         dyg11xa9Db6RqJ3HVWr4De9VNNWz4Moh34oZELESXgc5Kvs/NfTuDhoOAW7yDdc8pbma
         8F6gj/1gJUIp9piQFbZi+cMNjTxnTsbAujVFs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ahZEDyIYkYH/8KpSq1BWyidiKwn/eIB6CHqG4FlR/8enp31SSiQt55EoNU0KHkRkPH
         r4RnD2/XN+NKY35a72yU0CJJOU29S1YYkI8TqUdS0a+yYePfsHeTzr3BD/DXISwgMHvR
         Cxr3FP/vyPUHCUB0/EfKC6YEyZh6eyMaldCpQ=
Received: by 10.181.146.14 with SMTP id y14mr1243771bkn.70.1233084441725; Tue, 
	27 Jan 2009 11:27:21 -0800 (PST)
In-Reply-To: <7vskn4y4zt.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107385>

On Tue, Jan 27, 2009 at 1:32 PM, Junio C Hamano <gitster@pobox.com> wrote:

> The xml toolchain has a tendency to download dtds from the original source
> with a way for you (typically your distribution) to tell it to use a
> locally installed version.  "Can build online, fail when offline" is a
> sign that it is not using the local copy.

Sounds like we're on the same page.  I'm not familiar enough with any
of these tools to know how to do anything about that.  Does anyone
know how to explicitly inform xmlto to use a local DTD?  I have it
installed, as far as I know, via cygwin (the docbook-xml42 package)
but I don't know how to tell xmlto about it.

Thanks in advance!

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
