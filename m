From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH] --color-words: Make the word characters configurable
Date: Sat, 3 May 2008 22:13:12 +0800
Message-ID: <46dff0320805030713r673ea479u37018333c32131bb@mail.gmail.com>
References: <46dff0320805012128l6cb15e1ekd40f84a9eac724d1@mail.gmail.com>
	 <1209736766-8029-1-git-send-email-pkufranky@gmail.com>
	 <alpine.DEB.1.00.0805031501290.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 03 16:14:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsIV1-00039z-3R
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 16:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753521AbYECONO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 10:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753252AbYECONO
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 10:13:14 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:22735 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723AbYECONN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 10:13:13 -0400
Received: by an-out-0708.google.com with SMTP id d40so401373and.103
        for <git@vger.kernel.org>; Sat, 03 May 2008 07:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=TGKJv0mLCDmcny3E/OyBMgFPfdk2amrnny93AflrQ/I=;
        b=IicBlb7AVF1auAq99XkafLxwlYkLmAcPN9hA7rh5IdNMzk8crXGIcP1pxJuWSGelXJTgGJ+9+ivvyf6HpWsOZUnm5A21lFc3z2IqJWb3Mxmz+y5Gl8IFkW25saK9WZKswC2gVSh2JWc/d0XbYq28DWQDvQsEbpjFw0P10hwcRt4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=xvqhg/7ab4ubQ7DKvN0SgHStg4EmttF0U+ShsLtHGYF920jSaUOk/mxhUi8JujuGhXdH1W4dlILDEDYyutyRmu+HbDfCfLDYFNaLQGydzhsxbwc++lfSDLbzB4NBAFjMIIallGqLo9m7JzK6hOZSnRTsSAE5E/zjtFpatTP0wUs=
Received: by 10.100.251.5 with SMTP id y5mr5894985anh.126.1209823992875;
        Sat, 03 May 2008 07:13:12 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Sat, 3 May 2008 07:13:12 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0805031501290.30431@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81092>

On Sat, May 3, 2008 at 10:03 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
>  Now, you can specify which characters are to be interpreted as word
>  characters with "--color-words=A-Za-z", or by setting the config variable
>  diff.wordCharacters.
>
>  Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>  ---
>
>         I would have preferred an approach like this.
>
>   Documentation/config.txt       |    6 ++++
>   Documentation/diff-options.txt |    8 ++++-
>   README                         |    2 +-
>   diff.c                         |   64 +++++++++++++++++++++++++++++++++++++++-
>   4 files changed, 77 insertions(+), 3 deletions(-)
>
>  diff --git a/Documentation/config.txt b/Documentation/config.txt
>  index 05bf2df..663d82b 100644
>  --- a/Documentation/config.txt
>  +++ b/Documentation/config.txt
>  @@ -546,6 +546,12 @@ diff.renames::
>         will enable basic rename detection.  If set to "copies" or
>         "copy", it will detect copies, as well.
>
>  +diff.wordcharacters::
>  +       This config setting overrides which characters are interpreted as
>  +       word characters by the --color-words option of linkgit:git-diff[1].

I think a-zA-Z0-9_  should always be word characters. We can't
override them, instead, we just extend them.

>
>  -"git" can mean anything, depending on your mood.
>  +"git" cann mean anything, depending on your mood.

Why replacing can as cann?


-- 
Ping Yin
