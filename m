From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2 11/13] Allow helpers to request the path to the .git 
	directory
Date: Thu, 5 Nov 2009 00:18:52 +0100
Message-ID: <fabb9a1e0911041518h9e3d07dneba3056848e98f3e@mail.gmail.com>
References: <1257364098-1685-1-git-send-email-srabbelier@gmail.com> 
	<1257364098-1685-12-git-send-email-srabbelier@gmail.com> <alpine.LNX.2.00.0911041621400.14365@iabervon.org> 
	<fabb9a1e0911041406tce0956ai2ad3fe6cfbdc546d@mail.gmail.com> 
	<alpine.LNX.2.00.0911041723010.14365@iabervon.org> <fabb9a1e0911041442k493c5d7cx493c2e5dac9d892c@mail.gmail.com> 
	<alpine.LNX.2.00.0911041748150.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Nov 05 00:21:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5p8K-0008Fl-O9
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 00:19:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933073AbZKDXTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 18:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932948AbZKDXTJ
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 18:19:09 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:44742 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932750AbZKDXTI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 18:19:08 -0500
Received: by ewy3 with SMTP id 3so3719075ewy.37
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 15:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=pqhMclEb2Xif9iw+/aDb2YoKUQFOgVwdan/D2XGB+Z0=;
        b=U3IssfxwzdkY5GMiMyEM4/GbmzFsF9cc4c7zu5rtkxZ6uX+g9vEhmXCBAhaXXCSyHh
         jSbSku7kkopzE+/YOP8ZTsvnQoDqRAKdld/duNS+Ts14J/O/rUDt2Xwu3gm09pNsWqJK
         hZOa8TiPwZqiJ+iq/I2fNi+8usrLAQiB3Rs24=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=svosaaAZg3/D8avKett6z8V4FJI8/4WXQEf1mPet+sBeQ2Qxi6OZhbTgVcFAcRfSux
         Sxkj9VPKhjK2H/IwMDpNkb2lFsdFnogyvsyvVBwOe6bx059G5LLhv2//EV1UBMZ2SuuZ
         4HbXhYWXO41PeCb5E3Qm2t7OLMUuqczqR1n/U=
Received: by 10.216.88.75 with SMTP id z53mr700880wee.46.1257376752392; Wed, 
	04 Nov 2009 15:19:12 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.0911041748150.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132170>

Heya,

On Thu, Nov 5, 2009 at 00:17, Daniel Barkalow <barkalow@iabervon.org> wrote:
> Well, gfi is used with different native systems, each of which will
> presumably put it somewhere different.

Right, but I meant for git itself :). I assume that you meant that
'gitdir' (or 'infodir' , whatever) should return the same path,
whatever we decide on?q

-- 
Cheers,

Sverre Rabbelier
