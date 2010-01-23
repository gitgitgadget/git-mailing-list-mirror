From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Handle double slashes in make_relative_path()
Date: Sat, 23 Jan 2010 22:01:38 +0100
Message-ID: <fabb9a1e1001231301o149bb13es236a7150f57ce161@mail.gmail.com>
References: <379d55c6a4110736aadb8ace3b050de879a9deab.1264118830.git.trast@student.ethz.ch> 
	<7vwrz8bnbj.fsf@alter.siamese.dyndns.org> <7viqasbmtc.fsf@alter.siamese.dyndns.org> 
	<201001232141.49556.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Jan 23 22:02:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYn7i-00040J-8I
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 22:02:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070Ab0AWVCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 16:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751848Ab0AWVCB
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 16:02:01 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:48279 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943Ab0AWVB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 16:01:58 -0500
Received: by pwi21 with SMTP id 21so1497591pwi.21
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 13:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=oQIeMT2X5r4wNTgqRVWe3DgvZfDECRomLoEm8+a2Wis=;
        b=mQJw5qIDiEXFzezI9l6IWCVQzTw+oqq34+psGP2gtlQTPrDreqQ10/AN/JxpR8svhK
         NPsTDJgIUFuob48+TImnSC6YDVRXfO8nwMLL7vIM6uJRB2bkReQ7N6ht3XXpVfrKDn9W
         m3nCqqpOal2o8kfMqw/TSvvWDa5ZarxwjEfgA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=iNavR/R0GWHHQhp0TAeYpHhZJS/g8D5SynDkpxj/02D6KzHJjIzUvX2SXEFD4s+zpB
         SEOOR7qQig/SqiTnFAhgnH5Jeqp14DNudCv8c01lUmQZn5JngSRWgffFsMpTwhrhVrlo
         wVUVi+qY46B595IVld2B49H0qTRQYW1A0fk8M=
Received: by 10.142.5.10 with SMTP id 10mr3140914wfe.334.1264280518131; Sat, 
	23 Jan 2010 13:01:58 -0800 (PST)
In-Reply-To: <201001232141.49556.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137863>

Heya,

On Sat, Jan 23, 2010 at 21:41, Johannes Sixt <j6t@kdbg.org> wrote:

> OTOH, it can be worked around easily by the user (just insert the drive
> prefix). Dunno...

I think it's preferable to keep the old behavior where we fail if the
user gives us an invalid argument, rather than fix a user error and
break on a a valid argument instead. I think we should be correct
first, and try and fix incorrect user behavior after.

-- 
Cheers,

Sverre Rabbelier
