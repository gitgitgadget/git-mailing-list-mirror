From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] git-checkout.txt: Document "git checkout <pathspec>" better
Date: Wed, 17 Jun 2015 12:54:46 +0200
Message-ID: <vpq8ubiwqo9.fsf@anie.imag.fr>
References: <558127CB.70603@web.de>
	<CACsJy8CuRcV2Rxaz8Ut4ayW-Hyd8Aao5W4JMc20jcfggOG3d4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Ed Avis <eda@waniasset.com>, Scott Schmit <i.grok@comcast.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 12:55:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Azo-0006GR-DA
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 12:55:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752715AbbFQKyz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Jun 2015 06:54:55 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50116 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751095AbbFQKyy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 06:54:54 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5HAsjlS028344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 17 Jun 2015 12:54:45 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5HAsk9l003023;
	Wed, 17 Jun 2015 12:54:46 +0200
In-Reply-To: <CACsJy8CuRcV2Rxaz8Ut4ayW-Hyd8Aao5W4JMc20jcfggOG3d4g@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 17 Jun 2015 16:58:27 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 17 Jun 2015 12:54:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5HAsjlS028344
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1435143288.39552@vZALccyRG9Kd6vUdN84gJQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271829>

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Jun 17, 2015 at 2:54 PM, Torsten B=F6gershausen <tboegi@web.d=
e> wrote:
>> -git-checkout - Checkout a branch or paths to the working tree
>> +git-checkout - Switch branches or restore changes
>
> I didn't follow closely the previous discussion.

(Neither did I)

> Forgive me if this is already discussed, but I would keep the "in the
> working tree". "Restore changes" alone seems vague.

"Restore previous version" would be better than "Restore changes" to me=
=2E

"changes" sounds like "the diff between a commit and its parent", so it
makes sense to "revert a change" (git revert), but not "restore a
change".

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
