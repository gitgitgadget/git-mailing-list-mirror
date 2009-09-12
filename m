From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v7 3/6] fast-import: add feature command
Date: Sat, 12 Sep 2009 21:43:41 +0200
Message-ID: <fabb9a1e0909121243l240dcb68jbd0207bd4b21d4ca@mail.gmail.com>
References: <1252247748-14507-1-git-send-email-srabbelier@gmail.com> 
	<1252247748-14507-2-git-send-email-srabbelier@gmail.com> <1252247748-14507-3-git-send-email-srabbelier@gmail.com> 
	<1252247748-14507-4-git-send-email-srabbelier@gmail.com> <20090912185122.GQ1033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Ian Clatworthy <ian.clatworthy@canonical.com>,
	Matt McClure <mlm@aya.yale.edu>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	vcs-fast-import-devs@lists.launchpad.net
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Sep 12 21:44:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmYW1-0008WU-2L
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 21:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754571AbZILToA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Sep 2009 15:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754511AbZILTn7
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 15:43:59 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:40237 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753695AbZILTn6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Sep 2009 15:43:58 -0400
Received: by ewy2 with SMTP id 2so1957005ewy.17
        for <git@vger.kernel.org>; Sat, 12 Sep 2009 12:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=09JUY2cbr0zmMX1ioO3KBi5sZcVw6UMJ/Wi7F0bSGIY=;
        b=f6R3p5qkIolWxrnzZN57+iE+KPrmYAg8DiRX6FUAhHDucRETaCdMclmRsrq967i+Kt
         SGNSYCiuQHMwjszfNNkYn9mBQri9ZkdLKKdPilOlcWIuTtSxLNSX87efBDvRRiNEWeYq
         +++Z61g7LeP/j8BdlFb5gxvJKjJWWsT/uvP6A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=p0urIKEBdugYhxLo4+tpd0DzmieRu9H8jFrEZ9HegAFV1jspTNxwabb683xdbWy8ft
         COVyUQ0NJH5u16h7igQAh2brLntNXM8HlvvlRTi1RHddbDPgzFRXk1pWcnQBeB51/p/h
         XKekxCOVbxgrX4xqDgarEPJqmiLN/fDK+SVb0=
Received: by 10.216.48.211 with SMTP id v61mr641193web.67.1252784641210; Sat, 
	12 Sep 2009 12:44:01 -0700 (PDT)
In-Reply-To: <20090912185122.GQ1033@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128291>

Heya,

On Sat, Sep 12, 2009 at 20:51, Shawn O. Pearce <spearce@spearce.org> wr=
ote:
> Where is the documentation for 'feature date-format=3D<FORMAT>'?

D'oh, I forgot, my bad.

> Also, IIRC the fast-import list agreed that the <feature> name must
> match the re ^[a-zA-Z][a-zA-Z-]*$.

Ah, yes, of course, I'll update that.

>=A0Saying that here does somewhat
> help another fast-import developer to use the same stream format,
> but it does not help a user to understand what features they can
> ask for in their stream.

No, you're absolutely right, there should be a section on supported fea=
tures.

> So its legal to change the data format in the middle of a stream?

I'll add a !seen_non_option_command check to parse_feature, perhaps
renaming it to 'seen_data_command'?

--=20
Cheers,

Sverre Rabbelier
