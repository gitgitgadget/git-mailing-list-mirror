From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-commit.txt: Order options alphabetically
Date: Wed, 1 Dec 2010 10:50:43 -0600
Message-ID: <20101201165043.GF26120@burratino>
References: <1291215526-11428-1-git-send-email-jari.aalto@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: jari.aalto@cante.net
X-From: git-owner@vger.kernel.org Wed Dec 01 17:51:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNptS-0004lK-5E
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 17:50:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755103Ab0LAQuw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 11:50:52 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:38771 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990Ab0LAQuv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 11:50:51 -0500
Received: by ywl5 with SMTP id 5so3524757ywl.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 08:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=QuQFJnb3gZHRImk0q5s3zdKi5GiN12azDSrknrDGihQ=;
        b=e6MEat1Iy33i5o+envwhdQtbAujms3JN1GST1JWi1n4983G7q/pRAfeITwAqRcAU/F
         EYJmIo9ee3702Vyz7KMJF9yTPS1i2SZn5gEYYPYOzbPXZ2YdPqp0Clj72vizrAnKxeGq
         v2j/myoyaf1iVx2si7e1Z5Sgjl/yj/ZWuEezE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xMPtyp0S6SXsKVIGDC9dyPIjHDaOrbUEJgKJxWDufEL4qSOXXlS84JQxzor5J9kwLR
         HjA8NKvqLBrGfbU05NDdWu2uOD2UpED22PO7FPJUVNm732sQakG1P92WDRDadcsK7s2K
         7ujsphndcSJ87q5m9+49+al5fUl+Lgnvmbdx0=
Received: by 10.151.100.21 with SMTP id c21mr15024913ybm.400.1291222251264;
        Wed, 01 Dec 2010 08:50:51 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id v8sm100936yba.14.2010.12.01.08.50.49
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 08:50:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1291215526-11428-1-git-send-email-jari.aalto@cante.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162548>

Hi again,

jari.aalto@cante.net wrote:

> [Subject: [PATCH] git-commit.txt: Order options alphabetically]
>
> Signed-off-by: Jari Aalto <jari.aalto@cante.net>

Here's what Documentation/SubmittingPatches has to say.

	[...] patches which plainly describe the things that
	help reviewers check the patch, and future maintainers understand
	the code, are the most beautiful patches.  Descriptions that summarise
	the point in the subject well, and describe the motivation for the
	change, the approach taken by the change, and if relevant how this
	differs substantially from the prior version, can be found on Usenet
	archives back into the late 80's.  Consider it like good Netiquette,
	but for code.

Here, you've explained what the patch does, but not why.  How are
reviewers to evaluate whether it succeeded?

If the goal is sorted option lists in all manpages, that will _have_
to be automated.  Some manpages read some and not all of their options
from an external file.  But before we deal with that: why would I want
sorted option lists in all manpages?

Sorting can sometimes be an improvement; it just seems better to
mention the particulars of the situation and why sorting rather than
some thematic grouping is appropriate in a given case.

Hope that helps,
Jonathan
