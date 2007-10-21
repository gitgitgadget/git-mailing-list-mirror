From: "Yin Ping" <pkufranky@gmail.com>
Subject: Re: [BUG] git-mv submodule failure
Date: Sun, 21 Oct 2007 13:48:41 +0800
Message-ID: <46dff0320710202248v56af5cb0gcf7dacb32848eca3@mail.gmail.com>
References: <46dff0320710192301p3e1d88d5l3b662b72b051d920@mail.gmail.com>
	 <Pine.LNX.4.64.0710202223590.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 21 07:48:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjTgE-000534-NE
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 07:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbXJUFsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2007 01:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbXJUFsm
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 01:48:42 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:24036 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922AbXJUFsm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2007 01:48:42 -0400
Received: by py-out-1112.google.com with SMTP id u77so1785900pyb
        for <git@vger.kernel.org>; Sat, 20 Oct 2007 22:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=WManZ3TcqBQNDpjKsUWrw2hztqFbSCNYkpEm0OP4xA0=;
        b=KJ1iXT1HZ4ax+y07ibf4/g3gvDOWgQUlZWV52Hik+g4+35j8BWIrUCG71Ea3VoKrQlBcNQULImVU4ACcyUPPlnLhcEGwiKiK+1EuMz0i1YSAGeIU2O07XCsGRJqLkqWJ04Ff5Lh+y1V9Ro1KEqRVCXwXXOy3kIrNqdRBeuPn29U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BJXcWkr8UQd9K43U55yxTDlu3vKjLdt+8Z4BV8dPEY0pfXpveZqk8cv99NOIu7InZchVY8mfejxsu/jLF1jG1Ru6AzqmWcC2qW96V5OaBlDmrhTSZ7bOPKO7XJyyTkYUWxbufqUfWmkz3oiha6eHeuwxJzLoa5rgwRlQwkZPocY=
Received: by 10.35.70.17 with SMTP id x17mr4345035pyk.1192945721367;
        Sat, 20 Oct 2007 22:48:41 -0700 (PDT)
Received: by 10.35.52.7 with HTTP; Sat, 20 Oct 2007 22:48:41 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0710202223590.25221@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61880>

>
> But of course .gitmodules is unaffected.  But it should be changed, too.
>

IMHO, changing .gitmodules is what the 'git-submodule mv' should do,
and 'git-mv' should only rename the module directory

> Ciao,
> Dscho
>
>


-- 
franky
