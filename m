From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: [PATCH] "git shell" won't work, need "git-shell"
Date: Mon, 25 Aug 2008 21:53:06 +0400
Message-ID: <37fcd2780808251053j5e8ced77ye633e05837cccd6@mail.gmail.com>
References: <20080824202325.GA14930@eagain.net>
	 <7vfxoukv56.fsf@gitster.siamese.dyndns.org>
	 <20080824203825.GB14930@eagain.net>
	 <7vbpzikt4b.fsf@gitster.siamese.dyndns.org>
	 <20080825170816.GQ10544@machine.or.cz>
	 <37fcd2780808251020j1ef51b38h7c6d6e8f050a92ce@mail.gmail.com>
	 <20080825172630.GH23582@eagain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Dmitry Potapov" <dpotapov@gmail.com>,
	"Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 25 19:54:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXgH6-0006Fy-8c
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 19:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754742AbYHYRxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 13:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754685AbYHYRxK
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 13:53:10 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:58302 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753838AbYHYRxI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 13:53:08 -0400
Received: by gxk9 with SMTP id 9so2476661gxk.13
        for <git@vger.kernel.org>; Mon, 25 Aug 2008 10:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=41DCHROGsid49TGnV8V6/w2ypw3gYqa27MncxsKE2bk=;
        b=JIKU2zqlNyW556fNhNVJcogD8tbt6/2YW6igPvnF2yMfMRcL9MHDVS8sHwf2T7v63p
         9HlDhfXS2BULSN+9YOdDOJJLtHaMH4Xsgi13UCMFuWAZZE0nKnnUm3Cnuhg9Sa988NQq
         0O3divLuhzcWWdBlBv6RLIoBGIZldkSWSdP6I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=IvzPNXpc5NGr15zmj26aXO9sEf6pR6rSfgjKjEbX4CPD1ci1EVGkE8IWIGSc1LyNei
         8t053qQn9Q8yWpP9aiq8rXjTnAb7xYp44Z+TXTloe5Zis7StdOnjGWRXYQf9jMo9GqB7
         N9PfyxDPImKiR9AbRqAAtNCbezxmp0pUwfflc=
Received: by 10.142.173.8 with SMTP id v8mr1624178wfe.266.1219686786934;
        Mon, 25 Aug 2008 10:53:06 -0700 (PDT)
Received: by 10.142.106.16 with HTTP; Mon, 25 Aug 2008 10:53:06 -0700 (PDT)
In-Reply-To: <20080825172630.GH23582@eagain.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93648>

On Mon, Aug 25, 2008 at 9:26 PM, Tommi Virtanen <tv@eagain.net> wrote:
> On Mon, Aug 25, 2008 at 09:20:38PM +0400, Dmitry Potapov wrote:
>> Perhaps, /usr/sbin would be a better place, as it is intended only for
>> system administration binaries.
>
> I'd argue that git-shell isn't *exclusively* for root, which is the
> criteria for sbin.

I don't think that your criteria is correct. mysqld is also not exclusively
for root as you can run it on a non-privilege port, yet, it is placed in
/usr/sbin. Placing in /usr/sbin does not mean that users do not have access
to it, but that those binaries are not run by users from their command line.

Dmitry
