From: David Michael <fedora.dm0@gmail.com>
Subject: Build fixes for another obscure Unix
Date: Thu, 13 Dec 2012 10:22:44 -0500
Message-ID: <CAEvUa7nn9M5np3wD=Z1152K4pwNGhSKkC=rS9U=yc=UcaOxMCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 13 16:23:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjAdG-0006PN-5x
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 16:23:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756217Ab2LMPWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2012 10:22:47 -0500
Received: from mail-vb0-f46.google.com ([209.85.212.46]:60882 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756026Ab2LMPWp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2012 10:22:45 -0500
Received: by mail-vb0-f46.google.com with SMTP id b13so2391015vby.19
        for <git@vger.kernel.org>; Thu, 13 Dec 2012 07:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=tQLp/1O1t/vc3y6b+wuImYDAGevDqNifLFQnHOtLX9I=;
        b=pl1Kp8+DFmTRi1EvMCflLLDPRVr1aMwQ3UM0Yl5dL0etSjnAL/9lpz9HjUjv/oJXl5
         rUk2QRPGQgmZZv01/9H24nn7F4VbNWbsoWns+XTcRPjzCHzEKfa0NPLD8wsrweqc3Yqy
         VFvE5cW5iFmwSdAPOniu3lmlhUE8d2pTrfcjODeAJWPRD30SaWOVGaR0NTV+tsGCRRFj
         GJfB+ncpL01uWbs4OPQgMneHyiyIVVDrkV5/EgoyrjcEhmWxvS3azeOs7X78QDvaeaEP
         7sPEKsjwnETDXVXCBVbjCjOsShvOBmW9xfkttiHC7NECdmkwnsdSUT47dVIDTVT4Cn80
         0MPA==
Received: by 10.52.98.36 with SMTP id ef4mr3355641vdb.104.1355412164982; Thu,
 13 Dec 2012 07:22:44 -0800 (PST)
Received: by 10.58.85.138 with HTTP; Thu, 13 Dec 2012 07:22:44 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211454>

Hi,

I've been experimenting with git running on z/OS USS.  It is not yet
stable, but I have had to make a few fixes and generalizations in the
build system to get it to compile.

Would there be any interest in applying such individual compatibility
fixes for this system, even if a full port doesn't reach completion?

Thanks.

David
