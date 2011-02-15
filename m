From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: non-empty index with git commit -a
Date: Tue, 15 Feb 2011 22:43:53 +0000
Message-ID: <AANLkTi=5E8D0mwMDNuMdgZS69kOnKCfs=Q8X5bpcjnYF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 15 23:44:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpTdP-0000su-5j
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 23:44:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756366Ab1BOWof (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 17:44:35 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:33329 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755720Ab1BOWoe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 17:44:34 -0500
Received: by gyb11 with SMTP id 11so335533gyb.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 14:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=3hFtI7irpzjpkdA9IBXpDD/nyIJ1AUYYruQTXThNn7k=;
        b=q9EOQv2bJAxE9KonfYDCHA1FnfzcwEO6ikLExU6clFn6cZBdRXZz7uaZeaLj3d/gtg
         /5vKaWoxkbes6s/h2/U1e+KMjY/G6yQQSYdTTmR9+Ie2cM1oyyng0eTbWhrRMTcjArSP
         fGSOvS+CLlmvb9NrC8Mrbgr1oLMR9DWFc2p30=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=pj9q9n4MCEcon4eeZJEKt+we/hY40xr23qH9yhipbYYlO7QqBmDL23CRrnim36Uf2b
         lmhq+dUPtO/baq3KLqg1B5whYluugLqOkLs3rI2Ho9JsXMe+lS+n1moUzFGnU9UzV4ZJ
         aBr+Cm+oPU+xKnfO0ZjQEnhl/7eu2tHU36780=
Received: by 10.150.137.11 with SMTP id k11mr128868ybd.108.1297809873167; Tue,
 15 Feb 2011 14:44:33 -0800 (PST)
Received: by 10.151.158.19 with HTTP; Tue, 15 Feb 2011 14:43:53 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166891>

Heya,

Can we please fix this?

$ hack hack hack
$ git add -p # carefully add my changes
$ git commit -am "Add feature foo"
$ DAAAMN YOUUU FINGERS!!

I remember bringing this up before, but I can't remember what the
discussion ended up coming to.

-- 
Cheers,

Sverre Rabbelier
