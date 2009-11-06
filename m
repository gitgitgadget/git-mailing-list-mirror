From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v3 08/12] Allow helper to map private ref names into 
	normal names
Date: Sat, 7 Nov 2009 00:19:32 +0100
Message-ID: <fabb9a1e0911061519j6d64ff50v9b0cefe61965fbbc@mail.gmail.com>
References: <1257547966-14603-1-git-send-email-srabbelier@gmail.com> 
	<1257547966-14603-2-git-send-email-srabbelier@gmail.com> <1257547966-14603-3-git-send-email-srabbelier@gmail.com> 
	<1257547966-14603-4-git-send-email-srabbelier@gmail.com> <1257547966-14603-5-git-send-email-srabbelier@gmail.com> 
	<1257547966-14603-6-git-send-email-srabbelier@gmail.com> <1257547966-14603-7-git-send-email-srabbelier@gmail.com> 
	<1257547966-14603-8-git-send-email-srabbelier@gmail.com> <1257547966-14603-9-git-send-email-srabbelier@gmail.com> 
	<alpine.LNX.2.00.0911061755360.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Nov 07 00:20:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6Y63-0001EQ-Mq
	for gcvg-git-2@lo.gmane.org; Sat, 07 Nov 2009 00:20:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759987AbZKFXTs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 18:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759945AbZKFXTs
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 18:19:48 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:35139 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753697AbZKFXTr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 18:19:47 -0500
Received: by ey-out-2122.google.com with SMTP id 25so376415eya.19
        for <git@vger.kernel.org>; Fri, 06 Nov 2009 15:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=yeKPdXN1alDyq1cgVFjp7/HBkyRq0b6nuI9ix3EJO30=;
        b=AJzuw1rMAjUqqlZW8GC2w4i3z7HUfrvKRnVT3LFzmW25Yz7DyQS7Kbj1oJ/uOLOXYw
         7wDz7BkR8Orwlr29BVl5j1sg62Cv2o34e2/bV3vw9ASxZGyJr+y5x7rM+Oha1XqCP5Pp
         m5/ilzAzgmnjdb+j62nXap42MGUCmqi41vZEg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=P5I/CJEL84L0FxY1KnF2PJDyH0hTazzVwM46y/PefS4JX3sC6jiM2gpL7/6sasFkxM
         5yiL11z+IOf+ybio/olZcwg/smWyDIoX/2zzQ07kK0UU5r/dC8aE4WNIFU86UpkQ38+7
         dzx+iDHR/peVL3IulfCTBDzxUymVkhmmWmTwA=
Received: by 10.216.85.197 with SMTP id u47mr1860806wee.133.1257549592144; 
	Fri, 06 Nov 2009 15:19:52 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.0911061755360.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132342>

Heya,

On Sat, Nov 7, 2009 at 00:12, Daniel Barkalow <barkalow@iabervon.org> wrote:
> At the very least, it needs documentation and memory leaks fixed (the
> refspec strings read from the helper, and the refspec structs and array on
> freeing the helper data).

Please send follow-ups against [0] and I will include them in the next round :).

> Is this actually working with your helper? Occasionally I write code that
> just works without any testing, but I don't usually expect it. :)

Not unless it has some very subtle bugs, it seems to work perfectly on
my helper.

[0] git://github.com/SRabbelier/git.git

-- 
Cheers,

Sverre Rabbelier
