From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] qgit: Default the log window to wider than the file list and set monospaced font
Date: Thu, 8 Feb 2007 09:39:50 +0100
Message-ID: <e5bfff550702080039l236b1f69o6765b8e2dff3e3c4@mail.gmail.com>
References: <200702072138.36787.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andy Parkins" <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 08 09:39:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HF4ov-0005lT-3o
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 09:39:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423045AbXBHIjx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 03:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423051AbXBHIjw
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 03:39:52 -0500
Received: from wx-out-0506.google.com ([66.249.82.239]:48852 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423045AbXBHIjw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 03:39:52 -0500
Received: by wx-out-0506.google.com with SMTP id h31so429420wxd
        for <git@vger.kernel.org>; Thu, 08 Feb 2007 00:39:51 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Tb5D5vRRR0vcIgZ+rKpzkxNL2yjhuA7DZZhxyQE4JVOYpS3sVSLMTu5m7KKYPRCOT1AAbQv9Cc61ajIRFRouIMllrj3w/mtb578yD7GPF5LCgqhBYbYdF8gKcI+/0rE08E02gBjFgD83gKtwyxRlE57zEYUNuo75k7ZxkVsF5Bs=
Received: by 10.114.202.15 with SMTP id z15mr3474137waf.1170923991032;
        Thu, 08 Feb 2007 00:39:51 -0800 (PST)
Received: by 10.114.60.16 with HTTP; Thu, 8 Feb 2007 00:39:50 -0800 (PST)
In-Reply-To: <200702072138.36787.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39049>

>
> The font for the log viewer is set to "Monospace", but this should
> really be done in software and given a config setting (perhaps use the
> patch view font)
>

Thanks Andy for patches, I will apply as soon as I have access to my
box, probably this evening.

Regarding "Monospace" it should be changeable with Settings menu and
should apply _only_ to fixed space font viewers, in our case only
patch viewer and file content viewer.

Other fonts used in qgit are derived from system wide settings and are
changeable with qtconfig tool.

If you see Monospace applied to list view or any other widget apart
from the above mentioned ones then it's a bug.

Thanks
Marco
