From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v3 08/12] Allow helper to map private ref names into 
	normal names
Date: Mon, 9 Nov 2009 07:42:43 +0100
Message-ID: <fabb9a1e0911082242k5950d780i584a4714e384e007@mail.gmail.com>
References: <1257547966-14603-1-git-send-email-srabbelier@gmail.com> 
	<1257547966-14603-3-git-send-email-srabbelier@gmail.com> <1257547966-14603-4-git-send-email-srabbelier@gmail.com> 
	<1257547966-14603-5-git-send-email-srabbelier@gmail.com> <1257547966-14603-6-git-send-email-srabbelier@gmail.com> 
	<1257547966-14603-7-git-send-email-srabbelier@gmail.com> <1257547966-14603-8-git-send-email-srabbelier@gmail.com> 
	<1257547966-14603-9-git-send-email-srabbelier@gmail.com> <alpine.LNX.2.00.0911061755360.14365@iabervon.org> 
	<fabb9a1e0911061519j6d64ff50v9b0cefe61965fbbc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Nov 09 07:43:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7Ny1-00039J-Ne
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 07:43:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752813AbZKIGm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 01:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752664AbZKIGm7
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 01:42:59 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:27302 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191AbZKIGm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 01:42:58 -0500
Received: by ey-out-2122.google.com with SMTP id 25so102643eya.19
        for <git@vger.kernel.org>; Sun, 08 Nov 2009 22:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=B2mD1XVKQQ9DjHcl3rAosQrtYu+RkhCgDQySqoIsRDs=;
        b=TOwjFn48WbaJefTH0L26bh9uOGM1mq8ctpYdgYGqnm9x3TuSiWBx9u+gdsaf+V42+8
         osd3XiPmAgCP0rpsncjCwCS35iwz6F63ib59YNOvKDMTG0d75ZErGec5/ZMbvQy/swzl
         2kmXG2f4wMSb4pAT+oxX+6V7gEOMAKBNaMjf8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=YoFq9JjsPuMhKJ/vQgHvkSDjxTVV88O/BtYK3J4DBOgn7fX8Dqp0uxxMaoLpD7xqo+
         3XznXbjC5JxbNKj1n1eKcgO5Jy7CUPuPBwIoweDpe/iNn8miB+BfmnE+NkbR05x2Utpi
         C8DBlPqqk1pf7/7GXw4MTRz8wY15+5pIktsWs=
Received: by 10.216.87.3 with SMTP id x3mr122321wee.132.1257748983129; Sun, 08 
	Nov 2009 22:43:03 -0800 (PST)
In-Reply-To: <fabb9a1e0911061519j6d64ff50v9b0cefe61965fbbc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132444>

Heya,

On Sat, Nov 7, 2009 at 00:19, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> On Sat, Nov 7, 2009 at 00:12, Daniel Barkalow <barkalow@iabervon.org> wrote:
>> At the very least, it needs documentation and memory leaks fixed (the
>> refspec strings read from the helper, and the refspec structs and array on
>> freeing the helper data).
>
> Please send follow-ups against [0] and I will include them in the next round :).

It's in next now, so please send follow-ups against sr/vcs-helper.

-- 
Cheers,

Sverre Rabbelier
