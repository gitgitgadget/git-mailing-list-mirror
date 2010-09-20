From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Shouldn't git fetch also fetch the tags?
Date: Tue, 21 Sep 2010 02:00:37 +0300
Message-ID: <AANLkTinb=g=Y=s9AqPtLEOqMxPJVqFxRa_2cB4=iNZ4k@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 21 01:00:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxpLn-0004d2-Pu
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 01:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754474Ab0ITXAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 19:00:38 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34407 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208Ab0ITXAi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 19:00:38 -0400
Received: by iwn5 with SMTP id 5so4577811iwn.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 16:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=h/83SflW1xPA4HLzRUgGzvS6ACfMHRuUyDt7tvMREoE=;
        b=CctLVlDdbh7ovXZlbgdFAQ6G5us9hCUfKTwOFmlxmxhNZ9OaEPyx/gapw3GN6tPKD5
         gZGxgL70YWK1HRn0okpdYGaD1+Oby3VDXLn2ProJSdTxdgcHPVl5bAp2HQmzLZhnfvzb
         8C2mEIMAvRxuAcypWCpO5QQ7KErUDIARqr6TM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=cGdfEYjViQTri3YoREBwetjCyj6aeOsl04AgyYzXvQYFMOK1zkAzK9fo6m0tVgxczH
         hJok3PlJeYHjbxzlIEcXSq/r+pVK00nqEHkS1YVRSkuMXdBIcJXDigu/ITz82FXNYaCD
         YSVVa0zfaWtrap4StXt55sXnDCEoh/aAUNhQU=
Received: by 10.231.13.139 with SMTP id c11mr10803452iba.188.1285023637385;
 Mon, 20 Sep 2010 16:00:37 -0700 (PDT)
Received: by 10.231.160.6 with HTTP; Mon, 20 Sep 2010 16:00:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156675>

Hi,

Usually when I do 'git fetch' the tags are fetched too, however, there
is one repo:
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.35.y

Where it doesn't happen, and I manually have to 'git fetch --tags'.

What's going on?

-- 
Felipe Contreras
