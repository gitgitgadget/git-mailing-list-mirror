From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Tue, 22 Jan 2008 10:43:16 +1300
Message-ID: <46a038f90801211343q4a36195dp319beb3020e57600@mail.gmail.com>
References: <478E1FED.5010801@web.de>
	 <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se>
	 <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org>
	 <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org>
	 <C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org>
	 <373E260A-6786-4932-956A-68706AA7C469@sb.org>
	 <alpine.LFD.1.00.0801211210270.2957@woody.linux-foundation.org>
	 <7EB98659-4036-45DA-BD50-42CB23ED517A@sb.org>
	 <46a038f90801211317v4902ffd3ic8ccc35f8df72bd9@mail.gmail.com>
	 <E46A8ED2-7E95-41CF-A5A7-2CB9BC18F95D@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Peter Karlsson" <peter@softwolves.pp.se>,
	"Mark Junker" <mjscod@web.de>,
	"Pedro Melo" <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Kevin Ballard" <kevin@sb.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 22:44:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH4Qq-0008AY-MJ
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 22:43:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753688AbYAUVnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 16:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753887AbYAUVnT
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 16:43:19 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:30520 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753677AbYAUVnS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 16:43:18 -0500
Received: by ug-out-1314.google.com with SMTP id z38so959602ugc.16
        for <git@vger.kernel.org>; Mon, 21 Jan 2008 13:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=c1ZdFyZWqK3oajV5diieKTY2rDN4a2naLzuQNkbFYKk=;
        b=ZslkOmiXs+mMfGnltmOOQ1ZT6ehyhF8ib+ScBnR7TdVD7l85+dkJSVDEwVGuokL9GRFBgHxLkkB7rt/23Ox4SeVYYxm4hCWG1xtoevZ8Fk/Ub+NmZ0H2ZlOC3/YLs5h52iNh7hJjL3gDNueL3lmRG82EsbGyBz0fTU2c4IlVrpA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pvfsgCWpLXaPdpguHK/LMDZVsrqr06ZtdldXKE09oT2bLiadKLcZ0qAC1/fhofDo+4dMbLVLdP/cY2Pgd/x7Cxs6h0/iaN8ZC2xuPqsIsJOLKlQZxRT1mkxLSSQi+VgyecIrYNYSrVhyi8AoNGyK+X603tHPB3t40Bv9ccZvavM=
Received: by 10.66.252.18 with SMTP id z18mr5250029ugh.37.1200951796678;
        Mon, 21 Jan 2008 13:43:16 -0800 (PST)
Received: by 10.66.252.2 with HTTP; Mon, 21 Jan 2008 13:43:16 -0800 (PST)
In-Reply-To: <E46A8ED2-7E95-41CF-A5A7-2CB9BC18F95D@sb.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71350>

On Jan 22, 2008 10:28 AM, Kevin Ballard <kevin@sb.org> wrote:
> That's certainly a reasonable POV. However, it's not the only one. As
> evidenced by the Mac, treating filenames as strings rather than bytes
> is a viable alternative POV - you can't argue that it doesn't work,
> because OS X proves it does.

With its own slew of bugs. See Ted's reply earlier for a mouthful of
woe in HFS+ that is not easy to workaround.

> Perhaps you should try OS X. Every single Cocoa app should do the

OSX has given me enough grief with other filesystem and general OS
problems that I have definitely abandoned it after 2 years trying to
use it part-time. It has been back to linux for me ;-)

cheers,



martin
