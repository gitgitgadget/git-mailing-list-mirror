From: Martin Gregory <marting@adelaideinterim.com.au>
Subject: re[2]: sparse checkout file with windows line endings doesn't work
Date: Thu, 19 Sep 2013 18:51:41 +0930
Organization: AI
Message-ID: <SDZWVEJZSSNSWDRKPVQvMTg5ODc3NzY1@IBMLT4>
References: <CACsJy8CRoZYWExHMjwG3ZOv=eJ9irq_mM_bM78ss_DssSq7szw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nqp=nb64=()OE2pTZ86C"
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>,
	Martin Gregory <marting@adelaideinterim.com.au>
X-From: git-owner@vger.kernel.org Thu Sep 19 11:24:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMaTd-0004Z2-AV
	for gcvg-git-2@plane.gmane.org; Thu, 19 Sep 2013 11:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024Ab3ISJYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 05:24:38 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:64225 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751903Ab3ISJYi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 05:24:38 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr4so8163822pbb.34
        for <git@vger.kernel.org>; Thu, 19 Sep 2013 02:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :mime-version:organization:content-type;
        bh=Tp/fDgiWrDFbMW8uJt+HwUqBxifDwFp2b58u9yoeDIQ=;
        b=QnJJhx8Mbbyn0/Kzbd3b67jvEIDL9Jpl0rhh2gfdTpkaljDqhfrF7aP079IfF0ShLK
         PrcB7zbi6OFwvp1G1n9jBUMjdRWwcTak3OzZ+GQJe5IL+S0EmBTOaE+zlKk4zEcdF3wq
         X10NeNVagOirBaelo8MmEm8sYniel5sc6f20+NcVdlWLb8hps+RkJhAbU13CuLS7YknH
         MLK+sM5GQPIHz/qftDenBARAuMSRClGx6NbdlTyzoKsOh8GOXmnlNo98qOha1w4a3Qym
         Ttx3f7LPCndHXhGE6hgI19Dl4+MbaFbv4tyxqeXvv8+nDX8Dxi5WBuxMzhm/7SrP7O4m
         bq2Q==
X-Gm-Message-State: ALoCoQnt/cZhfc9S21/FERZt0Z2WJ8Oi0pBUtopomiaroiuHG/EEu8AKNRCieicsnOe1Q6r8zab5
X-Received: by 10.68.6.232 with SMTP id e8mr687836pba.132.1379582677425;
        Thu, 19 Sep 2013 02:24:37 -0700 (PDT)
Received: from IBMLT4 ([1.124.254.166])
        by mx.google.com with ESMTPSA id t2sm7403585pbi.7.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 19 Sep 2013 02:24:36 -0700 (PDT)
In-Reply-To: <CACsJy8CRoZYWExHMjwG3ZOv=eJ9irq_mM_bM78ss_DssSq7szw@mail.gmail.com>
X-Mailer: GoldMine [9.2.1.92]
X-GM-Attachments-Sync-Time: 20130919185427
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235009>

--nqp=nb64=()OE2pTZ86C
Content-Type: text/plain

Hi Duy,

>>  And it does work for me with CRLF endings (again tested on Linux). Can
>>  you send me your sparse-checkout file? Zip it if needed.

sparse-checkout created with

echo /CONFIGURATION > .git\info\sparse-checkout

on Windows.

Attached file created with

tar cvzf sparsecheckout.tar.gz .git/info/sparse-checkout

in gitbash shell on Windows.

Regards,

Martin


--
Martin Gregory
Senior Consultant, Adelaide Interim
P:   +61 8 7200 5350
M:   +61 402 410 971
F:   +61 8 7200 3725
--nqp=nb64=()OE2pTZ86C
Content-Type: application/octet-stream; name="sparsecheckout.tar.gz"
Content-Disposition: attachment; filename="sparsecheckout.tar.gz"
Content-Transfer-Encoding: base64

H4sIAAAAAAAAC+3OwQqCQBSF4VkHvYMvUM6IjmsJEhcpRD2AmNUQacyM75+4F1qIbf6PC4cD
d3H2D+ND09370H1q69pd82ybVz94sRw50nE8ZaqnVDKWU59ESqgoUjqJZaK1kCodTwRywQ2z
BudrGwTiVFtvunz2L7u9TWect7XvrVtj2SrCQ1Uei/x6zi5FVQbbzb8HAQAAAAAAAAAAAAAA
AAB+8gWfttSrACgAAC==

--nqp=nb64=()OE2pTZ86C--
