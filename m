From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2012, #01; Sun, 3)
Date: Wed, 6 Jun 2012 14:22:59 +0200
Message-ID: <CAMP44s0cQe3jdfzbJmFVoFS50Ho5hVPg9dpZx0KhG3sP_J8=_g@mail.gmail.com>
References: <7vr4twudqm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 06 14:23:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScFGV-0005pa-S4
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 14:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752813Ab2FFMXD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jun 2012 08:23:03 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:61123 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751539Ab2FFMXB convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Jun 2012 08:23:01 -0400
Received: by lahd3 with SMTP id d3so4583863lah.19
        for <git@vger.kernel.org>; Wed, 06 Jun 2012 05:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=oM8WHplpgjyE71Tc8n0VlOOcN3kpIOe2cUK1uQuB9Iw=;
        b=cI4oZCQl6aLx0me663g0zrif/xFT5qW7uIythAF3isMf7qZiojz1sggAFBHqJS0ea+
         fAOeWPu0/UI3nGW9XAxZd53jNIYeVAXcPL6L/y7+i+pstLMyXsizDuE8poZ23dHEyayi
         0BmHl1jNNbxPljB0CDjhrCEchCUAQrsjiCAmwIi502AEa/kNiotMFjj6C+JSagJWttst
         T8OqfFl6upoI+YGGZK4QwAZbKGoTWK4GxafNk9bSR6kOIxuVGBc6zHqNGXH0tya7YzHa
         e8KHyfhFNFK3rBVhvyrbE7DKGarqtUIe0zSs6HXXQMuT0MHE9GOmUZh+fdzFzhQPsY8w
         xhYw==
Received: by 10.152.123.244 with SMTP id md20mr21503627lab.0.1338985379915;
 Wed, 06 Jun 2012 05:22:59 -0700 (PDT)
Received: by 10.112.107.65 with HTTP; Wed, 6 Jun 2012 05:22:59 -0700 (PDT)
In-Reply-To: <7vr4twudqm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199319>

On Mon, Jun 4, 2012 at 2:23 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:

> * fc/git-prompt-script (2012-05-22) 5 commits
> =C2=A0- completion: split __git_ps1 into a separate script
> =C2=A0- completion: remove executable mode
> =C2=A0- Merge branch 'fc/git-complete-helper' into fc/git-prompt-scri=
pt
> =C2=A0- tests: add tests for the bash prompt functions in the complet=
ion script
> =C2=A0- tests: move code to run tests under bash into a helper librar=
y
> =C2=A0(this branch is tangled with sg/bash-prompt.)
>
> The last remaining sticking point is what to do with the duplicated s=
hell
> function.

What is the problem with leaving it as it is; having it as a duplicate
function. It's not a *huge* maintenance burden, and it's a big problem
if the functions diverge.

I still plan to add a native helper for this, but I don't see what
that would block these patches.

--=20
=46elipe Contreras
