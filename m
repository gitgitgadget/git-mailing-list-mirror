From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] Remove --undo flags from stg commands and docs
Date: Mon, 7 Jul 2008 21:54:01 +0100
Message-ID: <b0943d9e0807071354j50dca83aya90317f97f559b19@mail.gmail.com>
References: <20080704063536.9570.43526.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 22:55:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFxjk-0002Bd-JS
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 22:55:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755917AbYGGUyG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jul 2008 16:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757704AbYGGUyF
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 16:54:05 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:48670 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757510AbYGGUyD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jul 2008 16:54:03 -0400
Received: by yx-out-2324.google.com with SMTP id 8so514024yxm.1
        for <git@vger.kernel.org>; Mon, 07 Jul 2008 13:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Z4K6dBc1NP7hOWHJeEHLpJE5YnsKgscJ4u9L8zng+7I=;
        b=cQgnSfSMuvS8bJg19QRK94HD8zHtMFrk04BtAcZvtgHuKunJuv8wUzcYa2+UqaScLs
         LeyKLnD+tDqLzRP9STTEyXKwzsMX4x/vbNo997Uttt+Aph+sm+pmafImtBBdS10LTDdD
         rT3qSMHcUSsQrev4jO//8kaDbtX/j4qY0yWxI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ca6ItVr8PjqzEvg9c+M/vPKr3ULZlI9kp5t7WxG37qYnek/gJDRAifggAtWNHP0LjG
         uynQm6xeSydco3vD9egSbTlhbGZpgqStYsk+tPLm6HI0B04W4dgcBdkmADzDCwS6S1/w
         2bN8KNUfDkkagszeZhhAHqe/w6kIwX5x3zlKg=
Received: by 10.115.33.1 with SMTP id l1mr6997121waj.228.1215464041966;
        Mon, 07 Jul 2008 13:54:01 -0700 (PDT)
Received: by 10.114.124.9 with HTTP; Mon, 7 Jul 2008 13:54:01 -0700 (PDT)
In-Reply-To: <20080704063536.9570.43526.stgit@yoghurt>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87654>

2008/7/4 Karl Hasselstr=F6m <kha@treskal.com>:
> Now that we have "stg undo" et.al., they aren't needed anymore.

Great, thanks.

> In this one, I've just removed the --undo flag from sync without
> adding anything back. Still undetermined if that's OK.

I think it should be ok (see the other thread). Anyway, have you heard
of anyone else using sync apart from me?

--=20
Catalin
