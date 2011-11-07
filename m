From: Ori Avtalion <ori@avtalion.name>
Subject: git-apply that handles rejects like merge conflicts
Date: Tue, 08 Nov 2011 00:10:48 +0200
Message-ID: <4EB85768.1060508@avtalion.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 07 23:10:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNXP7-0002ix-Lm
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 23:10:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464Ab1KGWKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 17:10:53 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33614 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041Ab1KGWKw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 17:10:52 -0500
Received: by faan17 with SMTP id n17so482834faa.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 14:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=6cWz4dSQRudLA32688uODfW49vhoruLevtDzjyZPjlo=;
        b=JzBkUHq/hlRqlANAP5MXVDnipnjHCYBfOcKvzKS8JYHiAi4KEl1mbKTknboNaRIC9G
         RNj1zSEY3D3XcTmhLKQDUvz2WU8TQUy1q7cSaOzP5ygyDZPLRvXeSTY7R1ptpgxv2Te9
         46UyH0Sqg+jvTKk3qZSP7ONCxmwYyY6L0bZ2k=
Received: by 10.223.76.66 with SMTP id b2mr51029136fak.15.1320703851240;
        Mon, 07 Nov 2011 14:10:51 -0800 (PST)
Received: from [192.168.1.55] (bzq-79-179-20-244.red.bezeqint.net. [79.179.20.244])
        by mx.google.com with ESMTPS id l18sm33031021fab.9.2011.11.07.14.10.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 07 Nov 2011 14:10:50 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185040>

Hey,

I'm trying to get git-apply to apply patches, and let me handle the
conflicts in a way I'm comfortable with -- by staging the "successful"
hunks and leaving conflict markers in the working tree.

With the available flags, I seem to only be able to have successful
hunks in the index, and rejected ones in patch-like .rej files.

Is there a way to accomplish this? If not, does anyone think it's a good
idea?

-Ori
