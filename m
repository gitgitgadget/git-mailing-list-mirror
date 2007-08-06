From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] (Really) Fix install-doc-quick target
Date: Mon, 06 Aug 2007 19:49:08 -0400
Message-ID: <46B7B374.4010304@gmail.com>
References: <7vmyx6fohv.fsf_-_@assigned-by-dhcp.cox.net> <11864401942772-git-send-email-mdl123@verizon.net> <Pine.LNX.4.64.0708062349460.14781@racer.site> <7vzm149s8s.fsf@assigned-by-dhcp.cox.net> <46B7B10F.4060402@gmail.com> <Pine.LNX.4.64.0708070042450.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mdl123@verizon.net>,
	Git Mailing List <git@vger.kernel.org>,
	Ren Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 07 01:49:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IICKJ-0004IC-6L
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 01:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933118AbXHFXtN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 19:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932623AbXHFXtN
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 19:49:13 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:62431 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932250AbXHFXtL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 19:49:11 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1590238wxd
        for <git@vger.kernel.org>; Mon, 06 Aug 2007 16:49:11 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=oliHWpmPHMtk8r+NaDDfPPaNoke4Xr+6sjCcEucEa3/xy2qOMbqnUo5kCuzeBg4ZXLh5jwSY5A3NJgY0wCEuX9yhkO0oAs43PsLX+wuXdChYErzduo8bdTGYtLzSIfEMVh9AaGbxm4JPpzqXaVVjtfw8KZpGe1KfuEU4FWpdp30=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=UcqQlNzBPzsv25tdacWIWZtFLl1usQEbC6DBLv/DB6hlvJfEuCxB5l7mHX6m0uA2FL4HL9WfelbFXrzo4TwFNniP7BExu4j/JojGWRgWDH39STc5oYHNo0DzFLWMXTKncZavUjhE01TLJjmrWs8nd4yvdOIS2tlgfDfvZ84ebhE=
Received: by 10.90.99.20 with SMTP id w20mr5394467agb.1186444150927;
        Mon, 06 Aug 2007 16:49:10 -0700 (PDT)
Received: from ?192.168.100.118? ( [72.66.124.87])
        by mx.google.com with ESMTPS id 38sm8402708agd.2007.08.06.16.49.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Aug 2007 16:49:10 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.12 (Windows/20070509)
In-Reply-To: <Pine.LNX.4.64.0708070042450.14781@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55190>

Johannes Schindelin wrote:
> Ah, I suspect you do not have the latest 'master' installed?
>
> Ciao,
> Dscho
>
>   
git>git fetch origin
git>git show-ref origin/master
a76c2acb28146f5630592f2ba738c0ebf0f3c1c4 refs/remotes/origin/master
git>git checkout -b test origin/master
Branch test set up to track remote branch refs/remotes/origin/master.
Switched to a new branch "test"
git>GZ=1 make prefix=/usr quick-install-doc
GIT_VERSION = 1.5.3.rc4.16.ga76c2
make -C Documentation quick-install
make[1]: Entering directory `/usr/src/git/Documentation'
rm -f doc.dep+ doc.dep
perl ./build-docdep.perl >doc.dep+
mv doc.dep+ doc.dep
make -C ../ GIT-VERSION-FILE
make[2]: Entering directory `/usr/src/git'
make[2]: `GIT-VERSION-FILE' is up to date.
make[2]: Leaving directory `/usr/src/git'
make[1]: Leaving directory `/usr/src/git/Documentation'
make[1]: Entering directory `/usr/src/git/Documentation'
make -C ../ GIT-VERSION-FILE
make[2]: Entering directory `/usr/src/git'
make[2]: `GIT-VERSION-FILE' is up to date.
make[2]: Leaving directory `/usr/src/git'
sh ./install-doc-quick.sh origin/man /usr/share/man
fatal: Not a git repository
make[1]: Leaving directory `/usr/src/git/Documentation'
git>
