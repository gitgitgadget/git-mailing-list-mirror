From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: Modified files directly after clone
Date: Tue, 9 Mar 2010 13:59:39 -0800
Message-ID: <905315641003091359q4f7cd533o698ec507b9805e36@mail.gmail.com>
References: <7416BCB6-306F-4BC1-913C-1208746DA93E@ee.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Benedikt Andreas Koeppel <bkoeppel@ee.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Mar 09 23:00:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Np7TF-0002kQ-Uq
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 23:00:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753966Ab0CIWAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 17:00:05 -0500
Received: from mail-iw0-f176.google.com ([209.85.223.176]:40440 "EHLO
	mail-iw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095Ab0CIWAA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 17:00:00 -0500
Received: by iwn6 with SMTP id 6so4109604iwn.4
        for <git@vger.kernel.org>; Tue, 09 Mar 2010 14:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type;
        bh=h++zN/GjkNseR2mko0p9w7ezK1gQL+Yoj5K1XXDHV2E=;
        b=edpLHv4qhfVjGB61IroICP2k1XJ0InTZ1qlHpe3uhsSjfcLculIAU7/6UUP7mxmHNo
         qlzjuZIcSELGkB8Ncf+EdAPiw4SLcZEdHbNWx17ZT9VGYiwfbjvd1wvAr8gtcIM7VuMy
         yhfj5UPlIfkDM7tT9FoPOcOxDAPQKlITVqOD0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=PVUPfaiM5jZCQ/rpQxEKOdwiKtrJj7a23P8w9Pfgb4CE0Hyd9GyZWKlzR5jueogcfr
         atYM3Z+QW6yuSZHve8t0889Z8lCRxPpHxg1HSjUjL7/Qy+dk1H/dRakJTfRuBth+2Kxd
         NceE2Capi3puyNG9Cl8uRC8lXdWO1S5KdHZPc=
Received: by 10.231.144.201 with SMTP id a9mr184722ibv.69.1268171999147; Tue, 
	09 Mar 2010 13:59:59 -0800 (PST)
In-Reply-To: <7416BCB6-306F-4BC1-913C-1208746DA93E@ee.ethz.ch>
X-Google-Sender-Auth: 40a869af4508ef0b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141848>

On Tue, Mar 9, 2010 at 12:26 PM, Benedikt Andreas Koeppel
> How can this happen? Does my Mac somehow interfere with
> the newly cloned repository?

By default HFS+ filesystems on OSX are case insensitive so you see
problems like you described with the linux kernel source which has
different files named xt_TCPMSS.c and xt_tcpmss.c.

HFS+ partitions can be case sensitive, but are not by default.  Unlike
some earlier versions, OSX 10.6 can boot from a case sensitive HFS+
filesystem.  Even if you do that, OSX (or maybe HFS+) still has issues
with unicode normalization described in the archive, but I haven't had
a problem with the normalization in practice.

Thanks,
Tarmigan
