From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: [PATCH] To make GIT-VERSION-FILE, search for git more widely
Date: Thu, 07 May 2009 10:40:27 +0200
Message-ID: <op.utjw1pa71e62zd@merlin.emma.line.org>
References: <1241684666-18956-1-git-send-email-matthias.andree@gmx.de>
 <7vws8te2ht.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 07 10:40:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1z9k-0004Rt-Q5
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 10:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755824AbZEGIkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 04:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755507AbZEGIkb
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 04:40:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:54339 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754340AbZEGIka (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 04:40:30 -0400
Received: (qmail invoked by alias); 07 May 2009 08:40:30 -0000
Received: from g226231102.adsl.alicedsl.de (EHLO mandree.no-ip.org) [92.226.231.102]
  by mail.gmx.net (mp054) with SMTP; 07 May 2009 10:40:30 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX1/ICsgt9b7ISltSXtuU9vz8IcKRPtNTdYRsnQsrcl
	43m5ovUQHGEwZZ
Received: from merlin.emma.line.org (localhost [127.0.0.1])
	by merlin.emma.line.org (Postfix) with ESMTP id 9C3DF19402E;
	Thu,  7 May 2009 10:40:28 +0200 (CEST)
In-Reply-To: <7vws8te2ht.fsf@alter.siamese.dyndns.org>
User-Agent: Opera Mail/9.64 (Linux)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118444>

Am 07.05.2009, 10:33 Uhr, schrieb Junio C Hamano <gitster@pobox.com>:

> Matthias Andree <matthias.andree@gmx.de> writes:
>
>> Problem: when git is installed into /usr/local/bin, running 'sudo make
>> install' won't find git in $PATH (because sudo strips PATH, for instance
>> on openSUSE 11.1, and doesn't include /usr/local/whatever).
>
> That sounds like a bug/misfeature in sudo (which I do not use) to me.

Some points:

1. sudo is the default sysadmin setup on Ubuntu (more so than on openSUSE)

2. sudo strips the environment by default for security reasons

3. why would we want to use an old git version (rather than an up to date  
one) to extract the data?

-- 
Matthias Andree
