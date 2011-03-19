From: Stefan Sperling <stsp@stsp.name>
Subject: Re: [PATCH] Include headers for getrlimit() in sha1_file.c
Date: Sat, 19 Mar 2011 10:09:27 +0100
Message-ID: <20110319090927.GA521@jack.stsp.name>
References: <1300271879-2050-1-git-send-email-stsp@stsp.name>
 <20110318202351.GA22696@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 10:10:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0sBT-0008OH-E0
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 10:10:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755886Ab1CSJKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 05:10:51 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:55988 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754564Ab1CSJKt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 05:10:49 -0400
X-Envelope-From: stsp@stsp.name
Received: from jack.stsp.name (jack.stsp.name [217.197.84.35])
	(authenticated bits=128)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p2J9AB12025594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 19 Mar 2011 10:10:41 +0100
Received: from jack.stsp.name (stsp@localhost [127.0.0.1])
	by jack.stsp.name (8.14.3/8.14.3) with ESMTP id p2J99V55008560;
	Sat, 19 Mar 2011 10:09:32 +0100 (CET)
Received: (from stsp@localhost)
	by jack.stsp.name (8.14.3/8.14.3/Submit) id p2J99Rl0014001;
	Sat, 19 Mar 2011 10:09:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20110318202351.GA22696@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169421>

On Fri, Mar 18, 2011 at 03:23:52PM -0500, Jonathan Nieder wrote:
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 49b50ee..40498b3 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -118,6 +118,7 @@
>  #endif
>  #ifndef __MINGW32__
>  #include <sys/wait.h>
> +#include <sys/resource.h>
>  #include <sys/socket.h>
>  #include <sys/ioctl.h>
>  #include <termios.h>

Works for me. Thanks.
