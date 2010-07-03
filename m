From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: what is the test target of t9400-git-cvsserver-server.sh
Date: Sat, 3 Jul 2010 20:52:20 +0000
Message-ID: <AANLkTimuYhTyQmxOdKuFUujGmXDC9scHQLGMaWCxcLeG@mail.gmail.com>
References: <AANLkTimhp_D22jGlfkbJenYpyzLKWN6HqCyHePCOwJ50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?w4FzaGluIEzDoXN6bMOz?= <ashinlaszlo@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 03 22:52:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OV9hU-0005PK-Rc
	for gcvg-git-2@lo.gmane.org; Sat, 03 Jul 2010 22:52:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755283Ab0GCUwX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Jul 2010 16:52:23 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42758 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754461Ab0GCUwX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jul 2010 16:52:23 -0400
Received: by fxm14 with SMTP id 14so2991155fxm.19
        for <git@vger.kernel.org>; Sat, 03 Jul 2010 13:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9nxJ/a4M0hqacRBtN1pLebjj0gz+yKD7XZnp9vDca+I=;
        b=p7LEcxcyRXLyrbfDarjYyAVsi+5UGJL6hamIvpqcA0xef+neEFUzIxJ8iELByJOk85
         4dpnpogNPu1OtChr1szmF+PzkqJfjrLyqqzcrPLaYqQzABGSBevadGgw2odMu87ea7Kd
         bi7SPwMjQkKA3HZqCRP/jM67ACkmccRLJWTQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Q5BSoPEKFlFGPbHiPQ6461Zp4poVXZKwluCLPnwesfikt5I2UclH9GCR99hSGLbaUD
         z8YRUOV/sotROot1/Mrx4scgL2jJtPOS46uVgJhdJH7HCTAuqZxr4lTh+XpKUp5bmpFG
         WwS6z++zSp3DjLzADe+N+dXhmisV3pnMdBF3E=
Received: by 10.223.111.69 with SMTP id r5mr580330fap.82.1278190340629; Sat, 
	03 Jul 2010 13:52:20 -0700 (PDT)
Received: by 10.223.103.84 with HTTP; Sat, 3 Jul 2010 13:52:20 -0700 (PDT)
In-Reply-To: <AANLkTimhp_D22jGlfkbJenYpyzLKWN6HqCyHePCOwJ50@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150202>

On Sat, Jul 3, 2010 at 17:04, =C3=81shin L=C3=A1szl=C3=B3 <ashinlaszlo@=
gmail.com> wrote:
> t9400-git-cvsserver-server.sh refers to git-cvsserver as CVS_SERVER
> for the cvs client:
> CVS_SERVER=3Dgit-cvsserver
>
> What is the goal of this test? To test the git-cvsserver executable
> found in the system (in $PATH), or the one bundled in the git source
> distribution? I would think that unit tests are to be run before make
> install, so it should test the latter. I have a patch already to fix
> that and I will post it in case I am right.

Have you noticed that test-lib.sh sets PATH to include the git director=
y?
