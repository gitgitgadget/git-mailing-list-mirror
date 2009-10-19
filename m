From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: denying branch creation in a shared repository
Date: Mon, 19 Oct 2009 14:13:21 +0530
Message-ID: <2e24e5b90910190143j5579d9dfle15df8625eb20a00@mail.gmail.com>
References: <ee22b09e0910190132u20931fb4i6a98fb87582a9e56@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Mohit Aron <mohit.aron@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 10:43:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mznpw-00051L-23
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 10:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291AbZJSInS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 04:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752674AbZJSInS
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 04:43:18 -0400
Received: from mail-iw0-f178.google.com ([209.85.223.178]:49763 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821AbZJSInR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 04:43:17 -0400
Received: by iwn8 with SMTP id 8so2151867iwn.33
        for <git@vger.kernel.org>; Mon, 19 Oct 2009 01:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=VzBMErDm17GgaHIP0tdtfGSSVSQSX/KDpAj3xjI5wO8=;
        b=KMPTjc32Wr9YrFOtv/kxyMJcbg/dshU1ju9N9ZObx8jxnyrdOavZt0JYEBXM3Afxq0
         nTgFbG3a4PQ6zndtoyUfDJjSI3RfEFlHlZQqPGLd9Qk2x2JcJAH7egMzKJruQzxT58oE
         fPVfPJPdB9CubwNLgjXw7bXK1b7Atpoa31ILI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=OYpfvgIhsTXswa7C724oMbzgXyJuXpnTNpjKZWpKx3Aff5BnzMNXf1VpZX3XEvFABL
         2SC7EisMa9ApjJXehbc7xzlHYodu+r9cSqJ2NiKNsKpHKtc5R4oYKNU1RbeXcVR5WcCH
         OdI7igRpI36+uJHnRBwngbTSYKy5KKFsolHHo=
Received: by 10.231.120.90 with SMTP id c26mr1290609ibr.1.1255941801808; Mon, 
	19 Oct 2009 01:43:21 -0700 (PDT)
In-Reply-To: <ee22b09e0910190132u20931fb4i6a98fb87582a9e56@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130678>

On Mon, Oct 19, 2009 at 2:02 PM, Mohit Aron <mohit.aron@gmail.com> wrote:
> Hello,
>
> I'm setting up a shared repository and I'd like to prevent users from
> creating branches in it (they can of course create local branches in
> their own clone of this repository). How can I accomplish this ? I
> looked at 'git help config' and it seems I need something similar to
> the parameter receive.denyDeletes - this prevents deletion of
> branches.

That was the main reason I wrote gitolite
(http://github.com/sitaramc/gitolite), though now it does a heck of a
lot more than just that.

Scroll down a bit on that page for the README.

People have said pretty nice things about it on #git, and (subject to
being in India time zone and the day job and all) I make sure I help
out as much as I can.  Email or #git, both are fine.

Being somewhat familiar with ssh and authkeys is good.  Otherwise,
*please* be sure to read
http://sitaramc.github.com/0-installing/9-gitolite-basics.html for
background
