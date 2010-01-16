From: Paul Richards <paul.richards@gmail.com>
Subject: Stamp Git commit id into file during build process
Date: Sat, 16 Jan 2010 18:50:48 +0000
Message-ID: <a1138db31001161050i73eade1bif968ca1256dcef2c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 16 19:50:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWDjc-0003bp-6Y
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 19:50:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756206Ab0APSuw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 13:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756179Ab0APSuw
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 13:50:52 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:36536 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756190Ab0APSuv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 13:50:51 -0500
Received: by ewy19 with SMTP id 19so1940312ewy.21
        for <git@vger.kernel.org>; Sat, 16 Jan 2010 10:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=St/es4xquAafFyJt8yOa8XrcFk2YZe75+/LwEHdoGXI=;
        b=TYR60w7kHVezILS3AzgbKgdl8hmToJdRHHmooeIRtopfiWgN4d+v0bPFV/njfh+b54
         GdUBmWG3IzbPzQR7wZDq/5jGvM7sqgWyPwj15WtORsFmlqNx1Ee/LGMufUihqiaL52VU
         24C1x3Rf9azOta/aqp3TPxysiaBzdigMYMMqY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=QuMNMnoSH7av7X3sGDCL3HHGesRthhpK6WoS6NOYB1NDJsPGXd7uODQAaxetAKhJ4b
         Yf7pF168wcjQCrzaYJwNLar+DFMv5SOLGCg3fgmDo0q2/6aZTrptRMl4T4pKydTLSmxD
         qt41S3ZrbqjYCk6KO7VtOGVV/+rB4gGk3HYi8=
Received: by 10.213.110.11 with SMTP id l11mr1423004ebp.84.1263667848238; Sat, 
	16 Jan 2010 10:50:48 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137249>

Hi,
I am in the process of migrating from Subversion to Git.  One thing I
am unsure of is how to stamp the 'version' or 'commit id' into a file
as part of a build process.

With subversion I used the SubWCRev tool from TortoiseSVN
(http://tortoisesvn.net/docs/release/TortoiseSVN_en/tsvn-subwcrev.html).

With Git I imagine that I'd like to put a copy of the current commit
id (either the full hash or a truncated version of that) into a file
which then gets included into the program source code in some way.

Is there a recommended way of doing this with git?  Perhaps with
something similar to SubWCRev?

Currently I am thinking about using "git log", and grepping the output
in some way so that I just get the hash.

Thanks in advance,


-- 
Paul Richards
