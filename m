From: Igor Lautar <igor.lautar@gmail.com>
Subject: Re: commit gone after merge - how to debug?
Date: Mon, 26 Nov 2012 15:23:56 +0100
Message-ID: <CAO1Khk_Czr9=1pECpFAkqfGaYz7qPSE1jvEtQ3u2HOASq+yMwQ@mail.gmail.com>
References: <CAO1Khk_eugH--wp3s-gr4HTvuRyL=SaWHWtEXCRZ_Ak7+s5U=w@mail.gmail.com>
	<1353935441-ner-9639@calvin>
	<vpqr4ngsdjl.fsf@grenoble-inp.fr>
	<CAO1Khk9mzJjnysnc1iDFeMgqnRq0z35t0kgC-8nrsjJ-oOvdOg@mail.gmail.com>
	<vpqehjgscv3.fsf@grenoble-inp.fr>
	<CAO1Khk8=nrKknfqY-k6XaGPDbLrHyrK-8fxfB7XXUWeB7L4EUA@mail.gmail.com>
	<vpqhaocqx4k.fsf@grenoble-inp.fr>
	<CAO1Khk9Y_SC8q4iHnv848Z+dXMaeUOWxzW76yPSj_as317_u5g@mail.gmail.com>
	<vpqboekqwei.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Tomas Carnecky <tomas.carnecky@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Nov 26 15:24:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tczbb-0004Vx-3h
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 15:24:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753676Ab2KZOX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 09:23:57 -0500
Received: from mail-vc0-f174.google.com ([209.85.220.174]:58039 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752861Ab2KZOX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 09:23:56 -0500
Received: by mail-vc0-f174.google.com with SMTP id m18so7669840vcm.19
        for <git@vger.kernel.org>; Mon, 26 Nov 2012 06:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=aTGjA9mA55dUgLTb2SrdJJDOg4zyOaaFZEPTsPeXCJo=;
        b=cywE9f+RwpsZT8wmciALMLJWzTJELhd6lnS3eN+N7NoZY1feA01mcMsdIQmT1ms9gH
         CyifEJ9UKcc3JTnT8UniXWYvIPbQ+U9VegQ+OPFaS9cpFHpnHBy1fYrf4eteFmHRar9X
         qxwd3GSAxdz/aDCDPkyYUaqBjhg7Sa8X+N+U8LJTS/hMOkMMLMEHWC7RqJmBz7yAMzSL
         psMJ5gZQwBAQber3PS+Oob0QlsQzigd81Hs1XMkJ34kIcqD+0YrFts/QDFN6jtcfQSts
         JKy4LJPAknE9Q2z0AcGsZNXklFCjf5Qc80R6V721SR/rDsFVdYnCB6DktjLYyI+Vq69b
         251Q==
Received: by 10.52.70.8 with SMTP id i8mr16754875vdu.24.1353939836281; Mon, 26
 Nov 2012 06:23:56 -0800 (PST)
Received: by 10.58.69.112 with HTTP; Mon, 26 Nov 2012 06:23:56 -0800 (PST)
In-Reply-To: <vpqboekqwei.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210453>

On Mon, Nov 26, 2012 at 3:19 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> What about "git annotate <file> <merge-commit>^1"?

No change, line version goes back to when file was added.

> Was the merge completely automatic, or were there any conflict?

No conflicts at all. In fact, that particular file was not touched by
one side of merge, only by another. It seems like git ignored the
change, but still recorded history (shown only with --full-history).
