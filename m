From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Git: "No you can't handle my root!" (?)
Date: Mon, 12 Oct 2009 17:57:25 -0400
Message-ID: <32541b130910121457x632fc8b1xc58eca9d8b646500@mail.gmail.com>
References: <20091012012826.7sffggwmm8sk0cc8@webmail.demarque.qc.ca> 
	<1255383459.15646.10.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniele Segato <daniele.bilug@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 00:08:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxT40-0004FJ-M7
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 00:08:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933371AbZJLV6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 17:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933369AbZJLV6X
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 17:58:23 -0400
Received: from mail-gx0-f212.google.com ([209.85.217.212]:48819 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933368AbZJLV6W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 17:58:22 -0400
Received: by gxk4 with SMTP id 4so10362252gxk.8
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 14:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=RWWGLa+WDcYU++Jy/gts5JO1hcx4I94KM9T751L1OHw=;
        b=kgLI9y4VlvBCk1vEwc9ni00b4+R/R+bTH6U6khx7toduZ5pNqSbtl69UO9PzGKB8Do
         jW7R3R8FNhU/FRtGMyZ/A4d43D2gbu80lgo62eGZub5FPt6J4KG5toQLPHnyfCXUn6q8
         p2xim0jNZaA3lcF7YnLRKs5bsxVpdglBaSOB8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=f/7i/4P0863lkMWR7qw0kdEZaYj7TCFB2e8A/Zu4Ow5VuT9u++13ZmPMBaRF2/XGCF
         +IghldghFFu7FYDwsObzLhpGjEBVVZbXgjMQzVTaoa1eVyrxnYAPCPgnpbmuigypOpxS
         uQHH4JOP5wWhPdDt9MvEZxVF/u4aq7pClXLco=
Received: by 10.150.63.13 with SMTP id l13mr11096388yba.5.1255384665058; Mon, 
	12 Oct 2009 14:57:45 -0700 (PDT)
In-Reply-To: <1255383459.15646.10.camel@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130085>

On Mon, Oct 12, 2009 at 5:37 PM, Daniele Segato <daniele.bilug@gmail.com> wrote:
> can I have a git report of $HOME/.* (without . and ..)? (all user
> setting)
>
> Or better: provide a list of directory under $HOME I want to track
>
> Instead of providing the list of directory I want to ignore i would like
> to provide the list of the directory and files I want to track :)

You can probably do pretty much anything you want by twiddling with
options in .gitignore.  You should be able to add "don't ignore" names
by starting them with !, iirc.

Avery
