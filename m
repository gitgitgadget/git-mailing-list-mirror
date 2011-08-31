From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: done feature in remote-helpers (was Re: [PATCH 2/2] Add a remote helper to interact with mediawiki (fetch & push))
Date: Wed, 31 Aug 2011 15:12:13 +0200
Message-ID: <vpq4o0xpvwy.fsf@bauges.imag.fr>
References: <1314378689-8997-1-git-send-email-Matthieu.Moy@imag.fr>
	<1314378689-8997-2-git-send-email-Matthieu.Moy@imag.fr>
	<7v4o14dppz.fsf@alter.siamese.dyndns.org>
	<CAGdFq_iYRkfnTbYAgmX1g4uOxWb_ZYxr+TNinVfWRV-zXrnzAg@mail.gmail.com>
	<7v4o1092hn.fsf@alter.siamese.dyndns.org>
	<CAGdFq_jwLGZ+tLKramRrLJmwyY_uDtj7JXUwYBO9pSqOmZ20xQ@mail.gmail.com>
	<vpq1uw13hx3.fsf_-_@bauges.imag.fr>
	<CAGdFq_jyVK3_THYXzCOLDpNww0Npn2qzZ1qv-BMuLbg1vgVjZw@mail.gmail.com>
	<vpqk49tviza.fsf@bauges.imag.fr>
	<CAGdFq_hFPBeogpX0Qp8Knfssw8QzV+GwCAyH+zZhM2iEJfFYMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>,
	Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 31 15:12:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qykan-0006rn-B5
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 15:12:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755403Ab1HaNMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 09:12:22 -0400
Received: from mx1.imag.fr ([129.88.30.5]:53895 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755349Ab1HaNMV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 09:12:21 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p7VDBatJ005802
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 31 Aug 2011 15:11:36 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QykaT-0000Ak-Qz; Wed, 31 Aug 2011 15:12:13 +0200
In-Reply-To: <CAGdFq_hFPBeogpX0Qp8Knfssw8QzV+GwCAyH+zZhM2iEJfFYMw@mail.gmail.com>
	(Sverre Rabbelier's message of "Wed, 31 Aug 2011 14:58:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 31 Aug 2011 15:11:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p7VDBatJ005802
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1315401100.31199@JdxMIP/3QfoMYAUSxFpZyg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180467>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> You can have multiple imports in the current system, you just need to
> remember to add the trailing newline.
>
> import refs/heads/master
> \n
> import refs/heads/next
> \n

Then I'm lost. Isn't \n supposed to mean that the list of commands is
over, and that the remote-helper should terminate?

Also, who is "you" in your sentence? It can't be the remote helper
(which reads this sequence), so it has to be Git's transport-helper. Are
you saying that the transport-helper should be modified to add \n after
sending an import command?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
