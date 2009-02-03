From: Stefan Karpinski <stefan.karpinski@gmail.com>
Subject: Re: git gtk+/GNOME gui application: gitg
Date: Tue, 3 Feb 2009 11:43:10 -0800
Message-ID: <d4bc1a2a0902031143u2f4beadek507910fe3a6052f@mail.gmail.com>
References: <1233432317.26364.5.camel@wren>
	 <498877A7.3050308@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jesse van den Kieboom <jesse@icecrew.nl>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Feb 03 20:44:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LURCP-0007sO-Kr
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 20:44:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752463AbZBCTnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 14:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752334AbZBCTnM
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 14:43:12 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:49840 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133AbZBCTnL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 14:43:11 -0500
Received: by wa-out-1112.google.com with SMTP id v33so1052067wah.21
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 11:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vDIfp0mqSQQ7pb8SOad8aZ1wFpmm3Khq+lDgjdjQqlE=;
        b=GQMEPerm8xXYfmVaOS8PbY7ZBlGOowarmpkt7kPfN3VUm6lsxjTq/IU+387d1FwpIA
         4OIUGtPKJPHu6VOcEMdVlGfn57SdyjgUy8Ae7bbpZL2tCQwqeEm/tb6ugEuKoC4/hjHw
         9Qu/Fb6zZtP4QfHWDRnLy++rgOZfsDQwDrCKc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZYMicyXzV0dYxA2kmupcjFHBt9XBORRAS6hWEDPWt4+i9oCotSpGXe0VyejYFHKHA3
         OPkVhsYfVIz6KK6ZKiWTPFzfezlBpE7s03d/f/8E5Q6Nn5FMx+5hRI4V3S1Jhu+AZZvm
         XQSYgwSCSlIzOp5tIpZ1tVQrIhUznjSjqnb8k=
Received: by 10.115.111.3 with SMTP id o3mr2738015wam.210.1233690190310; Tue, 
	03 Feb 2009 11:43:10 -0800 (PST)
In-Reply-To: <498877A7.3050308@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108246>

On Tue, Feb 3, 2009 at 8:58 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
>
> Not yet another one, please!
>
> I'm sorry, but that was my first thought. I lost count of how many
> half-finished GUIs we have, using tcl/tk, gtk, qt, you-name-it-tk. I
> still don't see any which provide a consistent, "modern", stable GUI for
> viewing *and* committing, i.e. a replacement for gitk and git-gui.
>
> The latter two still seem to be the most feature rich choices, but they
> suffer somewhat from their implementation language. Just look at the git
> survey and you know why nobody wants to work on them.

For what it's worth, GitX (OS X only) does both history viewing and
committing, and seems to be rapidly approaching the feature set of
gitk and git-gui combined. Unfortunately, I seem to inevitably hate
cross-platform GUI's---they never feel right or work slickly enough.
Sad, but true.

If GitX and this newer project could share a lot of code base, then
maybe their co-development would be accelerated and both would end up
being slick, native, full-fledged GUIs for git.
