From: Duy Nguyen <pclouds@gmail.com>
Subject: [BUG] redundant error message
Date: Thu, 5 Dec 2013 17:07:31 +0700
Message-ID: <CACsJy8BtCi_QSMZXfnscQmRyjvgSV1fG6smAOoCSab_e2YATxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 05 11:08:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoVqr-0007vD-B3
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 11:08:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753812Ab3LEKIF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Dec 2013 05:08:05 -0500
Received: from mail-qc0-f175.google.com ([209.85.216.175]:58143 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431Ab3LEKID (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 05:08:03 -0500
Received: by mail-qc0-f175.google.com with SMTP id e9so4566046qcy.6
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 02:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=nmFMquLn+dlP0KVe55AutrJTgs3pAt4NacnU9MJqmCo=;
        b=BUs2bt9FLRYbuXF4BAvZm9NCZjKNmftfaUdIBBT5WD+nN9czIEgxU/tKssugbkaE2c
         9QX3EpNv8Kz8ixehE5z8ECyoociDKzsoRATQ+GBIKTF4q9+0G48vLK679zRFFBh5i2Br
         bxOFmJj/7F6RfKAgEEj1ptIZdOWo7Ddyn3cfgpmB/cRwkYTBhjL5DX4QHrWv21VEd1rj
         XRC2dCROdcGofMitbX2vLSCo0ZCil3wQCc5HLMdrQd0D5cBKtc1exCW7qJziCmBJkngX
         bVXePUrUntpsbBukbv/c7z/eK/pbWFwXXWnpnZdZhAybyqizp3xZZt5VSQON9aNSTwLF
         vktQ==
X-Received: by 10.224.24.131 with SMTP id v3mr143995338qab.48.1386238081887;
 Thu, 05 Dec 2013 02:08:01 -0800 (PST)
Received: by 10.96.124.101 with HTTP; Thu, 5 Dec 2013 02:07:31 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238853>

$ git rev-parse foobar --
foobar
fatal: ambiguous argument 'foobar': unknown revision or path not in
the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'

I already put "--" there. So it should shut up.
-- 
Duy
