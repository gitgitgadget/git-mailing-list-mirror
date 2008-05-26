From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH] hg-to-git: add --verbose option
Date: Tue, 27 May 2008 07:29:40 +1000
Message-ID: <ee77f5c20805261429h14b1ce66tf9585132279c4f8e@mail.gmail.com>
References: <alpine.DEB.1.00.0805261344420.30431@racer>
	 <200805261509.49841.johan@herland.net>
	 <alpine.DEB.1.00.0805261414140.30431@racer>
	 <bd6139dc0805260628l1b073f52i1f33bd0c707a4329@mail.gmail.com>
	 <7vlk1xc7aa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: sverre@rabbelier.nl,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Johan Herland" <johan@herland.net>, git@vger.kernel.org,
	"Stelian Pop" <stelian@popies.net>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 26 23:30:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0kH6-0006dD-8S
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 23:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754454AbYEZV3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 17:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754394AbYEZV3p
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 17:29:45 -0400
Received: from ik-out-1112.google.com ([66.249.90.179]:16775 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754283AbYEZV3o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 17:29:44 -0400
Received: by ik-out-1112.google.com with SMTP id c28so1039887ika.5
        for <git@vger.kernel.org>; Mon, 26 May 2008 14:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Wr9lVBQB/25JUolSJ6bGKJ6Y/gnhGN+WWiOxcuOuhZM=;
        b=pJ6w+uTgYXe78y4kQG3xYhDFI+yH+0ryP/cgeBcUzQr5SVz2+tJ6m8nf/e/kG0nbldNHbRg3510+5+S1JOyFMu9gKIF0OhhX8iDpwtY4MiuEVbJoCOBEFVBgjPdNKN3Bg+qCvI+QfGQ49n5G2hX9LWjBanDKScIM2fvpBcprXUI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fICt7e2jEf9vByVZzyAdbKDB1qVHB3NthQvzDA0++beZiaguFZYM2V+Yv21Lwmy/0C+/QdWT/pp4K3Ay75o7hV9H6mMUuPjFcBe9nbCzi3LUshspcyq/HvHqPQjdMAnZNTw2d68kFdC8UPJjEB30jz88nn3hZgYPgWiMO9n2QQE=
Received: by 10.86.51.2 with SMTP id y2mr5538788fgy.34.1211837380411;
        Mon, 26 May 2008 14:29:40 -0700 (PDT)
Received: by 10.86.36.17 with HTTP; Mon, 26 May 2008 14:29:40 -0700 (PDT)
In-Reply-To: <7vlk1xc7aa.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82957>

On Tue, May 27, 2008 at 3:19 AM, Junio C Hamano <gitster@pobox.com> wrote:

> I think I spotted a bug in Python documentation, by the way ;-)
>
> http://docs.python.org/ref/ref.html does not even list "True" and "False"
> in its section 2.4 (Literals) yet, and that document is for version 2.5.2.

That's because they aren't literals. They are, in fact, objects, and
redefinable objects at that.

Try:

True=False
print True



Dave.
