From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: GIT_ONE_FILESYSTEM inclusion?
Date: Wed, 24 Mar 2010 14:43:26 +0100
Message-ID: <vpqd3yt4yyp.fsf@bauges.imag.fr>
References: <20100323232055.GV7038@pixar.com>
	<81b0412b1003240229l6f7eaa18l563c3d7ba0cf6cc5@mail.gmail.com>
	<4BA9DCDD.6060109@viscovery.net>
	<81b0412b1003240437n799bac07sb74db749d647817d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Lars Damerow <lars@pixar.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 24 14:43:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuQs2-0002Tr-KN
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 14:43:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755400Ab0CXNnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 09:43:37 -0400
Received: from mx1.imag.fr ([129.88.30.5]:54875 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755331Ab0CXNng (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 09:43:36 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o2ODdaQR031240
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 24 Mar 2010 14:39:36 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NuQrm-00053v-Mj; Wed, 24 Mar 2010 14:43:26 +0100
In-Reply-To: <81b0412b1003240437n799bac07sb74db749d647817d@mail.gmail.com> (Alex Riesen's message of "Wed\, 24 Mar 2010 12\:37\:39 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 24 Mar 2010 14:39:37 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o2ODdaQR031240
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1270042777.38217@yp5+jCTcT/cZz+n7jCScNQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143083>

Alex Riesen <raa.lkml@gmail.com> writes:

> On Wed, Mar 24, 2010 at 10:35, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Am 3/24/2010 10:29, schrieb Alex Riesen:
>>> And while at it, how about making it a config option? (i.e. core.oneFilesystem?)
>>
>> It's difficult to have this as a config option when you are looking for a
>> repository... ;)
>>
>
> Isn't it a little pointless to look for repository when you can't
> access its config?

I guess Johannes's point is that the config option can be in
$GIT_DIR/config, which you can't access when looking for $GIT_DIR.
OTOH, looking at ~/.gitconfig to find a core.oneFilesystem makes sense
(but is probably painfull to implement since the current code to parse
config file will look for $GIT_DIR first).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
