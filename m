From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: [tig PATCH] Predefined external command: git commit
Date: Sat, 21 Feb 2009 18:51:12 +0100
Message-ID: <2c6b72b30902210951m619c7cf9qa505883f43128e44@mail.gmail.com>
References: <1235176121-17483-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <2c6b72b30902210819q43cbf184x77d7587a6aa1630a@mail.gmail.com>
	 <cb7bb73a0902210919n45ffb74fp6d4fa0dc9cb7ac1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 21 18:52:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Law1s-0000rQ-QE
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 18:52:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753587AbZBURvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 12:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753579AbZBURvP
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 12:51:15 -0500
Received: from fk-out-0910.google.com ([209.85.128.187]:5098 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753368AbZBURvO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 12:51:14 -0500
Received: by fk-out-0910.google.com with SMTP id f33so1186796fkf.5
        for <git@vger.kernel.org>; Sat, 21 Feb 2009 09:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/VEQbO1guFHE9yvxXoSqEnUW+vINMxVWL9tPqFKQYq0=;
        b=WqF9Ci3oN0tYW5Qh5rZvst62TD/61gnCjJEG/+Qflvtyh5c/XJm6Gtz+fo2b4ciM2V
         PLD4dNHapqTaut2qdDa04+N+5UOcGYD4AsmdJMQ2ewwhBhGh4wnR39cHAzwtUxGi3uMq
         U6CZHinrcdoJfmqJIqTx8Iun6hrnOLhie2dk0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ErpGRcD/ntQrqYOB3ZSg5OrvkJnp8s4wPgcBBFrkuwMng8S0bRgLkuNbHXjYeie0vs
         pwX7GRaZNnQrOuQoMgqVhzYzYsM+v6M9Udn+Zio0K+6OeY6HhsTny26q9OXlyF3M9Duk
         3O42v7wHB6C0eU6OyKdCd+wJ5fyGdBqjTVBRQ=
Received: by 10.181.58.9 with SMTP id l9mr773347bkk.98.1235238672708; Sat, 21 
	Feb 2009 09:51:12 -0800 (PST)
In-Reply-To: <cb7bb73a0902210919n45ffb74fp6d4fa0dc9cb7ac1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110971>

On Sat, Feb 21, 2009 at 18:19, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:
> Thank you for this excellent piece of software. I have some more minor
> patches up at git://git.oblomov.eu/tig (gitweb at same address with
> http) which I'm going to submit soon.

Don't bother sending the `tig log` patch. ;)

I deprecated this subcommand a long time ago, and would prefer if it
wasn't added again. Having a lot of subcommands makes it more likely
that doing `tig $BRANCH` will not do the expected thing. Also, I don't
find it particularly useful myself and might actually remove it in the
future, if I ever get to implementing support for defining "custom
views".

> I honestly wish I could contribute with some more important feature
> such as bundle support or automatic color inversion on light
> backgrounds.

/me too. :)

-- 
Jonas Fonseca
