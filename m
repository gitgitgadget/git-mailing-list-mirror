From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Dropping '+' from fetch = +refs/heads/*:refs/remotes/origin/*?
Date: Fri, 02 Sep 2011 07:55:30 +0200
Message-ID: <vpqliu7lc8d.fsf@bauges.imag.fr>
References: <7vliu8w25g.fsf@alter.siamese.dyndns.org>
	<4E5FDAFE.6050004@drmicha.warpmail.net>
	<vpqippcm4x4.fsf@bauges.imag.fr>
	<CAJo=hJv4CkmaJuVvCA2VdO68zn4Xb9EQsdP8p1W-7B9zbvXSaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Sep 02 07:55:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzMjD-0004nY-65
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 07:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758134Ab1IBFzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Sep 2011 01:55:42 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36465 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758094Ab1IBFzl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2011 01:55:41 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p825slcs003615
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 2 Sep 2011 07:54:47 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QzMiw-0000uQ-PZ; Fri, 02 Sep 2011 07:55:30 +0200
In-Reply-To: <CAJo=hJv4CkmaJuVvCA2VdO68zn4Xb9EQsdP8p1W-7B9zbvXSaQ@mail.gmail.com>
	(Shawn Pearce's message of "Thu, 1 Sep 2011 12:50:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 02 Sep 2011 07:54:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p825slcs003615
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1315547690.43116@X08ghsnhR1eltGBfGRyRbw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180598>

Shawn Pearce <spearce@spearce.org> writes:

> On Thu, Sep 1, 2011 at 12:35, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
>> By asking users to explicitely say "yes, I know, this branch can be
>> rewond", we also ask them to think about it before making a mistake.
>>
>> That said, enabling the check by default may also become painful. I'd
>> vote for a configuration option, defaulting to the current behavior for
>> now. Then we can try living with it for a while and see how painful it
>> is.
>
> I suspect the vast majority of branches in the wild do not rewind
> under normal conditions. Users who work against branches that rewind
> (e.g. those of us basing on a topic in pu)

Err, I don't think it's about people basing their work on pu, but rather
about anybody fetching from pu, i.e. everybody calling "git fetch" or
"git pull" in their clone.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
