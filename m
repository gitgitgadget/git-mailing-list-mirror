From: Eugene Sajine <euguess@gmail.com>
Subject: Re: [BUG] - "git commit --amend" commits, when exiting the editor 
	with no changes written
Date: Tue, 2 Feb 2010 19:09:10 -0500
Message-ID: <76c5b8581002021609i4c05d039k35979757fbb74676@mail.gmail.com>
References: <76c5b8581002021207y3eccdc19i9a4abcc3d04315f0@mail.gmail.com>
	 <32541b131002021227o1ec9f369w6096e85382857b8a@mail.gmail.com>
	 <76c5b8581002021247j6df8f609ld9e5d87a060a5423@mail.gmail.com>
	 <394FB581-C9B9-40AB-AFB6-39B68ED5BEAD@wincent.com>
	 <76c5b8581002021356m52bb1817k9a4a29da0d4b681d@mail.gmail.com>
	 <77153A83-158D-4D36-A622-7AA3947C7D52@wincent.com>
	 <76c5b8581002021431o2b5073a0s42b273b6d61893db@mail.gmail.com>
	 <alpine.DEB.1.00.1002022356460.4985@pacific.mpi-cbg.de>
	 <76c5b8581002021534i1f0dbd18y1b216233d282cd84@mail.gmail.com>
	 <alpine.DEB.1.00.1002030056480.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Wincent Colaiuta <win@wincent.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 03 01:09:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcSoZ-00035D-1q
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 01:09:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755952Ab0BCAJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 19:09:13 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:61586 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755660Ab0BCAJL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 19:09:11 -0500
Received: by iwn39 with SMTP id 39so851425iwn.1
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 16:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=PMyFlL/bI1AHk0dMzQj9k1ccApcMbONJ4GbVr2topXE=;
        b=YyIeGrxfn8hTcpMEzbSIM8Hpf4E5OqNGkZo0FU/I3kTczzrgmDvbZ0C8WZ7/yqsZB2
         n2mcmK1/E0yoKtthfUG6sB7PzEzI8ATz6yKEmV5aClpWeZLn181zfoP5z7V7iwjvCfa2
         rRlAkMgLa7yjTt7peuP1GYBRPSFrvUNc7H3KU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=rs40qAZUGrW1lj/o5U2B8DZjVHfRfzGXxTMeEc+iMEKu+aR2Sr/OeUO6NFZ9l9ZLcn
         LqLO7z3ENwsTAofNUF1TRyDcY+HOde2LIXOIVGQEDaOCYOTGBKPA4jShWY1PCEtZbdwa
         FXO96mL8tFrxTKTkDuGcZOY7pArqIldDPA4qU=
Received: by 10.231.79.136 with SMTP id p8mr3472432ibk.4.1265155750481; Tue, 
	02 Feb 2010 16:09:10 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1002030056480.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138791>

> Sorry, your "if message was not saved, abort" is so out of line with any
> program I use that this would be highly confusing (maybe "complicated" was
> the wrong choice of words).

Frankly, i think it is in line with "git commit" and that's the only
thing that matters here as I have no idea what programs you're talking
about. If your programs are working without making sure that user
confirmed whatever he actually supposed to confirm, then you probably
should revisit them;)

Thanks,
Eugene
