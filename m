From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: Summary of the problems with git pull
Date: Sat, 10 May 2014 03:53:23 -0500
Message-ID: <536de90320f06_239010732fc82@nysa.notmuch>
References: <5366db742d494_18f9e4b308aa@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "W. Trevor King" <wking@tremily.us>,
	Philip Oakley <philipoakley@iee.org>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Richard Hansen <rhansen@bbn.com>, Andreas Krey <a.krey@gmx.de>,
	Marat Radchenko <marat@slonopotamus.org>
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 10 10:53:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wj32S-0005wf-B8
	for gcvg-git-2@plane.gmane.org; Sat, 10 May 2014 10:53:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754510AbaEJIxc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2014 04:53:32 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:49016 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754295AbaEJIxa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2014 04:53:30 -0400
Received: by mail-ig0-f181.google.com with SMTP id h3so2073112igd.2
        for <git@vger.kernel.org>; Sat, 10 May 2014 01:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=iOh3FXv+sSYqD9yfUQAhihsfLSfMNshelKpn+wRd2Tw=;
        b=WP6yTcpo6EA9bed5YnQyUjYok49yFMsgIIku1sKs+P5EsACnvl4NmU9iChANIbhJoL
         ojXxOO85pjQjQBboMzCXMTtHf/F/iE9p4lcu4C5S3++r17D+/A4qBd8wr6gkqs7/Oun6
         H4zBA9/0pBWuLbMgAMBks43pA9fmbrLQFaKgr/zhCh2glk5kmLYVjCc9ikgRg76YUll7
         hME1vturxI4qJEDvfvRGVBXvWBOKdTD4RnCVY9XMW66fNAwqv+VF2xNgw7rMMExJBifY
         IvaZureXVbUW+2kNg9s6dNmGA5f5qpNjxDcHY/XIAje6PbWS8HN/vhVdtCHtlO0ePXKC
         FZXw==
X-Received: by 10.50.61.141 with SMTP id p13mr19094102igr.38.1399712010212;
        Sat, 10 May 2014 01:53:30 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id vc5sm5282379igb.3.2014.05.10.01.53.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 May 2014 01:53:28 -0700 (PDT)
In-Reply-To: <5366db742d494_18f9e4b308aa@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248654>

Felipe Contreras wrote:
> == git update ==
> 
> Another proposed solution is to have a new command: `git update`. This
> command would be similar to `git pull --ff-only` by default, but it
> could be configured to do merges instead, and when doing so in reverse.

And here it is:

https://github.com/felipec/git/commits/fc/update

Here's the documentation:

https://github.com/felipec/git/wiki/git-update

Works exactly as expected: non-fast-forwards are rejected by default,
but can be configured, and parents are reversed when merging.

-- 
Felipe Contreras
