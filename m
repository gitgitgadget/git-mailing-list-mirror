From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Compiling fails on SunOS
Date: Fri, 25 Feb 2011 03:57:37 -0600
Message-ID: <20110225095731.GC2908@elie>
References: <20110225100954.37c00fea@glyph>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marco <netuse@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Feb 25 10:58:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsuRE-000509-Cm
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 10:58:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434Ab1BYJ5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 04:57:48 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:63016 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754271Ab1BYJ5p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Feb 2011 04:57:45 -0500
Received: by qyg14 with SMTP id 14so1335649qyg.19
        for <git@vger.kernel.org>; Fri, 25 Feb 2011 01:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=QyjMS20T03cYyPYAWi/7pMZRV7JHZlgDKzhSye14p2Y=;
        b=o6Mubjso9dn7XbQpRFZDBZUJyRfhdatorlKoNFjnlDw9TQlkSLauWtNzFo/OeBiR38
         b3JasaGOOQ5hpFnMSWYgNEpUONmHzq7Tso0BgxwraaRTc3oIooz6qp8SjrGdB2d+Oqh+
         8sZ645eDFp3kFv92boHwx/l46J36KZ7+Ygjdg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=wUgWm7sOd1qzDmQThC4d2w1fk3nqV16Kqh8pdjAJFvbOG6kOpdWmd9IVMLgKPS0PM6
         LxciQvGeacmXsEAk6SH9GZgafhKTmGLkgNJq47nKeJnEmlUNocL2BfEUfDZOqG9oEm8j
         +dmxOFxfvJmuV2t64m8iM30pgRRFAZJziFkkc=
Received: by 10.229.240.85 with SMTP id kz21mr1676733qcb.2.1298627864697;
        Fri, 25 Feb 2011 01:57:44 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.sbcglobal.net [69.209.53.52])
        by mx.google.com with ESMTPS id nb15sm393459qcb.14.2011.02.25.01.57.43
        (version=SSLv3 cipher=OTHER);
        Fri, 25 Feb 2011 01:57:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110225100954.37c00fea@glyph>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167895>

Marco wrote:

> Are there any known workarounds or solutions?

Random guess: have you tried running "gmake"?

Alternatively, you might want to add the path containing your
locally installed "make" to SANE_TOOL_PATH, for example by writing
the following to config.mak:

	SANE_TOOL_PATH = /path/to/good/tools:/usr/xpg6/bin:/usr/xpg4/bin

Hope that helps,
Jonathan
