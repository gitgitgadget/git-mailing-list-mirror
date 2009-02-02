From: Rostislav Svoboda <rostislav.svoboda@gmail.com>
Subject: Re: cvs2git migration - cloning CVS repository
Date: Mon, 2 Feb 2009 17:05:21 +0100
Message-ID: <286817520902020805o1f1f6abet7b14f47d63c28d77@mail.gmail.com>
References: <286817520902020624y7f4c2942l34fafc0fe0fa0b48@mail.gmail.com>
	 <9a0027270902020707p4305d92fl1388bbfeb8a0864b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Syzdek <syzdek@gmail.com>, smurf@smurf.noris.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 02 17:07:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LU1KE-0001JL-Kw
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 17:07:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884AbZBBQF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 11:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752808AbZBBQF0
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 11:05:26 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:51914 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816AbZBBQFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 11:05:25 -0500
Received: by ewy14 with SMTP id 14so1926751ewy.13
        for <git@vger.kernel.org>; Mon, 02 Feb 2009 08:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=W/bYhYY9wMV6pv0Zrq/pTW6pfrwJrw0kW/NNjIlZIfo=;
        b=DZalvnGkvscLW7iwQ09JMrft2QUy1M0mzWMEda+pnKeBEViU9I5T48gvYvRE/drAWr
         SK+OizZbXuO+dSNx7hRuIOlmCDGLZLUZBznVZnK1mgloj8sIG5Pi4TJZb8fYY7aCBe88
         C/9y+0cQlTyjDYQ11xTz2gkp4cJiNI+8EiAvc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ocE5MVdNEEqGKNBjrFg93g99DL/7kJxotnZu9CTB8KRpLprOJ/H1TFhLilC48uEcTW
         Xm9SiQNYTu124vsPKQZBWYwJu5iM2tLfbmJnnJEm9qIaYlD0awVFC6D6neGGErnmgunY
         eZ3WdNXhdF0YirNk6cRhXR9iasguNcz6TxWgE=
Received: by 10.210.68.17 with SMTP id q17mr4971660eba.50.1233590721826; Mon, 
	02 Feb 2009 08:05:21 -0800 (PST)
In-Reply-To: <9a0027270902020707p4305d92fl1388bbfeb8a0864b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108097>

2009/2/2 David Syzdek <syzdek@gmail.com>:
> Rostislav,
> I ran into this issue when I  tried to import my CVS repository into Git.
>  Be sure to issue a CVS login before attempting the import:
>
> cvs -d :pserver:mylogin@cvs-server:/cvs/cvsrepository login

Yea! that's it! THX!
IMHO it won't be bad to have it somewhere in the git-cvsimport and/or
gitcvs-migration
documentation (short notice would be enough) even if the 'AuthReply: I
HATE YOU'
comes out of git. It would save me more than a couple of hours if it
were there...

Bost
