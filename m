From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Gource - new GL Visualisation for git repositories
Date: Wed, 16 Sep 2009 15:02:50 +0200
Message-ID: <81b0412b0909160602i582aaf3dif15b7ad75a9880cf@mail.gmail.com>
References: <4AB0858E.6040805@vilain.net>
	 <3f4fd2640909160416n7c0ac92eo3f055d6c45f9c0a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sam Vilain <sam@vilain.net>, Git Mailing List <git@vger.kernel.org>
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 15:02:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mnu9y-0001cX-3j
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 15:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481AbZIPNCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 09:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752077AbZIPNCs
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 09:02:48 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:44687 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700AbZIPNCs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 09:02:48 -0400
Received: by bwz19 with SMTP id 19so3470554bwz.37
        for <git@vger.kernel.org>; Wed, 16 Sep 2009 06:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=Howkb4G3rNLG/achGelSq9qzKBaD6z6Ic1hH3iW6mK8=;
        b=FI4Mo1AaLW141fWCnGqmwVTqsnfqehCSivX4Tu7zqQ0/QmQSD9hi3JPTxZUHVRXMNW
         bJj6XEAzXrUHen0m0/1Btv/3hR1juxrADVbozqYAAok9XshnfTYE1F41sS8EXmRlJNmn
         twQ4pVfCqCKTssIb/cXk/Gr6QzShEbdH7exo0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=jpCqyjzx+uDmJ2LW2WIO//ILSCuEhlixTmviUbDQ0VAANYTwXR/Om0INTezmqwkV47
         YmR6mQJtJDZGQggEKjkRq0mSU7olxzvT3m7+THOKXbO/fzx7tjRVx0ICOzHWEmazt6MA
         GBMLdAq1YAnQgOLZMbMFYKYixDDJ8cJVdlctE=
Received: by 10.204.26.150 with SMTP id e22mr7399279bkc.166.1253106170408; 
	Wed, 16 Sep 2009 06:02:50 -0700 (PDT)
In-Reply-To: <3f4fd2640909160416n7c0ac92eo3f055d6c45f9c0a2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128651>

On Wed, Sep 16, 2009 at 13:16, Reece Dunn <msclrhd@googlemail.com> wrote:
> In addition to this, for large projects that span a long time (5 or
> more years), it would be nice to speed these up (possibly control the
> rate as a command-line parameter).

It has a little of that, try gource -h (I forgot the option name).
Not _much_ faster, though.
