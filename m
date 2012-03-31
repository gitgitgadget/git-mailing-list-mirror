From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/2] Re: Documentation: replace 'vi' for 'editor' to reflect
 build-time option
Date: Sat, 31 Mar 2012 03:40:15 -0500
Message-ID: <20120331084015.GC4119@burratino>
References: <20120330002543.2138.91961.reportbug@localhost6.localdomain6>
 <20120330005523.GA28519@burratino>
 <7v398qq1ei.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Rodrigo Silva (MestreLion)" <linux@rodrigosilva.com>,
	git@vger.kernel.org, Ben Walton <bwalton@artsci.utoronto.ca>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 10:40:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDtrK-0000t5-5b
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 10:40:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754780Ab2CaIkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Mar 2012 04:40:24 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42772 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754288Ab2CaIkT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2012 04:40:19 -0400
Received: by iagz16 with SMTP id z16so1962815iag.19
        for <git@vger.kernel.org>; Sat, 31 Mar 2012 01:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=OKnOKOEY7B65f17/pQ28CDXNeonC49xpBzbqWTskhzs=;
        b=gKznoRBSrZpNBHdHb2y0L8YWQ9XG0KcoUpvPnaafje67lr+ytALTj4FpUV7b72vepo
         MCG5N4jHkstuLStCFF020oHyeU1oJoNHEuCFR6M28t3WXd2BSSwh7Sffy/f8i+vorC1i
         G8oPhaMirOtrXRVpHZ/csqdO2KIqh/D09XJ1Pv5PenOYsA2hweKmLcxdVqdjp7x5GXbB
         LfE3QraesTcgZbBX7wf0sT1YUCCZ6MbEDsW4cl/Vrn882wS+K3hWWcoEGGx9hGU4CYQW
         lEWes8xM/Z+7KpsZ3DlAEHruoSCkNmfjuzQ3e+B8PuD7aL9ENPRbMs2mvVcx0LOcCUIR
         Xb4g==
Received: by 10.50.186.168 with SMTP id fl8mr820040igc.68.1333183219340;
        Sat, 31 Mar 2012 01:40:19 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ke7sm4873044igc.10.2012.03.31.01.40.18
        (version=SSLv3 cipher=OTHER);
        Sat, 31 Mar 2012 01:40:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v398qq1ei.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194438>

Junio C Hamano wrote:

> I've already rejected this patch once, but that was primarily because the
> patch was not justified with the above "I read everybody else's git uses
> 'vi' on the Interweb, and even though my distro's manual page says it uses
> 'nano', I didn't bother to read it." scenario.

Thanks.  Here's a pair of patches meant to combine the advantages of
both approaches. ;-)

Thoughts and improvements welcome, of course.

Sincerely,
Jonathan Nieder (2):
  var doc: default editor and pager are configurable at build time
  var doc: advertise current DEFAULT_PAGER and DEFAULT_EDITOR settings

 Documentation/Makefile    |   10 ++++++++++
 Documentation/git-var.txt |   16 ++++++++++++++--
 Makefile                  |    2 ++
 3 files changed, 26 insertions(+), 2 deletions(-)
