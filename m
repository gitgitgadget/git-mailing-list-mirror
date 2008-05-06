From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [PATCH] "not uptodate" changed to "has local changes"
Date: Tue, 6 May 2008 14:31:59 +0100
Message-ID: <e2b179460805060631l506e2a6leaafc9c0acf3b05b@mail.gmail.com>
References: <1209833972-12256-1-git-send-email-timcharper@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Tim Harper" <timcharper@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 15:33:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtNHm-0003bl-HH
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 15:32:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754506AbYEFNcB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 09:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754412AbYEFNcA
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 09:32:00 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:12685 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754385AbYEFNcA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 09:32:00 -0400
Received: by rv-out-0506.google.com with SMTP id l9so1682636rvb.1
        for <git@vger.kernel.org>; Tue, 06 May 2008 06:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=CNoeAMP3TsUr14IRJDrFEw70iDsh+j2zaTuomLBjqvM=;
        b=IqXO13Drz5Mab63x/zhm1QZqB3eXyv4sjkqKmQ2d3zkDMa7YkA5b0zRkYEZTD7vjur1l3RBKDStzmpPArkaQLU6cdn+HS65aevJIXPfqhVXI05+4NKoKlKBJwS71JUMk114t+CqDUVj7H+7TvwetOSqkKpDRMNrVYaTw6ssVbvw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dxc32STCoWPKZKpLX1M84M1XYswNCFyTGyQeOKs1kfAwPPym0lk27wIlYLxwHhfc7PK1zhHtQLYCKyTgBX/iCsefUcRGHdFlEH+v/PCxmyMu3/ZSUG6GX/ovEejR56//oujI+zVkQmwR42Tuu3eIdog8ak5ILXp250/KeaXQWZM=
Received: by 10.141.141.3 with SMTP id t3mr354396rvn.52.1210080719713;
        Tue, 06 May 2008 06:31:59 -0700 (PDT)
Received: by 10.140.142.5 with HTTP; Tue, 6 May 2008 06:31:59 -0700 (PDT)
In-Reply-To: <1209833972-12256-1-git-send-email-timcharper@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81360>

2008/5/3 Tim Harper <timcharper@gmail.com>:
> When doing a merge, the message says "file.txt: needs update", or "file.txt: not uptodate, cannot merge".   While internally 'uptodate' makes sense, from the outside it's a mystery.
>
>  This patch will make git a little more human friendly, reporting "file.txt: has local changes".

Documentation/git-checkout.txt should also change in this case,
otherwise users will see different output to that described and
possibly get confused if following along with the examples.

Mike
