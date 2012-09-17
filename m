From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Test failure: Test #3 in t1304-default-acl
Date: Mon, 17 Sep 2012 16:26:15 +0200
Message-ID: <vpqy5k8raig.fsf@grenoble-inp.fr>
References: <CALkWK0n0bH3xPLarv35Th_agnhKCkRjgcKTJR7Xy=B_NkBHkOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 16:26:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDcHQ-00084o-9U
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 16:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756446Ab2IQO0Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 10:26:24 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43919 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756416Ab2IQO0X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 10:26:23 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q8HELXXx025815
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 17 Sep 2012 16:21:33 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TDcHA-0003Fg-7M; Mon, 17 Sep 2012 16:26:16 +0200
In-Reply-To: <CALkWK0n0bH3xPLarv35Th_agnhKCkRjgcKTJR7Xy=B_NkBHkOg@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 17 Sep 2012 07:18:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 17 Sep 2012 16:21:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q8HELXXx025815
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1348496497.91038@Q8AQu5zBX58net4JVQtJYA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205695>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> # file: .git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391
> # owner: ramkum
> # group: domain^users
> user::r--
> user:root:rwx   #effective:r--
> user:kseygold:rwx       #effective:r--
> group::---
> mask::r--
> other::---
>
> I'm not sure who or what kseygold is.

Do you have any user with this login (finger kseygold)? I suspect you
have two usernames with the same user ID.

Which filesystem are you using in this directory?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
