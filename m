From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [BUG] Git won't commit
Date: Sat, 13 Aug 2011 20:56:04 +0000
Message-ID: <CAMOZ1Bu3AoQb330hkL+8hDTCvKX+amRfPE3PBxDHUZR17N344Q@mail.gmail.com>
References: <1313169225059-6681082.post@n2.nabble.com> <CAMOZ1BtxNSnncEJ6frEY0STgfS478krkpxXStP401WLPovb2Gw@mail.gmail.com>
 <CAAC=0R66j43CqpaxXskAwHsitvRFwy7DsjguNPm+sPa4YmTWqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Fabr=C3=ADcio_Nascimento?= <fabricio@tailorbirds.com.br>
X-From: git-owner@vger.kernel.org Sat Aug 13 22:56:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsLG3-0002pZ-QX
	for gcvg-git-2@lo.gmane.org; Sat, 13 Aug 2011 22:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614Ab1HMU4f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Aug 2011 16:56:35 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:47168 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536Ab1HMU4e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2011 16:56:34 -0400
Received: by iye16 with SMTP id 16so4275279iye.1
        for <git@vger.kernel.org>; Sat, 13 Aug 2011 13:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=jhHQ2uSEJeKLs8dsroPx3DoIi2Qce95JGV/a/D38dCA=;
        b=RNLs1XHnXa0AmXdXFOaRZhAL4lbaLVayY15ElU3/u9/dpKjvFiSO6jEqAfRT8ge4yr
         WLtx6/YKEKmwcCEFji+lTQ0RKPGBN1dK4tTccoLUqKNuW1CnZM9WWV5NOkqzcDRVEy5L
         IR2/RydITQZGo+u/eoil/URkJpIzcwLEd1uW4=
Received: by 10.43.47.10 with SMTP id uq10mr995168icb.279.1313268994132; Sat,
 13 Aug 2011 13:56:34 -0700 (PDT)
Received: by 10.42.171.6 with HTTP; Sat, 13 Aug 2011 13:56:04 -0700 (PDT)
In-Reply-To: <CAAC=0R66j43CqpaxXskAwHsitvRFwy7DsjguNPm+sPa4YmTWqw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179295>

2011/8/12 Fabr=C3=ADcio Nascimento <fabricio@tailorbirds.com.br>:
> Where git=C2=A0is the 1.7.6 that does not work, and git2 is the 1.7.4=
 that does
> work.
> [master 09-mapas] git config --get commit.template
> template
> [master 09-mapas] git2 config --get commit.template
> template

Did you get this problem figured out? If not, run:

  git config --unset commit.template

and then try making a commit as usual.

As for why one version works but the other does not, I'm not sure.
