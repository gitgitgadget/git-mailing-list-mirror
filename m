From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 2/4] git-gui: add smart case search mode in searchbar
Date: Mon, 17 Oct 2011 07:32:29 +0200
Message-ID: <CAKPyHN2XQYrGDhfjX4G12Ggw6DuJasuYbLQvfbmikBbMezp4=g@mail.gmail.com>
References: <94b050c4cf7ae8df8d79112e13613244ebff4037.1318579823.git.bert.wesarg@googlemail.com>
	<9350c86dc58e6345b237de5af186718d97fdd19b.1318579823.git.bert.wesarg@googlemail.com>
	<CAH5451=jUS5PpMddwML36F-mH=pxxh8FsP2ZiRH2_NFBBy+Q5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 07:32:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFfoR-0006tz-F5
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 07:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753641Ab1JQFca (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 01:32:30 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:63651 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087Ab1JQFca (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 01:32:30 -0400
Received: by vws1 with SMTP id 1so2241089vws.19
        for <git@vger.kernel.org>; Sun, 16 Oct 2011 22:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Uyr5pbkvsulm3KfT1No+E0Hluarbo982qN1rnQ9MHBc=;
        b=jHUWgY8fJS/ba29oF9cP1nEmCXJaf/nuA6Ks2BIEhAdYXa7uylZmDHfryvFgivmG+G
         L35Frz8drcZuU4nFmQncKClDkpDkIFXlFclLsclqudIHfHQ1ZTRtU7tcXhQR9pneIlbh
         ST7gcQethdFoP69duoOZIkUOEev4GNPMO8/D8=
Received: by 10.52.92.212 with SMTP id co20mr18595478vdb.119.1318829549243;
 Sun, 16 Oct 2011 22:32:29 -0700 (PDT)
Received: by 10.52.186.36 with HTTP; Sun, 16 Oct 2011 22:32:29 -0700 (PDT)
In-Reply-To: <CAH5451=jUS5PpMddwML36F-mH=pxxh8FsP2ZiRH2_NFBBy+Q5g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183766>

On Mon, Oct 17, 2011 at 00:32, Andrew Ardill <andrew.ardill@gmail.com> wrote:
> I don't really know tcl so I'm not certain, but it looks like you
> never reset the case sensitive flag once it has been set by entering
> an upper case letter. If I accidentally enter an upper case letter and
> have set smartcase true, I would expect that deleting that character
> would turn case sensitivity off again.
>

I never reset it, because your case is a way to search case-sensitive
for an expression in all lower-case. For example, if you would like to
search for 'git' case-sensitively, you would type: 'gitA^H'. A direct
shortcut to toggle the case flag could also be of use. The other idea
which come to mind, is to reset the case flag, if you clear the input
field. I.e. type 'G^Hgit' would still seach case-insensitive.

Bert

> Regards,
>
> Andrew Ardill
>
