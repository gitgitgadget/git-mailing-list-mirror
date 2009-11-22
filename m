From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH 0/4] Update documentation of apply
Date: Sun, 22 Nov 2009 17:18:58 +0100
Message-ID: <4B096472.7080402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 22 17:19:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCF9W-0001SL-So
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 17:19:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755275AbZKVQSz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Nov 2009 11:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754571AbZKVQSz
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 11:18:55 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:57667 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754478AbZKVQSz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 11:18:55 -0500
Received: by ewy19 with SMTP id 19so1079490ewy.21
        for <git@vger.kernel.org>; Sun, 22 Nov 2009 08:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=O8W+j1A/yacszPqbnuaDOxTxHx0LZfVyRpexnj50RKA=;
        b=ma3iZxxBeQuSo6xJG36rcmHnnueFeUi3CFoJWUWO3q/AHscdWA0bNb2v3RsFjUZDmY
         oV1OakaCkOUh1PNQyqaRGddKrdLaNfO0jgiy1ALb2V+/ChiDGGAikOMcJQXJeX+UjKpj
         jrJ1+/mTUp84n8fPD4VMswwkiH0pFG0UUnovo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=OeQ9+pH1eEKEf12Z+RVi+xd/B2RMaz96pZl/clhWocG/nirOWrQ/N0x9irDvaxgCBL
         bnQiF66bZQUwThfarOUOuvWlHGV4hqq9kptYDvNy42SD/lm7px0m83HNZsVlJl++lif6
         1NjTVPMRNYItTEl5PFl2j4NB4bjP2rWETBKVI=
Received: by 10.213.25.66 with SMTP id y2mr2535113ebb.97.1258906740196;
        Sun, 22 Nov 2009 08:19:00 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 10sm835196eyz.23.2009.11.22.08.18.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Nov 2009 08:18:59 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133438>

The following patch series improves the documentation of 'git apply'.

Bj=C3=B6rn Gustavsson (4):
  apply: Clarify the description of -z
  apply: apply works outside a repository
  apply: Use the term "working tree" consistently
  apply: Format all options using back-quotes

 Documentation/git-apply.txt |   38 ++++++++++++++++++++++-------------=
---
 1 files changed, 22 insertions(+), 16 deletions(-)
