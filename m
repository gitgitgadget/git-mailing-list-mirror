From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC] Git Wiki Move
Date: Sat, 16 Jan 2010 01:08:20 +0100
Message-ID: <fabb9a1e1001151608k6911bcf8p854d97c2f2d46264@mail.gmail.com>
References: <20100113232908.GA3299@machine.or.cz> <20100114012449.GB3299@machine.or.cz> 
	<4B4EF1E0.3040808@eaglescrag.net> <vpqbpgxrn32.fsf@bauges.imag.fr> 
	<4B4F68E8.5050809@eaglescrag.net> <4B50F7DB.7020204@eaglescrag.net> 
	<fabb9a1e1001151521s1837b3d5o2a35cb5bb35c8038@mail.gmail.com> 
	<4B510217.8060200@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Sat Jan 16 01:08:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVwDd-0005vl-K5
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 01:08:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758481Ab0APAIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 19:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758375Ab0APAIm
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 19:08:42 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:53269 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758055Ab0APAIl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 19:08:41 -0500
Received: by pzk1 with SMTP id 1so1382885pzk.33
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 16:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=nexvhB9FCGtcgzOgvQgbt8fyQpXs7DtpDFEnRSKcGBs=;
        b=doGait4JaoGtgy1eH0GNvTVs8QPq8AsPf//iHlvyy7FoynnRugT0af5VcUADUA9reu
         SyN+eADVmheEjtJt5RCKFRo0lZGIxlF9lw5IEk38n1fJtLpQye+BQraOW8iDLYmqYw6V
         6hWmgBA8GHnUn8bid6hpZvR9w123WNYWgooHc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ueGQl8KM0zUCMZXs0LSLnpjiksNMFoRsnlH/tretbC2vaxUeOhX8QY4UI4GA6SSL5s
         U7l7Nt9uFvoKFLirLLm/A2YlPa2pX9S4qfzoPVRJRcb2qYL0sCmCIFqPmWmUP8IWQeqh
         ZIIiqUjmlKqG0/UTlIjiV0ZOf2rOuZN66ZgI0=
Received: by 10.142.120.26 with SMTP id s26mr1236550wfc.157.1263600520078; 
	Fri, 15 Jan 2010 16:08:40 -0800 (PST)
In-Reply-To: <4B510217.8060200@eaglescrag.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137170>

Heya,

On Sat, Jan 16, 2010 at 01:02, J.H. <warthog19@eaglescrag.net> wrote:
> If you can be more specific I can go through and fix it...

>From the original faq:

<<GitLink(git-name, Because Linus is an egotistical git)>>

Is translated to

<<[[GitLink]](git-name, Because Linus is an egotistical git}}

But should instead be turned into a comment (from the source of the faq):

<!-- GitLink[git-name] Because Linus is an egotistical git -->

> There's some
> extraneous bits on the page that I haven't figured out what they were
> for originally but most everything on the page seems to work fine for me...

We're probably referring to the same then :).

-- 
Cheers,

Sverre Rabbelier
