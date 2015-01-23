From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Git submodule first time update with proxy
Date: Thu, 22 Jan 2015 20:50:45 -0600
Message-ID: <CAHd499BEmV2zeosE9th59QTWPA0CPsU8eyHnONhsZqEb=bH+rA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 23 03:50:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEUKh-0006Tn-HT
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 03:50:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753758AbbAWCus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 21:50:48 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:55861 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbbAWCuq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 21:50:46 -0500
Received: by mail-ie0-f172.google.com with SMTP id rd18so5020610iec.3
        for <git@vger.kernel.org>; Thu, 22 Jan 2015 18:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=nsMd+L1UDb5goNx7GlHkiZAKOutxl9Weffwuo8hDNlo=;
        b=GmjPT/+zRvv3Uq38e+49uQl+0VCC5vd7Q8Rl9lRSz65kSjOZ7u9cYbRtMVQP9xYmYL
         VIDOZeBxyeKoLkRsf3OFz9dBW96D1jDt2yhI9zzx2vEM17iViRTRUkMyLu1BMSrvNeOc
         Taw4BboM6yUstMIux1uABjq7FhTOQs8jRVMIBrR1F92JO/JJKAdJ6hGdbob19yd93nQk
         tPOv2gS2IGACbTMAn5Q/eoh5bbb2tbTFAOEj/emCCsRfehxFhMrrh44gwHpCWz7EGch8
         sCIEnxR1kNzfFvScHeXMuFdPDn5L3vMkcrMJ3QjodJnc940DNE/g9scXoGi4Fu2uBld8
         w9DA==
X-Received: by 10.107.31.14 with SMTP id f14mr1463883iof.15.1421981445870;
 Thu, 22 Jan 2015 18:50:45 -0800 (PST)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.36.56.70 with HTTP; Thu, 22 Jan 2015 18:50:45 -0800 (PST)
X-Google-Sender-Auth: vbkBo-h4haI5ZH-Wl58eBPXz7CA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262900>

I have a submodule using HTTP URL. I do this:

$ git submodule init MySubmodule
$ git submodule update MySubmodule

The 2nd command fails because the HTTP URL cannot be resolved, this is
because it requires a proxy. I have "http.proxy" setup properly in the
.git/config of my parent git repository, so I was hoping the submodule
update function would have a way to specify it to inherit the proxy
value from the parent config.

How can I set up my submodule?
