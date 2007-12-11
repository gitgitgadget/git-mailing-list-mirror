From: David <davvid@gmail.com>
Subject: [ANNOUNCE] ugit: a pyqt-based git gui // was: Re: If you would write git from scratch now, what would you change?
Date: Tue, 11 Dec 2007 05:48:32 -0800
Message-ID: <402731c90712110548k67f28b64w5afa93ee908ce73b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andy Parkins" <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 14:48:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J25Tm-0004sS-0M
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 14:48:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676AbXLKNsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 08:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752289AbXLKNsf
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 08:48:35 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:2020 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960AbXLKNse (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 08:48:34 -0500
Received: by ug-out-1314.google.com with SMTP id z38so268698ugc.16
        for <git@vger.kernel.org>; Tue, 11 Dec 2007 05:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=3Ey61FzPJ3ieVBFw3lEHMCzVBZsmKBffJhVNWbUxOpI=;
        b=dEMxEJJQK3ter+NdhQ7el/TMNIGZxj5xXmhkw5Aoo6eaj/eQgvhSwOX3fBfATcWMSD/vChfkV7ERcwZqyCU1dMAHjyBMYtwHZ9Z+qNYcG9mwdYx+B/BRiYheodlVZeDZnxIUWYlQqesOR5bHVIoPUyAWjd4VhgrzwV9GLf/k9fE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LDdoF5Q9mGFEHpw8wixkOSaxXorWUWVL0ixjloXd42inrLqM+wG+jMxUqdSI/oSgoy63FD4T5GeDu2rzoCa5QCkJDUBxL5MRRQeyIaMfNu38D5vfnngejmLQafO6nPXRXtlCYpaPU8+N6ATf3oYY9CiVFm2FtoyFr9DN8OHvTOs=
Received: by 10.66.221.5 with SMTP id t5mr939375ugg.83.1197380912182;
        Tue, 11 Dec 2007 05:48:32 -0800 (PST)
Received: by 10.67.118.1 with HTTP; Tue, 11 Dec 2007 05:48:32 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67854>

On Dec 4, 2007 3:00 AM, Andy Parkins <andyparkins@gmail.com> wrote:
>
> Qt puts a common face on threading, process control, networking, file
> systems, internationalisation, rendering, openGL, and of course the GUI
> itself.  Tcl/Tk (to take the most wicked example) gives you applications
> that are much harder to make run on Windows than on UNIX.
>
> Anyway, I don't want to sound like a strange Qt fan boy; the above is simply
> my justification for putting "git-gui in Qt" on my wish list.
>
> Andy
> --
> Dr Andy Parkins, M Eng (hons), MIET
> andyparkins@gmail.com

For whatever it's worth, I've written a PyQt4-based git gui.  For lack
of a better name I call it ugit, as in "I git, you git, we all git
with ugit" (or something silly like that).

Though there's still a few things remaining to be implemented, the
bulk of the initial groundwork is already done.  All you need to
build/run it is python and pyqt4 (pyuic4).  I've deliberately tried to
keep the interface similar to git-gui for now since it is obviously
based on it, but that's not a requirement.

Of course there are some notable things missing (such as proper i18n),
but it's not too bad for a first draft.

For more details (and the code) see:
http://repo.or.cz/w/ugit.git

Enjoy,
-- David A.
