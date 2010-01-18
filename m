From: John Tapsell <johnflux@gmail.com>
Subject: git describe --contains
Date: Mon, 18 Jan 2010 23:37:04 +0000
Message-ID: <43d8ce651001181537w667f71b7te7fac56b4f562c30@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 19 00:43:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NX1Fc-0003AC-FQ
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 00:43:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077Ab0ARXnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 18:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752973Ab0ARXnJ
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 18:43:09 -0500
Received: from mail-pz0-f197.google.com ([209.85.222.197]:38368 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394Ab0ARXnI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2010 18:43:08 -0500
X-Greylist: delayed 358 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Jan 2010 18:43:08 EST
Received: by pzk35 with SMTP id 35so2722267pzk.22
        for <git@vger.kernel.org>; Mon, 18 Jan 2010 15:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=SBcFcpMmwt/bDN1/4sH1xmyDXyS0WwQojSRpRPYwLK4=;
        b=Kfa7pnuSxrP2l1b7XE43jj+ISCCYPIeoU4LOOh5FXFzevNEMj8IUCNFIhC6BgX1Q5/
         IiBxGyZ/1CqDhKLk/aXBtpWAjhzhmgoyvCZZP3wxTgOOsVFZ9GskmTgnvu7CxKI5JoZH
         s11l7Bq/B4XpJEu/XSHYUXncEKYbr1zr1Pupg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=e1Fk7hNlYB1NgROHw9wZLzQgLwuUKvhZt4077C5InicrDgqsJTYD/s0sm4qTHieyyb
         VCgk4MDvaj+4sigTzQ/WMmYa1l1q2kwkdzA9i4ncSg/FfVqavQCa25MfIC1tg4w+mwHB
         BHbIugCeGXPCw+xzTEWIbgeSEYj/ewa7nDvAo=
Received: by 10.114.165.18 with SMTP id n18mr4543000wae.154.1263857824673; 
	Mon, 18 Jan 2010 15:37:04 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137412>

Hi all,

Doing:   git describe --contains SHA

on a SHA that is not contained by any tags gives a confusing error
message that it cannot describe the SHA.
Could this error message be changed please to just say something like
"SHA1 is not in any tags."
