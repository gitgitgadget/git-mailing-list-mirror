From: "Jay Soffian" <jaysoffian+git@gmail.com>
Subject: Re: [PATCH] Improve git-help--browse browser support under OS X
Date: Sat, 9 Feb 2008 21:15:30 -0500
Message-ID: <76718490802091815s45c19113t938f5257aad3f46c@mail.gmail.com>
References: <1202505794-13409-1-git-send-email-jaysoffian+git@gmail.com>
	 <20080209202020.GD30368@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 03:16:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO1jk-0000Ke-0s
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 03:16:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754536AbYBJCPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 21:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754361AbYBJCPd
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 21:15:33 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:1037 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753607AbYBJCPb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 21:15:31 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1329631wah.23
        for <git@vger.kernel.org>; Sat, 09 Feb 2008 18:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=sxqzG7LDh5LsIDA2SlHxpKAGmWjtMnuyZjCcRepfzn0=;
        b=aFKOMSWd+6SZ8gvCpyhAul32PhPo+mnKntWe3gqGC2Bz8NVU45YRypA+dKC7tYciczQToAVYvTFOd+sFOO/EOcCdxd84+0WHEkYGusFYA+g3X99g1QJohAuCOZeq6M5dXrVxyRrFHurValGe1NEp33/sMabUj0CPmi4/xSfiq58=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=n/7sPQtUQc+mmCIkvupO82x0I3Qvs1Z6YoUhR4ccpaJGEDq2hIf+ENhbFtz5Ae6V39iJMtC4lVaTltUqI+nCgVqX5ajuu49xsPtvzF7ZPeRoLylenmAJgX/c9/4GgaLtcrsC5EtPn1n484fhAKhvpOtfi10GxMevUoxT2WTLT9k=
Received: by 10.114.171.1 with SMTP id t1mr8818000wae.83.1202609730939;
        Sat, 09 Feb 2008 18:15:30 -0800 (PST)
Received: by 10.114.255.11 with HTTP; Sat, 9 Feb 2008 18:15:30 -0800 (PST)
In-Reply-To: <20080209202020.GD30368@dpotapov.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: e11fd31cc6ddf36b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73292>

On Feb 9, 2008 3:20 PM, Dmitry Potapov <dpotapov@gmail.com> wrote:
> On Fri, Feb 08, 2008 at 04:23:14PM -0500, jaysoffian+git@gmail.com wrote:
> > /usr/bin/open <document> is used under OS X to open a document just as if the
> > user had double-clicked on the file's icon. In other words, this will open HTML
> > files with the user's default browser. Note however that whether the document
> > opens in a new window, or in a new tab depends upon the browser configuration.
>
> This is OS X specific, so the change should be made in such a way that it
> will not affect anyone else. Because people on other platforms may have
> "open" to do different things. For example, on Linux, the "open" command
> is used to open a new virtual terminal. At the same time, other systems
> may have their own ways to start the default browser. For instance, on
> Debian based systems, it is usually x-www-browser for X and www-browser
> for terminal.

I guess I'm confused by the criticism as I thought that's what I did.
"open" is only added to the list of browsers to try if the
SECURITYSESSIONID environment variable is set (indicating an OS X GUI
login environment). I don't see how the change I made could adversely
impact the users of other systems.

j.
