From: Brian Foster <brian.foster@innova-card.com>
Subject: no `bare = true' in `config' of a bare repository - problem or ignore?
Date: Mon, 16 Jun 2008 14:36:37 +0200
Message-ID: <200806161436.37278.brian.foster@innova-card.com>
Reply-To: Brian Foster <brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 14:37:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8DyB-0001GG-2v
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 14:37:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754744AbYFPMgw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Jun 2008 08:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754181AbYFPMgw
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 08:36:52 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:10623 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754508AbYFPMgv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jun 2008 08:36:51 -0400
Received: by fg-out-1718.google.com with SMTP id 19so3242823fgg.17
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 05:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:reply-to:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:sender;
        bh=tFiDQiCeQM/GVWLm+SOd6TJtw8xmfbAR7+4WA+cACWk=;
        b=EIr8SPnv1gYcA2g4qEbARVckVLLqBKIn4Rrwg1uozfjNWXu8wtmOlCQlvCxGajCRVq
         GilQZvcs6xIgJphoo5K+PSxE9vuQhU2oq0SQv9M1mIF/eDi+Ng5b2CQTJ/RL2EKrx18O
         Ssr7tPMXVQb6hY7Pdfds5XmKpHSrNNdcrqG9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:reply-to:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id:sender;
        b=iRvH+il2ie0MsVX5l3JcOpxZ2zqPgjbxxkS9c3iAnHGGoVX+kfaDhCs4znEor4mM/w
         +SMd6hXwbZ1vez5F3RFGXi4gpB/+P5QuGiN0IoPgUbCaT1ypcWNVzLSBn3tUYbA32Sa7
         aEyyR3Wj098n+F3wneJztMusF9q8WQKPvYB4g=
Received: by 10.86.71.1 with SMTP id t1mr7810905fga.36.1213619810068;
        Mon, 16 Jun 2008 05:36:50 -0700 (PDT)
Received: from innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTPS id d4sm10445151fga.8.2008.06.16.05.36.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Jun 2008 05:36:48 -0700 (PDT)
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85186>


 Whilst investigating a (probably unrelated) mystery,
 I noticed that some of my bare git repositories had:

	[core]
 	    bare =3D true

 whilst others did not (they had no `bare' setting at
 all).  All, with or without `bare', seem to be quite
 happy, but I was wondering what's going on;  is this
 a problem;  and if not, is there any point to adding
 the setting anyways?

 As to _why_ some do and some don't, I haven't a clew,
 but suspect the ones that do NOT were originally made
 with an (unknown) older version of git;  and the ones
 that do were made with git 1.5.3 or later.

 The git-config(1) man page (1.5.5) doesn't directly
 mention this, only talking about auto-guessing the
 value on init and clone.  Apologies if TFM explains;
 I didn't spot anything.

cheers!
	-blf-

--=20
=E2=80=9CHow many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools.=E2=80=9D |      http://www.stope=
sso.com
