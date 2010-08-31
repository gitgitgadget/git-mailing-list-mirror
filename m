From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: format of git pack objects
Date: Wed, 1 Sep 2010 00:17:25 +0100
Message-ID: <AANLkTimNnUYoBa1VfZeBb=eD=HymOU_h57bthYFC9jUZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 01 01:17:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oqa5M-0001ud-Vg
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 01:17:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756104Ab0HaXR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 19:17:27 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45367 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782Ab0HaXR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 19:17:26 -0400
Received: by vws3 with SMTP id 3so5908515vws.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 16:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=SvZ2bMi91BWbnjxjzNUJ54ydV29aMQ7qzaw8/nCyTUo=;
        b=iH1/VqNmcSmlQy6oTG8zXEyJYO2l/NHTIRKUh/EQFhOoVF41ZFX34yyRNfLkVUCEs8
         xnIkKdgboEGpHDj+4+wLhGcrNxPVNwcBWwl84zxmfNbMizpvmsAfdjsqx8TFvl7EkRpj
         rvOl+MIC8aYiOqCmnJFCzAReaYe4zJE+T1zfM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=rkqNoa4Ss4K13ZSBchsONCD6SNT+yGlMkc42WyQu5UrZiSFXYBtt2s6ZxtoCNitjMm
         ZpmrNqfs7UoDoS71wXxkA7oPYiMP6+6hLrDFExwEAvwuYu2S+5qDcXZ9SsHlV9FQDjbu
         le4wzcymR07HXaIFgZWLh8apSm143j/Jw6f04=
Received: by 10.220.63.142 with SMTP id b14mr3798694vci.174.1283296645988;
 Tue, 31 Aug 2010 16:17:25 -0700 (PDT)
Received: by 10.220.98.14 with HTTP; Tue, 31 Aug 2010 16:17:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154993>

hi folks,

where can i get information (specifications) on the format of git
pack-objects... please don't say "look at the source code" unless
there simply doesn't exist any format specifications.  as part of the
git p2p bittorrent vfs layer stuff, a "file save" operation doesn't
"happen by magic": i need to actually verify the pack objects
received: count the number of entries?  or do i?

tia,

l.
