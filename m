From: knittl <knittl89@googlemail.com>
Subject: Re: Mercurial over Git no success
Date: Mon, 14 Feb 2011 22:26:39 +0100
Message-ID: <AANLkTimWfC8UqYVNjr0MiE1QE+W0fVhZYi3wfxP1e29t@mail.gmail.com>
References: <1297717305.19327@davidwbrown.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: david@davidwbrown.name
X-From: git-owner@vger.kernel.org Mon Feb 14 22:27:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp5wp-0002O7-Fr
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 22:27:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753461Ab1BNV1B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 16:27:01 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35723 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844Ab1BNV1B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 16:27:01 -0500
Received: by pwj3 with SMTP id 3so1013563pwj.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 13:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=wJNr7rJdkX7Rfwn0QGLnrx7779U1VdZXO/qgRG4TQ6g=;
        b=VzcazAceF2qLWo35eBCyAwIVBB6pslu0DMBxo6t4+PXqG/EGQs7tEKrUk7j6wWF0bd
         BWn5eZeEc9DcxOxWc4YuD8wSrqhw+Lbgr15SrnA+6DTXzuAYZAK0zIJAB95Vog7NLki7
         0g1yyDRioRvYAtkTHZpTwNRF4Z/bHHu6T000M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=xT+hB6GexgAu3vy50zj7EPR0WB+IsUH1SAkAu63J7uD9A/6wK5J8naUJHzhOAGepnD
         WuhGqfFteJffW78EcUObf1xFs005ejJ4F/9aYK2zIlwV5NNy2PpEX4Dw72ROPBFybxEq
         tzq7KZso2t9/oIawJ9jreFEywA+B/EaSJe2fw=
Received: by 10.143.161.6 with SMTP id n6mr3590614wfo.151.1297718819864; Mon,
 14 Feb 2011 13:26:59 -0800 (PST)
Received: by 10.143.1.19 with HTTP; Mon, 14 Feb 2011 13:26:39 -0800 (PST)
In-Reply-To: <1297717305.19327@davidwbrown.name>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166772>

On Mon, Feb 14, 2011 at 10:01 PM,  <david@davidwbrown.name> wrote:
> [...]
>
> ./configure
> make
> make install
>
> Does not work for building Git on my local Ubuntu box (10.10 BTW). Some non-innocuous error condition as follows:

why not simply install the version of git that comes with ubuntu?
`sudo apt-get install git` should do the trick ...

> cannot find zlib.h

there's the problem. the zlib compression libraries are missing on
your system. you'd have to install them first: `sudo apt-get install
zlib1g-dev`, but you are probably missing some more libraries
necessary to compile git

hope that helps,
daniel


-- 
typed with http://neo-layout.org
myFtPhp -- visit http://myftphp.sf.net -- v. 0.4.7 released!
