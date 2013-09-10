From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 1/5] pull: rename pull.rename to pull.mode
Date: Tue, 10 Sep 2013 10:16:00 +0200
Message-ID: <vpqmwnljdmn.fsf@anie.imag.fr>
References: <1378689796-19305-1-git-send-email-felipe.contreras@gmail.com>
	<1378689796-19305-2-git-send-email-felipe.contreras@gmail.com>
	<522E3C6A.3070409@bbn.com>
	<CAMP44s1OyST3S1HEdS38WPsjq6w9SekuwT4DRUgVvduATox9tw@mail.gmail.com>
	<20130910022152.GA17154@sigill.intra.peff.net>
	<CAMP44s1FfQ-1pAK8T1cmiZk4i17HnpvzPwuZrzHiiXSmGzbrRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Richard Hansen <rhansen@bbn.com>,
	git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>,
	John Keeping <john@keeping.me.uk>,
	Philip Oakley <philipoakley@iee.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 10 10:16:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJJ7j-0007Zk-Vy
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 10:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755047Ab3IJIQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 04:16:31 -0400
Received: from mx1.imag.fr ([129.88.30.5]:57100 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755011Ab3IJIQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 04:16:28 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r8A8FxKt020191
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 10 Sep 2013 10:15:59 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VJJ7A-0000oj-Hp; Tue, 10 Sep 2013 10:16:00 +0200
In-Reply-To: <CAMP44s1FfQ-1pAK8T1cmiZk4i17HnpvzPwuZrzHiiXSmGzbrRw@mail.gmail.com>
	(Felipe Contreras's message of "Tue, 10 Sep 2013 01:46:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 10 Sep 2013 10:16:00 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8A8FxKt020191
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1379405761.74581@v0QmdcD8T6chiHrzCos9ag
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234424>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Mon, Sep 9, 2013 at 9:21 PM, Jeff King <peff@peff.net> wrote:
>> On Mon, Sep 09, 2013 at 05:49:36PM -0500, Felipe Contreras wrote:
>>
>>> > These deprecation warning messages should be written to stderr, and
>>> > should probably be prefixed with "WARNING: ".
>>>
>>> Is there any deprecation warning that works this way?
>>
>> The ones in C code typically use warning(), which will prefix with
>> "warning:" and write to stderr. They do not use all-caps, though.
>>
>> Try "git log --grep=deprecate -Swarning" for some examples.
>
> I'm asking about the ones in shell, because this is a shell script.

No user cares whether "git pull" is written in shell. shell Vs C is an
implementation detail, stdout Vs stderr is user-visible.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
