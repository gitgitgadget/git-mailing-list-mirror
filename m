From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH] am: terminate state files with a newline
Date: Sun, 23 Aug 2015 14:30:55 +0200
Message-ID: <20150823143055.Horde.3dpHsKGqU554G1p_Uz_Iiw1@webmail.informatik.kit.edu>
References: <20150820152247.Horde.3yFLIbhFFocB99yz8o1iwg1@webmail.informatik.kit.edu>
 <xmqqa8tl7qi3.fsf@gitster.dls.corp.google.com>
 <20150823055053.GA15849@yoshi.chippynet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 23 14:31:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTUQq-0005CS-GB
	for gcvg-git-2@plane.gmane.org; Sun, 23 Aug 2015 14:31:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752328AbbHWMbJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Aug 2015 08:31:09 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:43343 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751769AbbHWMbI convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2015 08:31:08 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1ZTUQT-0005xs-1B; Sun, 23 Aug 2015 14:31:05 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1ZTUQJ-0005m8-5Y; Sun, 23 Aug 2015 14:30:55 +0200
Received: from x590ccb1b.dyn.telefonica.de (x590ccb1b.dyn.telefonica.de
 [89.12.203.27]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Sun, 23 Aug 2015 14:30:55 +0200
In-Reply-To: <20150823055053.GA15849@yoshi.chippynet.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1440333065.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276404>

Hi,

Quoting Paul Tan <pyokagan@gmail.com>:

> Did we ever explictly allow external programs to poke around the
> contents of the .git/rebase-apply directory? I think it may not be so
> good, as it means that it may not be possible to switch the storage
> format in the future (e.g. to allow atomic modifications, maybe?) :-/=
 .

Think of e.g. libgit2, JGit/EGit and all the other git implementations.
They should be able to look everywhere in .git, shouldn't they?

I don't think we will just "switch" the storage format of any parts of =
the
repo.  Whatever new formats may come (ref backends, index v5, pack v4),
they will be an opt-in feature for a long time before becoming default,
and there must be an even longer deprecation period before the old form=
at
gets phased out, if ever.


G=C3=A1bor
