From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: gitk normal use on linux repo and severe memory pressure
Date: Wed, 25 May 2011 13:17:49 -0400
Message-ID: <BANLkTikoqxRBMQvKRsJ0-vNd+cW5k-jQWw@mail.gmail.com>
References: <BANLkTinrj2AOCMMWazf2F4eKy7Sy56K0vg@mail.gmail.com> <m2pqn667f9.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Wed May 25 19:18:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPHiq-0001EJ-AV
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 19:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343Ab1EYRSL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 May 2011 13:18:11 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:58544 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496Ab1EYRSK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2011 13:18:10 -0400
Received: by yxs7 with SMTP id 7so3127521yxs.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 10:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=X37HsLjjJr953Qinc2XrmH9G4FkrI0XACxLcjUFhNJ8=;
        b=ResgR7hWB/y0Ffbmj5KCBM/mkqsw9wXbf7pxeT6wsVseyxG/GK+nIYWQ2fS8+BrA0A
         H9glBU4w4NV0jxBW2h48b1yBn9aAQmisnEs6FZuhH9cKnRi3cSZh9B2CsCqpy+bXbpUf
         E2MULkLhG2cxkEfmCkCu3fMGZaM8Sg3RGPbN4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=xXGNtswG5xpjcCWxdD0dL6yHwSuxNtKox2+KyGRF6nstIxZjlizTqmHnn0fS4J7c/L
         1m46cg8Xcv9gb1lZ2cC7iZ6wTXnwt2JAe+u9CiBy/PrEBJ0fM0lhQOeOIWb0l8MJB2dG
         wH8H29AVUD3VG+xnAk0621YkzL7zFjqFdKKxY=
Received: by 10.91.198.11 with SMTP id a11mr5610507agq.184.1306343889125; Wed,
 25 May 2011 10:18:09 -0700 (PDT)
Received: by 10.90.65.10 with HTTP; Wed, 25 May 2011 10:17:49 -0700 (PDT)
In-Reply-To: <m2pqn667f9.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174432>

On Wed, May 25, 2011 at 1:01 PM, Andreas Schwab <schwab@linux-m68k.org>=
 wrote:
> You can start gitk with --max-count=3DN

Or --since=3D2.weeks.ago. Of course I can -- and sometimes do. But gitk
defaults to OOMing my box if I forget to do so on a large repo.

> and if you need more commits you
> can edit the current view to increase that number. =A0No need to rest=
art
> gitk.

Ah, that's news to me! I just tried it and it's... awkward. In fact,
the dialog box seems to be missing an 'apply' button.



m
--=20
=A0martin.langhoff@gmail.com
=A0martin@laptop.org -- Software Architect - OLPC
=A0- ask interesting questions
=A0- don't get distracted with shiny stuff=A0 - working code first
=A0- http://wiki.laptop.org/go/User:Martinlanghoff
