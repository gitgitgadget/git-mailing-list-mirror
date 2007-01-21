From: "Josh Boyer" <jwboyer@gmail.com>
Subject: Re: make rpm
Date: Sun, 21 Jan 2007 17:48:48 -0600
Message-ID: <625fc13d0701211548j5f41d4eck49db2726e9c194c2@mail.gmail.com>
References: <Pine.LNX.4.64.0701211325250.3011@xanadu.home>
	 <ep0c9d$tph$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 00:49:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8mQo-0004ya-3d
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 00:49:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbXAUXsv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 18:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbXAUXsv
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 18:48:51 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:36104 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791AbXAUXsu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 18:48:50 -0500
Received: by ug-out-1314.google.com with SMTP id 44so911709uga
        for <git@vger.kernel.org>; Sun, 21 Jan 2007 15:48:49 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Im4zAvRUzZz9v4a41/6Pp8EsQQNgTM8pBwMvcxjIGWwMpJTIbrppy0MfCtmJ9K+CLD5Zu2fOuGR8kiiswerXbShOhUwH/BeVYvryBYD2uDyEj5myjcKAjrOJiCmtKsZkftCknyQHgkXzmX5DRhg2X5/QZKH1m9duaWQNN/Sc+PY=
Received: by 10.82.138.6 with SMTP id l6mr3731598bud.1169423328193;
        Sun, 21 Jan 2007 15:48:48 -0800 (PST)
Received: by 10.82.114.10 with HTTP; Sun, 21 Jan 2007 15:48:48 -0800 (PST)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <ep0c9d$tph$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37365>

On 1/21/07, Jakub Narebski <jnareb@gmail.com> wrote:
> [Cc: git@vger.kernel.org]
>
> Nicolas Pitre wrote:
>
> > I just tried 'make rpm' and it died with:
> >
> > |rpmbuild -ta git-1.5.0.rc2.tar.gz
> > |error: Failed build dependencies:
> > |        perl(Error) is needed by git-1.5.0.rc2-1.i386
> >
> > Of course I have perl installed.  But what is that "perl(Error)" about?
>
> You don't have Error.pm perl module (in perl-Error package in Fedora Core).
> Git distributes it's own copy, but I guess rpm target requires to have it
> installed rather than provide it ourself.

If you really have your own copy, you can use Provides: perl(Error) or
something similar.

josh
