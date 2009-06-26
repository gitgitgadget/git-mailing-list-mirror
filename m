From: Gregory Jefferis <jefferis@gmail.com>
Subject: Re: Choosing a mergetool according to file type
Date: Fri, 26 Jun 2009 14:27:55 +0100
Message-ID: <C66A8B6B.20617%jefferis@gmail.com>
References: <vpqd48rw68k.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 26 15:28:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKBTa-0005KW-1x
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 15:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759246AbZFZN2B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 09:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758687AbZFZN2A
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 09:28:00 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:43101 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759246AbZFZN17 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 09:27:59 -0400
Received: by ewy6 with SMTP id 6so3327886ewy.37
        for <git@vger.kernel.org>; Fri, 26 Jun 2009 06:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:user-agent:date:subject:from
         :to:cc:message-id:thread-topic:thread-index:in-reply-to:mime-version
         :content-type:content-transfer-encoding;
        bh=zkpa8Pts8JzSL44lllhKelLRlvd4VEfT7P6D0by1Xy0=;
        b=BRjhuZcukxpDTbJhgfgLxY/CJxfFiP9EAAbQ9MxAwHLRUIqeLhy8Rj49xqtNxH/zcv
         p/Mm9J4gkA2KJO9qfC2usa2+BYWWK89lCH+wlDXLA4lVunMO9T6F4MM6i0/DPZfnRoBk
         qFtwQzA+dBzEiBJTxAVfgtSM2XgdR85GPNaA8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=user-agent:date:subject:from:to:cc:message-id:thread-topic
         :thread-index:in-reply-to:mime-version:content-type
         :content-transfer-encoding;
        b=tbeN8x6EhtIS0KVVpoCrloyYx5NVxZi9XtnGyqIbJmO8dmysohDtqHfORidEiY2TmM
         61v0Sxyv7UNOjK2UU1KgtP5xVsYP7GRgLcNOCnOp4ePhCmu201G3Hwvtvl+VxMTXb6QE
         8RP2xuX/n44q4595sPefIqk9F+sRMEpvxMDXc=
Received: by 10.211.199.13 with SMTP id b13mr284523ebq.11.1246022881224;
        Fri, 26 Jun 2009 06:28:01 -0700 (PDT)
Received: from ?10.6.0.183? (nat.mrc-lmb.cam.ac.uk [131.111.85.79])
        by mx.google.com with ESMTPS id 7sm2310623eyg.2.2009.06.26.06.28.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Jun 2009 06:28:00 -0700 (PDT)
User-Agent: Microsoft-Entourage/12.13.0.080930
Thread-Topic: Choosing a mergetool according to file type
Thread-Index: Acn2Yem16lTVv1SDh0msPOt5Bfldzg==
In-Reply-To: <vpqd48rw68k.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122298>

Hi Matthieu,

Thanks for your reply.

On 2009-06-26 13:04, "Matthieu Moy" <Matthieu.Moy@imag.fr> wrote:

> Never used it, but man gitattributes says
> 
>    Performing a three-way merge
>        merge
> [...]
>               String
>                  3-way merge is performed using the specified custom merge
> driver. The built-in 3-way merge driver can be explicitly specified by asking
>                  for "text" driver; the built-in "take the current branch"
> driver can be requested with "binary".
> [...]
>        Defining a custom merge driver
> 
> Is it not what you're looking for?

This defines the merge driver but not the mergetool.  A mergetool is
presumably an interactive tool that helps you clean up failed automatic
merges.  For my binary files the internal merge driver "binary" will be used
which as your quote points our keeps the local file and signals a conflict
if it is different from the remote file.  I cannot define a custom merge
driver for my binary word files because I don't have such a program (which
would have to carry out the merge in a non-interactive fashion).  As
mergetool I use a script that calls Word and that of course has to be
interactive.

Best,

Greg.
