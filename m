From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCHv2 2/2] Add a command "fixup" to rebase --interactive
Date: Mon, 7 Dec 2009 12:26:37 +0100
Message-ID: <fabb9a1e0912070326s6cda5c8r442c4816538d0e2a@mail.gmail.com>
References: <cover.1260099005.git.mhagger@alum.mit.edu> <ced6765cff6225a05f196a6896ab577850979ab1.1260099005.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, gitster@pobox.com, git@drmicha.warpmail.net,
	Johannes.Schindelin@gmx.de, bgustavsson@gmail.com
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Dec 07 12:27:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHbk8-00074m-SU
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 12:27:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933682AbZLGL0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 06:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753572AbZLGL0w
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 06:26:52 -0500
Received: from mail-vw0-f197.google.com ([209.85.212.197]:35839 "EHLO
	mail-vw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752706AbZLGL0v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 06:26:51 -0500
Received: by vws35 with SMTP id 35so1979338vws.4
        for <git@vger.kernel.org>; Mon, 07 Dec 2009 03:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=uGr1zYZmDaUGdaPWBTeuzImxnYzixY6qusxr4Lp6sb4=;
        b=rw/7POWDQ4VbXLqMbCxV/RIPH+tDiW/PGpL/g3OinfEysKmjVY38pZ7e984dLKUoD+
         gr1IHO0CPXvndQtuQUBwi+Q0HOzvlHIEfCO6nvgwKJTQfyIosE8a9+O8H1FZFplnpygD
         7f3n2QVyY27iYZHx/RSjDDBylFyZyFmypVa+A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=UdOt3cwK+RIA53LI73qldsdUO3JO3D0VpYgFGD93F7VpCATOmoA0Nqb0hUM+BW3y/r
         WsK6QoeT57Az4JSncvA57puQOIuuzbnAkf99cCI413ivt1pZZb0y6RWB7Sz2ACuvw9lV
         VOdJm+kE4YqNguEjrEphixIXYugLsX2DsxeiI=
Received: by 10.220.127.2 with SMTP id e2mr8086146vcs.70.1260185217533; Mon, 
	07 Dec 2009 03:26:57 -0800 (PST)
In-Reply-To: <ced6765cff6225a05f196a6896ab577850979ab1.1260099005.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134737>

Heya,

On Mon, Dec 7, 2009 at 05:22, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> The command is like "squash", except that it discards the commit message
> of the corresponding commit.

No no, wait, wasn't "fixup" supposed to let you just edit the commit
message of the commit you're fixing up? :(

-- 
Cheers,

Sverre Rabbelier
