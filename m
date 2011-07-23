From: Jon Seymour <jon.seymour@gmail.com>
Subject: Is there a quick way to identify commits that reference missing trees
 or blobs?
Date: Sun, 24 Jul 2011 02:48:20 +1000
Message-ID: <CAH3AnroyfeGOo_23nHKhLjxEnP_qEMi7as1UjXEFjjuVOckBjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 23 18:52:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkfRc-0003ug-7H
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jul 2011 18:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136Ab1GWQsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jul 2011 12:48:22 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:64290 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087Ab1GWQsV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2011 12:48:21 -0400
Received: by vws1 with SMTP id 1so2236356vws.19
        for <git@vger.kernel.org>; Sat, 23 Jul 2011 09:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=3ygyoXi71jyu8n1cFRxbhTHkrpXS+4uG3vXO0NfS52g=;
        b=fCYJKuYNcRGaazWrBPULRBQmL9BAofTuPDTD2Jw7FP3jwofsMcXFgjtBY6GCA8Ar/K
         xTK5yTRd19djo9iALsJPpxAr/JbALWMDxDuxGw2IEDE6616YJWNrhYg4sPXfOFUudJP0
         DWNXSZsNFL3ujs9mdkVpL9znukkTuyyseDGA8=
Received: by 10.52.100.65 with SMTP id ew1mr2815770vdb.441.1311439700337; Sat,
 23 Jul 2011 09:48:20 -0700 (PDT)
Received: by 10.52.183.41 with HTTP; Sat, 23 Jul 2011 09:48:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177696>

I was wondering if there is a quick way to identify commits that
reference missing trees or blobs as identified by git fsck?

This would be quite useful in situations where one is trying to
salvage as much history as possible from a damaged repository.

jon.
