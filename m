From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: rc4 - make quick-install-doc is broken
Date: Sat, 04 Aug 2007 12:14:53 -0400
Message-ID: <46B4A5FD.3070107@gmail.com>
References: <46B49617.3070402@gmail.com> <Pine.LNX.4.64.0708041637450.14781@racer.site> <46B4A2B0.9080208@gmail.com> <Pine.LNX.4.64.0708041704040.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Aug 04 18:15:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHMHN-0005tq-AJ
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 18:15:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761493AbXHDQO5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 12:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760224AbXHDQO5
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 12:14:57 -0400
Received: from wx-out-0506.google.com ([66.249.82.229]:8427 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759419AbXHDQO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 12:14:56 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1082045wxd
        for <git@vger.kernel.org>; Sat, 04 Aug 2007 09:14:55 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=aLv1GO95o6pJJhelq5GjEh8cdyEw02ys3vi++LL2l+amjbi9l25U/oiyn8RwSuCDYYFwUJ91w1p8oAdhmkoYHBbhMeQ2r3binJ9DB+plZ0/zfLkgD0F/fsGQd+whLVPFJuBpxVOmJtuwBaKk3kygSt2fjwP39jkQztpOkzkMI/U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=rFCM3VSgNsOcFFWxdXF9jv7i1rE/72XdMrIXwufQ6hNSB5bkLqWW2OjYLZV9aW+EhfeB5gi17bTWA163pfFR5VG7HFvtO+XhF3XLH1cIhCVLXNY70G6J2AJJeacA3ipIWz0TP5X5wVVuWd+ahCM5DuXrsd2eBy54jleTvrM73h8=
Received: by 10.90.52.18 with SMTP id z18mr3860056agz.1186244095581;
        Sat, 04 Aug 2007 09:14:55 -0700 (PDT)
Received: from ?192.168.100.118? ( [72.66.124.87])
        by mx.google.com with ESMTPS id 6sm5396259agd.2007.08.04.09.14.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Aug 2007 09:14:54 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.12 (Windows/20070509)
In-Reply-To: <Pine.LNX.4.64.0708041704040.14781@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54877>

Johannes Schindelin wrote:
>
> Could you please
>
> 	GIT_TRACE=1 make quick-install-doc
>
> ? It breaks here, too, but because I have no origin/man branch.
>
> Ciao,
> Dscho
>
>
>   
git>GIT_TRACE=1 make prefix=/usr quick-install-doc
make -C Documentation quick-install
make[1]: Entering directory `/usr/src/git/Documentation'
make -C ../ GIT-VERSION-FILE
make[2]: Entering directory `/usr/src/git'
make[2]: `GIT-VERSION-FILE' is up to date.
make[2]: Leaving directory `/usr/src/git'
sh ./install-doc-quick.sh origin/man /usr/share/man
trace: built-in: git 'rev-parse' '--git-dir'
trace: built-in: git 'rev-parse' '--verify' 'origin/man^0'
trace: built-in: git 'read-tree' 'origin/man'
trace: built-in: git 'checkout-index' '-a' '-f' '--prefix=/usr/share/man/'
make[1]: Leaving directory `/usr/src/git/Documentation'
git>man git
No manual entry for git
git>

Mark
