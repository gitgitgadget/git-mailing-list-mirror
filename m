From: Dongsheng Song <dongsheng.song@gmail.com>
Subject: gitweb.cgi bug - XML Parsing Error: not well-formed
Date: Tue, 18 Feb 2014 19:41:47 +0800
Message-ID: <CAE8XmWp3uTW7wGrVryC6ECTkkJRcc=ruC=B6PhOURGifnh90Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>
To: Andrew Keller <andrew@kellerfarm.com>
X-From: git-owner@vger.kernel.org Tue Feb 18 12:42:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFj43-0007Gr-Tf
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 12:42:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754848AbaBRLmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 06:42:10 -0500
Received: from mail-ob0-f171.google.com ([209.85.214.171]:63292 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497AbaBRLmJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Feb 2014 06:42:09 -0500
Received: by mail-ob0-f171.google.com with SMTP id wp4so18396212obc.16
        for <git@vger.kernel.org>; Tue, 18 Feb 2014 03:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ffLgcGSwP9JXn5l77zcL4hIKrRmy3KGKaWxXoJZUuMU=;
        b=yOMKsPjfSutUCYGrEF03XxYEaVKbDFhuVGM2XM6rMV5ExCysM6MNB+FsqbptvNKlSN
         77sG0TG0jzLC0X0aISV+wzSYDemTb+ukedRpXoYEJv+ozkvBSr0kLGhTxmwAwg7dEsH8
         vhw+Ednijt4g8xcnicsYHitdA3pTm/OBsoIMTkUX1dQDy8B62AR7+/c4M9gMhGKSxONQ
         MZ+FwmZ0h6bSWWdr0nXhp08Zejnp/TA84qY0WKf9ex+OuvGIK9rr0ANkgL0WbOUBBHTd
         K1jF1R2Mmom4z1Z24Sh2EPgS8bQx9eh1GFGTyNoqi2Xt159P6eO8Em21IWw3h3QS3W06
         0lZA==
X-Received: by 10.182.131.170 with SMTP id on10mr25607581obb.2.1392723727222;
 Tue, 18 Feb 2014 03:42:07 -0800 (PST)
Received: by 10.182.240.16 with HTTP; Tue, 18 Feb 2014 03:41:47 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242297>

Here is gitweb generated XHTML fragment:

<div class="patch" id="patch19">
<div class="diff header">diff --git a/RFC/2010/DRE-2010-004 RFC for
Update Synchronization Program &amp; Solve the Balance Adjustment
Issue v2.doc <a class="path"
href="/repo/git?p=DRE/Reference.git;a=blob;f=RFC/2010/DRE-2010-004+RFC+for+Update+Synchronization+Program+%26+Solve+the+Balance+Adjustment+Issue+v2.doc;h=3074448e2e68235e891ebd1301e6277d993973a5;hb=fbd4e74c867214062ad39282a899f1d14a2e89ba">b/RFC/2010/DRE-2010-004
RFC for Update Synchronization Program &amp; Solve the Balance
Adjustment Issue v2.doc</a></div>
<div class="diff extended_header">
new file mode 100644<span class="info"> (file)</span><br/>
index 0000000..<a class="hash"
href="/repo/git?p=DRE/Reference.git;a=blob;f=RFC/2010/DRE-2010-004+RFC+for+Update+Synchronization+Program+%26+Solve+the+Balance+Adjustment+Issue+v2.doc;h=3074448e2e68235e891ebd1301e6277d993973a5;hb=fbd4e74c867214062ad39282a899f1d14a2e89ba">3074448</a><br/>
Binary files /dev/null and b/RFC/2010/DRE-2010-004 RFC for Update
Synchronization Program & Solve the Balance Adjustment Issue v2.doc
differ<br/>
</div>
</div>

--
Dongsheng
