From: Dun Peal <dunpealer@gmail.com>
Subject: Why don't git-init and git-clone probe for core.ignorecase on Windows
 > XP?
Date: Fri, 7 Jan 2011 12:34:35 -0600
Message-ID: <AANLkTimqgCsmC96fkWQJ0yB+FuyC6Xkgn3UAfZrqMqK_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 07 19:34:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbH97-0002ZY-US
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 19:34:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755174Ab1AGSeg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 13:34:36 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:50691 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754667Ab1AGSeg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 13:34:36 -0500
Received: by qwa26 with SMTP id 26so18082872qwa.19
        for <git@vger.kernel.org>; Fri, 07 Jan 2011 10:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=BpswuvHEq0Q8iQFMuxnrILa68asZTmzHAC52Tiv6FBM=;
        b=Q39pfYbCZPznQHUu6RogEkMb6TMyrBSeZXmFcPR2JE3bFT+NKEin2YQRkizJXgFttj
         n7orvCIhI9WVZ9p3L06NGt8uswiOOWvQo1P4lJKBj9Sz76RSRQ2V2p2Zeg1FrFLpYyJu
         e/P69rgyf2ts+qZn5gjposkJnz7xsh5yZXOks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=sG1q22T4lIMnvLOEEdqkJjGGLCJUa8XliDS2XeSBY39kDJABtIolloOly1bYVZ0zlb
         9+QGDu3Bk73w5J37csdUO8uB/Rt/qzK1Sdsemrn32LJKArpbP5xyVQajnUPOTYua+gZa
         ZfZWgt5f5OYl+dLW78hIE+wyFH06Plb7B6aQM=
Received: by 10.224.28.70 with SMTP id l6mr8797721qac.49.1294425275337; Fri,
 07 Jan 2011 10:34:35 -0800 (PST)
Received: by 10.220.191.66 with HTTP; Fri, 7 Jan 2011 10:34:35 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164733>

Hello.

The git-config manpage says about core.ignorecase:

"The default is false, except git-clone(1) or git-init(1) will probe
and set core.ignorecase true if appropriate when the repository is
created."

I assume this is happening when you clone or init on FAT, which is
explicitly mentioned earlier in that section. But apparently it
doesn't happen for either XP, Vista or 7. While those newer releases
use NTFS, which technically supports case-sensitivity, the operating
itself still apparently doesn't, so it would seem like git-clone and
git-init should probe regarding the core.ignorecase on any version of
Windows, no?

Thanks, D
