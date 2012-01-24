From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/5] t0061: Fix incorrect indentation
Date: Tue, 24 Jan 2012 16:40:00 -0600
Message-ID: <20120124224000.GE8222@burratino>
References: <1327444346-6243-1-git-send-email-fransklaver@gmail.com>
 <1327444346-6243-2-git-send-email-fransklaver@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Junio C. Hamano" <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Frans Klaver <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 24 23:40:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rpp2L-0000vV-8V
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 23:40:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244Ab2AXWkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 17:40:15 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51090 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870Ab2AXWkO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 17:40:14 -0500
Received: by ghrr11 with SMTP id r11so1110288ghr.19
        for <git@vger.kernel.org>; Tue, 24 Jan 2012 14:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=emaeseqCWwKgtnJ2btKfllHD8/wXgR7PQdYRkLpEFIM=;
        b=a6FZfslMO1MCOm3Ud5uO4X8K9nP5nyDdFZZ3Mg3+JPDEQqLWZJpwD74OeRDq8FfjUy
         y/clUipHvbWtd4UHBhVfazeeeREhQ/vBXBri4JAE11RTwozBxY86nBfDWgbShS09lP8Z
         6d3273Usa66ZbQkAUi5FLW057pzWgYhmR5mp8=
Received: by 10.236.187.67 with SMTP id x43mr21061277yhm.94.1327444813883;
        Tue, 24 Jan 2012 14:40:13 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id o16sm48612722ank.14.2012.01.24.14.40.12
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jan 2012 14:40:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1327444346-6243-2-git-send-email-fransklaver@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189083>

Frans Klaver wrote:

> +++ b/t/t0061-run-command.sh
> @@ -8,8 +8,8 @@ test_description='Test run command'
> . ./test-lib.sh
>
> cat >hello-script <<-EOF
> -	#!$SHELL_PATH
> -	cat hello-script
> +#!$SHELL_PATH
> +cat hello-script
>  EOF

Looks like a no-op --- the script already started with #! and no
leading tab for me.  Does it behave differently on your machine?
