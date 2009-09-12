From: John Tapsell <johnflux@gmail.com>
Subject: Re: Confusing git pull error message
Date: Sun, 13 Sep 2009 00:31:46 +0300
Message-ID: <43d8ce650909121431o382b9348q19ee7db5adbb4a72@mail.gmail.com>
References: <43d8ce650909121301i4450489dhf475ff6894394a5f@mail.gmail.com>
	 <20090912211119.GA30966@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 12 23:35:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmaFr-0006qP-2i
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 23:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754581AbZILVbo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Sep 2009 17:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754520AbZILVbn
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 17:31:43 -0400
Received: from mail-yw0-f174.google.com ([209.85.211.174]:36621 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753008AbZILVbn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Sep 2009 17:31:43 -0400
Received: by ywh4 with SMTP id 4so2822532ywh.5
        for <git@vger.kernel.org>; Sat, 12 Sep 2009 14:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=tHChl4sGZHfDqv7g2o6WFLjuuZNpM74z9wk/0eCEj14=;
        b=U+hZy/oHPpnCVD8A4zmo3VGvAyFixig7GUUhsiN90zMD1KWHgqOiBpIqlg6mH/nh96
         Wc7VLe7wgao4ugFA9hGNLjKmVUNNNgoOtbjZ0IDZamModFrEbq4AiAFYlB51btTtdTx1
         fLW6XR+nuAJL4jCQ5y8J7+RWBhjtOCHyZdoEs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bnHwYyTlbJOjXPdSkRutJYhNDwW6Z9lsl/EmkijTMrghc773V49RKb6MI0En5KuT7a
         610/M4L9S2dVnBdxfPfaRP8L5k4IQvqVRhPVOfnL9QvlZm1oJYSIO4UutJCls6QnfpEc
         TBkA/M+9gR7vCL0EZJtfmIsVx9qRN56Y4EVZE=
Received: by 10.150.166.12 with SMTP id o12mr7302055ybe.79.1252791106174; Sat, 
	12 Sep 2009 14:31:46 -0700 (PDT)
In-Reply-To: <20090912211119.GA30966@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128299>

2009/9/13 Jeff King <peff@peff.net>:

> + =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "Your configu=
ration specified for us to pull the ref"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "'$upstream_s=
hort', but we were unable to fetch it from"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "the remote."

Thanks!

But why was it 'unable' ?  Are there cases other than it not existing?
 Maybe something less cryptic:

"Attempted to pull from ref $upstream_short but this branch does not
exist on remote."

Or something?

John
