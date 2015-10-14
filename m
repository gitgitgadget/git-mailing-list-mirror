From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: repository corruption when pushing commits to a repository running 'git gc --prune='
Date: Wed, 14 Oct 2015 23:09:52 +0200
Message-ID: <vpqtwpt6tsv.fsf@grenoble-inp.fr>
References: <561E5C5B.3090207@alcatel-lucent.com>
	<vpq4mhtbjma.fsf@grenoble-inp.fr>
	<xmqqoag18i6w.fsf@gitster.mtv.corp.google.com>
	<vpqmvvl8fb1.fsf@grenoble-inp.fr>
	<xmqqtwpt6usi.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jan Smets <jan.smets@alcatel-lucent.com>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 23:10:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmTJO-0008Iv-Rw
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 23:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754074AbbJNVKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 17:10:04 -0400
Received: from mx1.imag.fr ([129.88.30.5]:56823 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753930AbbJNVKA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 17:10:00 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t9EL9oIF025693
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 14 Oct 2015 23:09:51 +0200
Received: from anie (ensi-vpn-233.imag.fr [129.88.57.233])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t9EL9rIM003497;
	Wed, 14 Oct 2015 23:09:53 +0200
In-Reply-To: <xmqqtwpt6usi.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 14 Oct 2015 13:48:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 14 Oct 2015 23:09:51 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t9EL9oIF025693
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1445461791.9954@glbMCKffV6Rt/HqKC/z9OA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279627>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Looks good to me. I think the same should be added to git-prune.txt
>> under --expire.
>
> I thought about it, but decided against it, as the command is not
> even recommended to end users.

Even non-"end users" can shoot themselves in the foot. Someone writting
a script using "git prune" may actually shoot in other people's foot ...

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
