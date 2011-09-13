From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: windows git problem
Date: Tue, 13 Sep 2011 20:10:40 +1000
Message-ID: <CACsJy8B4RY4Yst9TPhNCOj8AUziFa+O+2Msen9Bt=QHo5SW=sA@mail.gmail.com>
References: <4E6E42CE.80405@tandvsolns.co.uk> <CAMOZ1Bs6tGGJ8eZja0OaqtzK0imKt_NtiWOTgpLCaisvEXh2Rw@mail.gmail.com>
 <4E6E5000.3040203@tandvsolns.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: luis <luis@tandvsolns.co.uk>
X-From: git-owner@vger.kernel.org Tue Sep 13 12:11:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3PxV-0006t6-Ir
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 12:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060Ab1IMKLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 06:11:12 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63696 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977Ab1IMKLL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 06:11:11 -0400
Received: by bkbzt4 with SMTP id zt4so363386bkb.19
        for <git@vger.kernel.org>; Tue, 13 Sep 2011 03:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=H1dEp/CFk4ojcE7f7tlWHr7DyzjWkE183yO0FukjNOU=;
        b=krDUJ87KACM/bI/Zw1rGOW9N0nR4S1fD/4rkAmPp/FmzC6jvwMu6FjgB4R+4B8V6Na
         /JspdAOAfDLvU2WCRuyrik0kqeuxPsclHejYY0n3d55mua8O64b0EXhmXpZec0ytmZV2
         ByMCpqcr20xuXHfvZmMbSjxTuJCesYm4WkVnI=
Received: by 10.204.139.6 with SMTP id c6mr667570bku.391.1315908670129; Tue,
 13 Sep 2011 03:11:10 -0700 (PDT)
Received: by 10.204.7.4 with HTTP; Tue, 13 Sep 2011 03:10:40 -0700 (PDT)
In-Reply-To: <4E6E5000.3040203@tandvsolns.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181280>

On Tue, Sep 13, 2011 at 4:31 AM, luis <luis@tandvsolns.co.uk> wrote:
> Exactly!
>
> so the next time someone (in windows) does a commit, they remove the file or
> the folder contents!

May be this commit dc1ae70 (Support case folding for git add when
core.ignorecase=true). Forcing core.ignorecase to add_to_index() seems
a bit too strong for me. We could have added a new flag,
ADD_CASE_INSENSITIVE, to add_to_index() and enabled it only to
selected commands instead.

Or maybe we can improve the situation a little bit by warning users this case.
-- 
Duy
