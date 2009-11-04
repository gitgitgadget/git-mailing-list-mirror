From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2 09/13] Honour the refspec when updating refs after 
	import
Date: Wed, 4 Nov 2009 22:21:23 +0100
Message-ID: <fabb9a1e0911041321i1ccec898r53ddafb9405c6331@mail.gmail.com>
References: <1257364098-1685-1-git-send-email-srabbelier@gmail.com> 
	<1257364098-1685-10-git-send-email-srabbelier@gmail.com> <alpine.LNX.2.00.0911041601170.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Nov 04 22:21:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5nId-0002ZB-D5
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 22:21:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932634AbZKDVVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 16:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932632AbZKDVVl
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 16:21:41 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:64652 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932609AbZKDVVk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 16:21:40 -0500
Received: by bwz27 with SMTP id 27so9360243bwz.21
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 13:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=CEUCpkRIxOePh9Xtx3tQqSQNvpdJ8cqzUAdvMAGP2bc=;
        b=A7EQRyoA9TP8F+0dxhmGGvhE0CtFJktPNOT3EprxUSX9c7g7WmpTDSLUgf2/CL0UQ7
         19c5hLnPhfGXf3yHPoXy64VoP1nKuPc0/azlkUbChpnPndLexMylI4r49hxgH0uI6tCg
         z/Gvl0kFuVM4yLf5OilOfTc846MZKEb8abukU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=A2CN2kQfOevNOIKNUxDlfxl2+uzne2CnGQ/LZ6zDgEz/38fj73tDlTAtXJN/kyCUQa
         9RZYTq6vrkG/nGsGi1U2eQvksU+q2owfTPrIgySvshwrWpajsN/9ehxeea/6bzhja8QX
         ZZ/XdzMm/MpHfTJIeH9EuBfQ5OHMmi6yWEazk=
Received: by 10.204.20.143 with SMTP id f15mr2076034bkb.49.1257369703668; Wed, 
	04 Nov 2009 13:21:43 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.0911041601170.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132150>

Heya,

On Wed, Nov 4, 2009 at 22:20, Daniel Barkalow <barkalow@iabervon.org> wrote:
> That's not true for "git pull <url> <branch>"; we do want the remote ref,
> but it doesn't have a local peer. I think going straight to the refspec
> command is the right answer.

Can you clarity what you mean with "the refspec command"?

-- 
Cheers,

Sverre Rabbelier
