From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [RFD] gitweb configuration
Date: Sun, 18 Jun 2006 19:42:48 +1200
Message-ID: <46a038f90606180042w7b4d11dbvbea28b750ddbc6e2@mail.gmail.com>
References: <e720r0$qdv$1@sea.gmane.org> <20060617232358.GK2609@pasky.or.cz>
	 <e72j53$1m1$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 18 09:43:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Frrvp-0002Mz-KB
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 09:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWFRHmu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 03:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWFRHmu
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 03:42:50 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:903 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932123AbWFRHmt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jun 2006 03:42:49 -0400
Received: by ug-out-1314.google.com with SMTP id a2so1410760ugf
        for <git@vger.kernel.org>; Sun, 18 Jun 2006 00:42:48 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L6uQmr23RN21z39nhumf4Naq1dcexjtSN660Z5yXUvEBB39c+OUFDBKinkM9w7bz9+TnTOJAlNqevpeaSC7UrdwA7OszSdaSE9tk+GLN7npHqXSh7rZGZfXxTVEqBqroKQlJFEkE1glqYe51Z4yuUYLoaO9rJgqSc5JWe0d5rLw=
Received: by 10.78.67.20 with SMTP id p20mr1563697hua;
        Sun, 18 Jun 2006 00:42:48 -0700 (PDT)
Received: by 10.78.128.15 with HTTP; Sun, 18 Jun 2006 00:42:48 -0700 (PDT)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <e72j53$1m1$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22053>

On 6/18/06, Jakub Narebski <jnareb@gmail.com> wrote:
> So GIT_CONFIG would be ~/.gitconfig, and GIT_CONFIG_LOCAL would be
> $GIT_DIR/config or what?

I don't quite follow why gitweb needs a GIT_CONFIG_LOCAL defined.
Given that it works in a CGI environment, it should read
$GIT_DIR/config by default, and $GIT_CONFIG if set (from httpd.conf).

cheers,


martin
