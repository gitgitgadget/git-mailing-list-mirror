From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] push: Enhance unspecified push default warning
Date: Thu, 3 Oct 2013 07:57:41 +0700
Message-ID: <CACsJy8Bt_mtXVHjWn+8Ba6qrk=vSh2kGyaowA9B+=2xvhA_o_g@mail.gmail.com>
References: <CAKYC+eLGS6ocdE7CTV25E2xMRaHijmQbFBc3tAyx3cNpXfC_sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Coder Coder5000 <coder5000@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 03 02:58:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VRXFA-0005u1-Ok
	for gcvg-git-2@plane.gmane.org; Thu, 03 Oct 2013 02:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753619Ab3JCA6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Oct 2013 20:58:12 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:45140 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753335Ab3JCA6M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Oct 2013 20:58:12 -0400
Received: by mail-oa0-f51.google.com with SMTP id h16so1648617oag.24
        for <git@vger.kernel.org>; Wed, 02 Oct 2013 17:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Hz0Y5YrPFZHOe5y2Cb7opEBp/JI1/wT4iMXAiCZOhA0=;
        b=PzCrLY3QIiAq8TDFyjrOUN57owU4y/mQEO+04lszdOVR+dsxAR5b7141QPYTjJ+H9T
         +S/wCMI9s8jvzdarFyrfFJh4hGJkP2ZQJmvQkjgmp98W482mlS8l/SjQAymXa+mZc4za
         cCYYOohhyiyG7V00/24IYauyU+/33T8Hl4rpwOXiejZbISj4jKVBTkyeLwfREq+gSRLE
         93Pc7E2S+6Kqwmuq+DGX0dE9+3Q6W7AEgmdPuJs5+iCztKjnkUoQx43QYmYh07k+qJCw
         BKqvRG8jCaOAgmXq9ns+b2cd1QRbFmCt/td15bkpcPJ5j63BX63zPfxkuLIcgpBTqwIR
         bq9Q==
X-Received: by 10.60.131.41 with SMTP id oj9mr8115301oeb.40.1380761891222;
 Wed, 02 Oct 2013 17:58:11 -0700 (PDT)
Received: by 10.76.131.130 with HTTP; Wed, 2 Oct 2013 17:57:41 -0700 (PDT)
In-Reply-To: <CAKYC+eLGS6ocdE7CTV25E2xMRaHijmQbFBc3tAyx3cNpXfC_sg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235677>

On Thu, Oct 3, 2013 at 3:48 AM, Coder Coder5000 <coder5000@gmail.com> wrote:
> When the unset push.default warning message is displayed
> this may be the first time many users encounter push.default.
> Modified the warning message to explain in a compact
> manner what push.default is and why it is being changed in
> Git 2.0.  Also provided additional information to help users
> decide if this change will affect their workflow.
>
> Signed-off-by: Greg Jacobson <coder5000@gmail.com>
> ---
>  builtin/push.c | 9 +++++++++
>  po/git.pot     | 8 ++++++++
>  2 files changed, 17 insertions(+)

You don't have to update git.pot. It'll be regenerated regularly by Jiang Xin.
-- 
Duy
