From: demerphq <demerphq@gmail.com>
Subject: Re: [PATCH] git-cherry: make <upstream> parameter optional
Date: Tue, 30 Dec 2008 15:02:11 +0100
Message-ID: <9b18b3110812300602i3bed6ab0xc9fa7757bf7cf464@mail.gmail.com>
References: <200812291845.20500.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Tue Dec 30 15:03:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHfC4-0003fJ-JX
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 15:03:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950AbYL3OCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 09:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751921AbYL3OCN
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 09:02:13 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:53480 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbYL3OCM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 09:02:12 -0500
Received: by qw-out-2122.google.com with SMTP id 3so4157109qwe.37
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 06:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=k1e1uywpOKiGnacStwXrGcLIBOdGQX/6PL2A7uj7gV4=;
        b=fvr5vSeyNZufGIe6oq4HnT1+3aMU2i+luEs9QVSD/ibmhqycv77XGI3PjHZ0dF3Mob
         oEs2O2JPgymQazSEykkeDJ/5Q3vOrXKEWzW26TLa3PxlcPmd111Ie/0eQUZGgEQt/X6v
         84mSX76PHqcsQLgjUKmarDq+Ozn0KsNoHbZTU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=x5ePsYE38jCzzBbhJF/EubB5Y8eW7neCSMn8w2ubz5+m5IxQtAbVjZwU3X26g7L4EV
         1lUZcWL9HcBnqutp6rZK5360N4TxS53BTdpwv6mDhFdZBwI7F9UmXXzcLq6ko6RWM9Je
         BxRyLN+T62FGRI+hjOit8gX/eyMXordI1JFyg=
Received: by 10.214.217.1 with SMTP id p1mr12418083qag.36.1230645731116;
        Tue, 30 Dec 2008 06:02:11 -0800 (PST)
Received: by 10.214.217.13 with HTTP; Tue, 30 Dec 2008 06:02:11 -0800 (PST)
In-Reply-To: <200812291845.20500.markus.heidelberg@web.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104186>

2008/12/29 Markus Heidelberg <markus.heidelberg@web.de>:
> The upstream branch <upstream> now defaults to the first tracked
> remote branch, which is set by the configuration variables
> branch.<name>.remote and branch.<name>.merge of the current branch.
>
> Without such a remote branch, the command "git cherry [-v]" fails with
> usage output as before and an additional message.
>
> Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>

FWIW: I would find this useful. Thanks for writing it.

Yves

-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
