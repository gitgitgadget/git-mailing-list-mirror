From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: git-gui and gitk-git as submodules (Re: [RFC PATCH 0/2] Teach 
	"git status" the "--ignore-submodules" option)
Date: Sat, 26 Jun 2010 12:44:13 +0800
Message-ID: <AANLkTimqXhGw5fAAgZsoDAI9s6kaIzcka9mbFEW8j05v@mail.gmail.com>
References: <4C24C34B.20403@web.de>
	<7vlja3j7hu.fsf@alter.siamese.dyndns.org>
	<20100625190147.GA17493@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andy Parkins <andyparkins@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 26 06:46:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSNHY-0002uH-7z
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 06:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093Ab0FZEoR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jun 2010 00:44:17 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59865 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983Ab0FZEoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 00:44:16 -0400
Received: by iwn41 with SMTP id 41so2667752iwn.19
        for <git@vger.kernel.org>; Fri, 25 Jun 2010 21:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=oM1DeESt/ubQFDD5qigFgFxtF0wqALtHRCs+yerHzow=;
        b=ta5pKCuZG87vaDJ4imTC98k/4Gnn3J/SCytUHqZxhhG7AemhZc+UjblWn5dsJOvjR8
         FPEr6flC5pzO5FdARRWVNIryRi4FTHlcYE4cyjZbEDfNEFF5P6WbOllqcrrI47uiep+i
         f5qD0/0slGtYtPVARjFYJ2YyBuuvPYJaepk00=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=goA1nUTehbOeX1RRFUDNoxW5oJcxEXYwaUlBF9XEJnkgLRIlCgzbQY4l6AbhCLkhVi
         q07mJABYJEARYFb6nf9eIMtDKlbdYokbSjoRVvAlOWoY4QdVmjc7tUNednyxAWf380Hb
         dRpw79p/V6zJiFYNEa+yhp1AnEKQq4I0wpT6Q=
Received: by 10.231.156.66 with SMTP id v2mr1791063ibw.107.1277527453717; Fri, 
	25 Jun 2010 21:44:13 -0700 (PDT)
Received: by 10.231.17.193 with HTTP; Fri, 25 Jun 2010 21:44:13 -0700 (PDT)
In-Reply-To: <20100625190147.GA17493@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149725>

Hi,

On Sat, Jun 26, 2010 at 3:01 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Given a patch to automatically resolve submodule-ejection/subtree-merge
> conflicts, do you think a patch series to split off gitk and git-gui
> as submodules could live in pu eventually?

+1

They do sound like they'd fit into the submodule paradigm. Further,
having git use it would be a good showcase of the submodule feature -
or bug. :)

-- 
Cheers,
Ray Chuan
