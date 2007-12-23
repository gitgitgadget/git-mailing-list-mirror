From: "Kevin Williams" <kevwil@gmail.com>
Subject: gitk / git-gui and Tk 8.5 don't play nice together
Date: Sun, 23 Dec 2007 08:02:04 -0700
Message-ID: <683a886f0712230702q3cbae65v6d34f44dde520d81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 23 16:02:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6SLf-0001sC-EJ
	for gcvg-git-2@gmane.org; Sun, 23 Dec 2007 16:02:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758469AbXLWPCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Dec 2007 10:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758430AbXLWPCI
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Dec 2007 10:02:08 -0500
Received: from py-out-1112.google.com ([64.233.166.178]:3849 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758906AbXLWPCG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Dec 2007 10:02:06 -0500
Received: by py-out-1112.google.com with SMTP id u77so2164470pyb.16
        for <git@vger.kernel.org>; Sun, 23 Dec 2007 07:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=5EQc38ZlV9wvKrkRXbPTD8ZcpGP/lmRiul8q0EUeGIc=;
        b=Ni2rKKmBd5t0662vB5ScRt/IxHopEYvd3AdpF5S4yWEB0pDYQbJV1ArxO7WTyAFOcQCHdbR+Ju8l0Xp3r/apTITlom2L6g/NWqDE1PmuK3e6rJYFEB3gHk5zzA1CWYg4SL65Re8wDJUwkLAPltB36Arq+q7sdzJ8SUo0NTtt16I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=edKdjVoedW5MhKfQlUMPtoGOPu+/ZeKcUVfNR50fiiclsyW4WHpJL/aZKbSGsBpdH48HDGQGCj9d7nXJHTaVL12tR4MY+jX4obsdlAaZM8FmDsacNwlp7vsZP1InbAh3+yXc0YgNJi04xGa+F1GJ0fj1hEV86ecvSXFwcJ7A55M=
Received: by 10.142.47.6 with SMTP id u6mr1270838wfu.29.1198422124154;
        Sun, 23 Dec 2007 07:02:04 -0800 (PST)
Received: by 10.142.50.7 with HTTP; Sun, 23 Dec 2007 07:02:04 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69182>

X Error of failed request:  BadMatch (invalid parameter attributes)
  Major opcode of failed request:  152 (RENDER)
  Minor opcode of failed request:  4 (RenderCreatePicture)
  Serial number of failed request:  541
  Current serial number in output stream:  549


Is this a known issue? Do I need to file a bug report or something?
