From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Making perl scripts include the correct Git.pm
Date: Tue, 4 Jul 2006 21:01:53 +0200
Message-ID: <e5bfff550607041201q21d42fb5r49206540634354a6@mail.gmail.com>
References: <20060702214012.GI29115@pasky.or.cz>
	 <7v64if1rop.fsf@assigned-by-dhcp.cox.net>
	 <7vwtavxyas.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 21:02:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fxq9l-0001UT-Ny
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 21:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbWGDTBz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 15:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbWGDTBy
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 15:01:54 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:61999 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932337AbWGDTBy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jul 2006 15:01:54 -0400
Received: by py-out-1112.google.com with SMTP id t32so1941857pyc
        for <git@vger.kernel.org>; Tue, 04 Jul 2006 12:01:53 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=onyU2KlSkBKVLwiMauCRT/UeklKd/+frUJMQqXS6RcxebSwRYJLLzq3wTWj9/T5BJxwE8DRcqFbLPGZ/U3Nmi/swrrGbLvxK5wzKZEaR9jIfpLDtux8pN9wN+4bZezzT4HAF5+MVgAZQ6cSbJ0aPEKmTXfgKVdG0Cu6YiSSdWXQ=
Received: by 10.35.20.14 with SMTP id x14mr4337027pyi;
        Tue, 04 Jul 2006 12:01:53 -0700 (PDT)
Received: by 10.35.52.17 with HTTP; Tue, 4 Jul 2006 12:01:53 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vwtavxyas.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23307>

On 7/3/06, Junio C Hamano <junkio@cox.net> wrote:
> Junio C Hamano <junkio@cox.net> writes:
>
> On the other front, I applied the --remove-empty --parents fix
> by Linus to "master".  Since this broke gitk and qgit it might
> warrant a 1.4.1.1 hotfix.
>

Well on the qgit side the bug is plus or less harmless, you see some
spurious revisions in file annotation history and a warning message on
stderr, but not a show stopper.

    Marco
