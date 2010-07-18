From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Merge commit subjects git.git
Date: Sun, 18 Jul 2010 11:56:12 -0500
Message-ID: <AANLkTinTOMxWVM9kwhIfcG44SqOjpexY-Xy6kZYkemU9@mail.gmail.com>
References: <AANLkTikavL0DH8FgFxBw7hbGLtj2tqxnP-BT77zo5FJT@mail.gmail.com> 
	<201007181733.59704.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jul 18 18:56:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaXAM-0007OF-TR
	for gcvg-git-2@lo.gmane.org; Sun, 18 Jul 2010 18:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756715Ab0GRQ4e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Jul 2010 12:56:34 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:39134 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756704Ab0GRQ4d convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jul 2010 12:56:33 -0400
Received: by gxk23 with SMTP id 23so1868223gxk.19
        for <git@vger.kernel.org>; Sun, 18 Jul 2010 09:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=jmtaRSj+COlFyazTArgFHWdffOyS4a6gsq14sV5gT7Q=;
        b=aFxwTk6eD27JUUIJEMaeWd0lfnfp59/GDbdDEuwNkOO0QKLHRf8gqEtRgvGqvxwaPO
         3DIi4J6VwCJbsEbuGYkuGfB1CwLmsCylK78KqD+eCxmN4uXk6/Uh6Pu4n0dQLc1T639e
         jlY2Lqv/0T4LHP9UarCOqdlJnN+JyPA3wJKtA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=iH6vAvgfRrEGW/cpZMGcL4Y+ZKU0awTM7mHyTZPwX9sXeh2J7TxdGVyYbhstIw12fH
         o6ju8lD81ur20+5LiVGKVKcebivwaVX0KPMEAIqrLcAezNIm2Cdc41Qbn//nnK4FxBzc
         tu9HT59ifWXXQSxWQv7Xzzc6K10wSG1laKIvo=
Received: by 10.151.42.18 with SMTP id u18mr3448616ybj.33.1279472192695; Sun, 
	18 Jul 2010 09:56:32 -0700 (PDT)
Received: by 10.150.93.19 with HTTP; Sun, 18 Jul 2010 09:56:12 -0700 (PDT)
In-Reply-To: <201007181733.59704.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151219>

Heya,

On Sun, Jul 18, 2010 at 10:33, Thomas Rast <trast@student.ethz.ch> wrot=
e:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!strcmp("master", current_branch))

Wow, I thought the only place where we gave "master" any special
meaning was in that we create it as the default branch. Can't we fix
this to be less hard-coded?

--=20
Cheers,

Sverre Rabbelier
