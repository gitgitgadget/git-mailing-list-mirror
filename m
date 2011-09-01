From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Dropping '+' from fetch = +refs/heads/*:refs/remotes/origin/*?
Date: Thu, 1 Sep 2011 12:50:48 -0700
Message-ID: <CAJo=hJv4CkmaJuVvCA2VdO68zn4Xb9EQsdP8p1W-7B9zbvXSaQ@mail.gmail.com>
References: <7vliu8w25g.fsf@alter.siamese.dyndns.org> <4E5FDAFE.6050004@drmicha.warpmail.net>
 <vpqippcm4x4.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Sep 01 21:51:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzDIH-0004tm-1k
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 21:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757842Ab1IATvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 15:51:11 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:58043 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757493Ab1IATvK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 15:51:10 -0400
Received: by gya6 with SMTP id 6so1648347gya.19
        for <git@vger.kernel.org>; Thu, 01 Sep 2011 12:51:09 -0700 (PDT)
Received: by 10.42.156.132 with SMTP id z4mr201915icw.160.1314906668841; Thu,
 01 Sep 2011 12:51:08 -0700 (PDT)
Received: by 10.236.95.48 with HTTP; Thu, 1 Sep 2011 12:50:48 -0700 (PDT)
In-Reply-To: <vpqippcm4x4.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180569>

On Thu, Sep 1, 2011 at 12:35, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> By asking users to explicitely say "yes, I know, this branch can be
> rewond", we also ask them to think about it before making a mistake.
>
> That said, enabling the check by default may also become painful. I'd
> vote for a configuration option, defaulting to the current behavior for
> now. Then we can try living with it for a while and see how painful it
> is.

I suspect the vast majority of branches in the wild do not rewind
under normal conditions. Users who work against branches that rewind
(e.g. those of us basing on a topic in pu) are already sophisticated
enough with Git to understand what the fetch error would mean and fix
it.

IMHO, just change the default in clone, and better, add a warning to
fetch if that default pattern is still in the configuration file. Let
the user either remove the wildcarded force fetch spec, or add a new
configuration variable to his remote block to silence the warning.

-- 
Shawn.
