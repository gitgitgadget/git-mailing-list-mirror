From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Handle UNC paths everywhere
Date: Mon, 25 Jan 2010 10:36:59 +0100
Message-ID: <fabb9a1e1001250136n2fb0043av7348db9177f4d096@mail.gmail.com>
References: <201001250155.47664.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 10:37:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZLNv-00022e-37
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 10:37:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000Ab0AYJhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 04:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751928Ab0AYJhV
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 04:37:21 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:37450 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524Ab0AYJhU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 04:37:20 -0500
Received: by pxi12 with SMTP id 12so2552122pxi.33
        for <git@vger.kernel.org>; Mon, 25 Jan 2010 01:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=RDyxNk+QyfXj9C54FZN2ygwJOhxojCH21qD8k64vA1I=;
        b=Ni7sceRQPEp/CRtGoj6EtIaOqb3RI1qWCPK7Avw8PVBqHkXBDk0QkAZMjVjRJ3doQw
         8WJBWzZ2x23U4XO+Zpeh7ZopGdxInguZ9ACAVZHIRCZaBLcys+86vMm3U5ge/bPI5m2t
         cph9wCfUjCBnzpTmHt8Y7OlYLXxgDhq0z2mAE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Th5rUkh2UkkyXKJu+5QsAgmFDeXeumuYdoErzkVG4ZQInwaFmdmjS6dfu8IS3scOs3
         MUSUGeN+i2nWnj0MppbCgE9AeBFKhOdrApPE8cPsTwUPkN9V4zdeYBMikzgAUSRZX7jB
         JBS5oU5pxHw2nFGRe5uUTGlA8bG20lkwHdem4=
Received: by 10.142.248.22 with SMTP id v22mr4389109wfh.180.1264412239090; 
	Mon, 25 Jan 2010 01:37:19 -0800 (PST)
In-Reply-To: <201001250155.47664.robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137943>

Heya,

On Mon, Jan 25, 2010 at 01:55, Robin Rosenberg
<robin.rosenberg@dewire.com> wrote:
> In Windows paths beginning with // are knows as UNC paths. They are
> absolute paths, usually referring to a shared resource on a server.

Cute, but will it actually work? I've tried to use them // paths on
windows before with MSysGit, and it's never worked, probably due to
the same reason why it doesn't work in the cmd prompt (whatever reason
that may be).

-- 
Cheers,

Sverre Rabbelier
