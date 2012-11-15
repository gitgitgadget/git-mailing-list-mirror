From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: use cases for git namespaces
Date: Thu, 15 Nov 2012 14:03:32 +0530
Message-ID: <CAMK1S_gczLajro0aZ5ftUmt_vhxA+yAr_5pCZknJ2bxhykYRXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 15 09:34:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYutd-0003xB-IW
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 09:34:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756084Ab2KOIdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 03:33:43 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:48770 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756020Ab2KOIde (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 03:33:34 -0500
Received: by mail-ee0-f46.google.com with SMTP id b15so802357eek.19
        for <git@vger.kernel.org>; Thu, 15 Nov 2012 00:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=foO2k1D/1wGYAzdoUd+kS7MQcemwiKWjL9GsCDVC080=;
        b=WvZhxVwtRQ8l2xwbU2XIISKfGqOwSEqEOAMsjWdwSl8/atckiO3DRhGtWpyyfxX/bw
         0qwlsRnznxLNoowQBUcKRkXdUtMDsKvx0u/7Ee6nfi1gQX0xDKZcx2GHEv7ViXBY5r1e
         IA6yVnEFsJb2aBPq3iGooQeINNATYEWlsFOTAhOk2tMeDziWhKe515P7WGNiamCNc3eu
         FL9WrBTzPmNruYeLlAZCatuLP/m0szhjHiLSJ3GnDrHsAMT1NyoD8Er8hmm3j59tFOEU
         6A1o0ekzP1Izfzxbhx8N/5UigCqktiCyt7NsF7Vk4FfRCZHhdmw8/oMEKrDm8rwj5Vby
         uW5w==
Received: by 10.14.209.201 with SMTP id s49mr1749565eeo.7.1352968413042; Thu,
 15 Nov 2012 00:33:33 -0800 (PST)
Received: by 10.223.132.211 with HTTP; Thu, 15 Nov 2012 00:33:32 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209811>

Hi,

It seems to me that whatever namespaces can do, can functionally be
done using just a subdirectory of branches.   The only real
differences I can see are (a) a client sees less branch clutter, and
(b) a fetch/clone pulls down less if the big stuff is in another
namespace.

I would like to understand what other uses/reasons were thought of.

I looked for discussion on the ml archives.  I found the patch series
but could not easily find much *discussion* of the feature and its
design.  I found one post [1] that indicated that "part of the
rationale..." (being what I described above), but I would like to
understand the *rest* of the rationale.

Pointers to gmane are also fine, or brief descriptions of uses [being]
made of this.

[1]: http://article.gmane.org/gmane.comp.version-control.git/175832/match=namespace

Thanks

-- 
Sitaram
