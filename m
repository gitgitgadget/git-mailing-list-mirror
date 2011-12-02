From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Anyone have a commit hook for forbidding old branches from being
 merged in?
Date: Fri, 2 Dec 2011 12:27:06 +0100
Message-ID: <CACBZZX5+AC0ZxsdNMrEEq=h+1KWDxXhCxL2P7UBdM=cPTwS7vA@mail.gmail.com>
References: <CACBZZX4LyTaz=fU1vvgpeL904QFjJULCMVSP0uutcuxZT+-vWQ@mail.gmail.com>
 <4ED82BCA.5080909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 02 12:27:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWRHB-0005GK-3c
	for gcvg-git-2@lo.gmane.org; Fri, 02 Dec 2011 12:27:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754182Ab1LBL13 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Dec 2011 06:27:29 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60293 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753311Ab1LBL12 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Dec 2011 06:27:28 -0500
Received: by bkas6 with SMTP id s6so3711782bka.19
        for <git@vger.kernel.org>; Fri, 02 Dec 2011 03:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=WlddNF5N0AlfLEDme/sUgzddDzyFFemw8YQKXwum4Sg=;
        b=xgzqKeWTxnzGGxLBiIP3FcLCi+E+yu3n04IQODPO21yMya/GuiyXLuULMeEMgNoGTG
         qwVl12VGWYujNMWWBlP2qjS1HxpOKJu7aliWZNDPWdmQMnMCvmXE4jpHZ1eRQpYXfWc5
         xCo1akU/jggvgR7vRgOvg0wsIbQDMxjBTrGyA=
Received: by 10.205.139.2 with SMTP id iu2mr10484084bkc.128.1322825247338;
 Fri, 02 Dec 2011 03:27:27 -0800 (PST)
Received: by 10.204.69.71 with HTTP; Fri, 2 Dec 2011 03:27:06 -0800 (PST)
In-Reply-To: <4ED82BCA.5080909@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186214>

On Fri, Dec 2, 2011 at 02:37, Neal Kreitzinger <nkreitzinger@gmail.com>=
 wrote:

> It sounds like you're saying that people should rebase before merging=
 to
> main. =C2=A0That means their merge would be a fast-forward. =C2=A0You=
 could just
> reject anyone who has not done a current rebase. =C2=A0Then you could=
 use this
> technique from the pre-rebase.sample hook to enforce up-to-date rebas=
es:

That would be an overly invasive change to people's workflows. It's
fine if you merge something in as long as the initial merge base isn't
N days older than the current state of the mainline.
