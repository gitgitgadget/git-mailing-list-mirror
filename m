From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Data stream error (incorrect header check)
Date: Wed, 9 Feb 2011 16:54:08 -0800 (PST)
Message-ID: <903799.92091.qm@web31810.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 10 02:01:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnKu5-00023F-DM
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 02:01:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664Ab1BJBAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Feb 2011 20:00:52 -0500
Received: from web31810.mail.mud.yahoo.com ([68.142.207.73]:29483 "HELO
	web31810.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751175Ab1BJBAw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Feb 2011 20:00:52 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Feb 2011 20:00:51 EST
Received: (qmail 92104 invoked by uid 60001); 10 Feb 2011 00:54:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1297299248; bh=+LY8gAxCBDNMygIE91myKQX/BWlN32KOF3flZ2ZX9+M=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type; b=Rlx1e10opz3JmnWEnKsIsVw3iix9gXfKYzaCQlbIJllczkydtRgPk7XNdYdFRjhb/9aT4WpYiv8bET33SsIFoGJZ5Pe+0Wq3ZTJEBiOJuq3DS1KdKyDVTg/Y/4DOr8hT2uEDatrzMlbREWhWuYwgIob/m77HAi1nYFREe9HAbA0=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type;
  b=eNxMGvjB4eDlLCr2kv9XgyJcM5xwyMC2/9Lu26vJkIqAXE5uRrowwQQ/v2wXutpExY4dAjpCMuQXzw4feFCWEbuqcFgYeGNqOO3URq7i026Ck2h6vptG6uVtn0VUQYzzjsL5nIsrLPHNSA+I94mLuuCSlpxmJzKWyQuHyu/woVI=;
X-YMail-OSG: ePpPKlQVM1lky3aXZuc_f3otm2M1nF0G9umZPo4d.O_mwG9
 wiu41HJN8GPVekhUmjvhuARCgdIjoO6lr74bLM2CcjLhsDG4BUztUgvLSt7R
 BVoT.eulB2fgphJEPosiBwJ6qJS.9YapftmzORoBRRAvvJ78x3eE.h2prOsV
 L6SXW2aTj4Io8UtaCQEhWsPWjA4xSiJTZdcfW7DoenUZ2RBGGgokU0LAajg_
 ighwdiARZED62CIsI1Rfxn1gemgv5R6Jlqyt8XMPSUidxLUXOX2V_G0JyReE
 IDWYgGhWE
Received: from [68.183.234.92] by web31810.mail.mud.yahoo.com via HTTP; Wed, 09 Feb 2011 16:54:08 PST
X-Mailer: YahooMailClassic/11.4.20 YahooMailWebService/0.8.109.292656
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166460>

The repo is linux-2.6.
I get this when doing git log, git annotate, etc:

error: inflate: data stream error (incorrect header check)
error: failed to read object d5e57db2bfd773611e2b77b4bbe6d89ba8449b45 at offset 
fatal: object d5e57db2bfd773611e2b77b4bbe6d89ba8449b45 is corrupted

What's the best way to fix this without cloning new and fetching local heads over to the new repo?

I'd like to fix this in the current repo I'm using.

Thanks,
   Luben
