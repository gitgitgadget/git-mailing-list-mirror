From: Daniele Segato <daniele.segato@gmail.com>
Subject: Re: [PATCHv3] git-tag man: when to use lightweight or annotated tags
Date: Fri, 26 Jul 2013 19:33:01 +0200
Message-ID: <51F2B2CD.1030004@gmail.com>
References: <51EFA9A9.4010103@gmail.com> <7vtxjj66kn.fsf@alter.siamese.dyndns.org> <51F12BE6.80606@gmail.com> <51F13A8F.9040400@xiplink.com> <51F23706.5040009@gmail.com> <51F2375E.1080003@gmail.com> <51F28D08.8050507@xiplink.com> <51F2AFBA.4020602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 26 19:33:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2ltA-0001T9-Nr
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 19:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757083Ab3GZRdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 13:33:09 -0400
Received: from mail-bk0-f41.google.com ([209.85.214.41]:61760 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752229Ab3GZRdG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 13:33:06 -0400
Received: by mail-bk0-f41.google.com with SMTP id jc3so1237321bkc.0
        for <git@vger.kernel.org>; Fri, 26 Jul 2013 10:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=rrX3XI6P6Y7P9sT80hN9ccZw2XRpbdvT7kXb+rDANpU=;
        b=sbdJp85Z19eRJxV1PzV6JAQAgXLNzT4q7ry7LfM4xBqbOd9sAHBuEwcFkxaIJEpkvb
         YhtaWfq1ZQAZPdrZY9iP5tTbrCofOS5oqK5MvPUDyKw4X9V+0OAaaUj05WFCWskL5s18
         pSQzuoFIfpriehydLZgbS/V9JUudER/aSJlnz1AXDiqGpyyRxE4BZR41owFCC0ihe7Z+
         bkbXj+Jy5XYIDdMKfPcrgDRZaT/0azOErBZ3kiMU2vhO74+TPNWp+j3Y6aFb2zI92Hhd
         yoNGFF/WxpFS0LHHEb0BcADQTpGwNEIbJthoUE209A9PmKGnBEMEOwuAuTngtnL9D2N8
         yNgQ==
X-Received: by 10.205.118.201 with SMTP id fr9mr7348953bkc.84.1374859984918;
        Fri, 26 Jul 2013 10:33:04 -0700 (PDT)
Received: from [192.168.1.16] (host22-75-dynamic.4-87-r.retail.telecomitalia.it. [87.4.75.22])
        by mx.google.com with ESMTPSA id fc7sm12731200bkc.3.2013.07.26.10.33.02
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 26 Jul 2013 10:33:04 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <51F2AFBA.4020602@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231191>

stress the difference between the two with suggestion on when the user
should use one in place of the other.

Signed-off-by: Daniele Segato <daniele.segato@gmail.com>
---
  Documentation/git-tag.txt |    9 +++++++++
  1 file changed, 9 insertions(+)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 22894cb..495eb71 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -42,6 +42,15 @@ committer identity for the current user is used to 
find the
  GnuPG key for signing. 	The configuration variable `gpg.program`
  is used to specify custom GnuPG binary.

+The tag objects (created with `-a`, `s`, or `-u`) are called 
'annotated' tags,
+they contains a creation date, the tagger name and e-mail, a tagging 
message
+and, eventually, the GNUPG signing and verification data. While a
+'lightweight' tag is simply a name for an object (usually a commit object).
+
+'Annotated' tag are meant for release while 'lightweight' tags are meant
+for private or temporary object labels, thus most git commands ignore
+lightweight tags by default.
+

  OPTIONS
  -------
-- 
1.7.10.4
