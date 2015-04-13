From: Julian Gindi <juliangindi@gmail.com>
Subject: Re: [PATCH v3] CodingGuidelines: update 'rough' rule count
Date: Mon, 13 Apr 2015 08:54:14 -0400
Message-ID: <20150413125414.GA1038@Serenity.local>
References: <20150412234720.GA37658@Serenity.local>
 <CAPig+cS=xBoe-hr5Kwm0N9hBUy4bzN1NoXTcDEwz_4ZwrrXPXA@mail.gmail.com>
 <20150413042644.GA39596@Serenity.local>
 <CAPig+cTgNzO5NGabOsaSZOq7Y47OBXJz9mnS-MfpoQ2MANzrng@mail.gmail.com>
 <CAPig+cQ3z_UuUMZE_jUGbv1_3Fu_32GSw2ysSixw4VE0opz27w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 14:54:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yhdsi-0005s2-Hc
	for gcvg-git-2@plane.gmane.org; Mon, 13 Apr 2015 14:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753642AbbDMMyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2015 08:54:23 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:33912 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174AbbDMMyW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2015 08:54:22 -0400
Received: by qkgx75 with SMTP id x75so177456586qkg.1
        for <git@vger.kernel.org>; Mon, 13 Apr 2015 05:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=dQw1oG+hUu0owbPM/DLi1jAneUYQo/tvCt5EbHeo/Ho=;
        b=hWLZP+4Ojcdb6Ek2hwwEnHLzHCez2VGxSkOrJmvtrI5uROaLHBv7lD1kKaS4/aVcuk
         PW+H6JnjliPKeO+2wTjLn5CWFx+gmysgG/edSfftMPc5YaYpy3cvHh28dMPRQRtDw7JW
         bgVS/YjE4EI4Gi9BG3UeAN2F+DC8GrFRxUmFglCH98F5WqEgIGUh4a3vY4uKjNKdkdp9
         xu55CkFIPalVNzDZMIsTme/nUiZ17OMl4LMGe1GvNZ9OFd+MTh6RkeclMM7Rc/1Wb4kV
         +y8fiKJFtk5A70AYwkgxyfKBsSzDFZ9WmnW7BnVtv7TBbKMddXayNzPunjAnzZ6Gn7Yo
         fFew==
X-Received: by 10.140.94.211 with SMTP id g77mr17360197qge.2.1428929656848;
        Mon, 13 Apr 2015 05:54:16 -0700 (PDT)
Received: from localhost (static-108-45-111-234.washdc.fios.verizon.net. [108.45.111.234])
        by mx.google.com with ESMTPSA id t97sm5737617qgd.41.2015.04.13.05.54.15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Apr 2015 05:54:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPig+cQ3z_UuUMZE_jUGbv1_3Fu_32GSw2ysSixw4VE0opz27w@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267078>

Changed inaccurate count of "rough rules" from three to the more
generic 'a few'.

Signed-off-by: Julian Gindi <juliangindi@gmail.com>
---
 Documentation/CodingGuidelines | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 0f8cccf..2dd35bd 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -1,5 +1,5 @@
 Like other projects, we also have some guidelines to keep to the
-code.  For Git in general, three rough rules are:
+code.  For Git in general, a few rough rules are:
 
  - Most importantly, we never say "It's in POSIX; we'll happily
    ignore your needs should your system not conform to it."
-- 
2.3.5
