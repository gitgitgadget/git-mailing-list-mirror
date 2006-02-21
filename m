From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Tue, 21 Feb 2006 18:30:08 +0100
Message-ID: <81b0412b0602210930w5c1a71aage12bad2079dd515a@mail.gmail.com>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20060220191011.GA18085@hand.yhbt.net>
	 <7vr75xbs8w.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Eric Wong" <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 21 18:30:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBbL5-0004bz-FW
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 18:30:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932760AbWBURaL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 12:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932762AbWBURaL
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 12:30:11 -0500
Received: from nproxy.gmail.com ([64.233.182.207]:13279 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932760AbWBURaK convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2006 12:30:10 -0500
Received: by nproxy.gmail.com with SMTP id y38so781985nfb
        for <git@vger.kernel.org>; Tue, 21 Feb 2006 09:30:08 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nJSQ8r6KqJOB817/5UECKdyx0lmW0Ef7um+5jlKtIMWYTfQ7uTF2qtFgi7vUq22RjwcattPGYJxr69AGj/fDu3pNZKlxONZU6lkI+Txl6Oih528qCHaGjt3ooyZxQ5yLF86ztjupsB+NgZZiB+fp3uXYyWc68DuOlL8tHoHZ8rA=
Received: by 10.49.60.11 with SMTP id n11mr1552791nfk;
        Tue, 21 Feb 2006 09:30:08 -0800 (PST)
Received: by 10.49.88.16 with HTTP; Tue, 21 Feb 2006 09:30:08 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vr75xbs8w.fsf_-_@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16534>

On 2/20/06, Junio C Hamano <junkio@cox.net> wrote:
>  * Eric, thanks for the hint.  I have this four-patch series.
>    Could people with perl 5.6 please check them?

Does not work here (ActiveState Build 811, Perl 5.8.6):

$ perl -e 'open(F, "-|")'
'-' is not recognized as an internal or external command,
operable program or batch file.
