From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] completion: cleanup __gitcomp*
Date: Sun, 29 Jan 2012 20:42:42 -0600
Message-ID: <20120130024242.GA15896@burratino>
References: <1327883371-25573-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 03:43:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrhCt-0000uN-8Z
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 03:42:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753202Ab2A3Cmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jan 2012 21:42:54 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63836 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999Ab2A3Cmy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2012 21:42:54 -0500
Received: by ggnb1 with SMTP id b1so1613303ggn.19
        for <git@vger.kernel.org>; Sun, 29 Jan 2012 18:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=VQhMGLrHVDiqvujQ+6+WS4uyNk57QqosTQCI4wrMtug=;
        b=FNnE81yy0nlsuLrXnpLnK29QWjmhA+slbJjHFy1Hf2bS9DQeQn6agJLLbwxibi6F3u
         MK3FGXz3g1hvxBE/NwMPq1WXmRejqUKo/U4yq5n9i7d3DQDyaJBZ1uBWLWPBXc16ahcf
         QsEjsJ1t5IkdkcF+1l1V+fcTqVgccG/h2GfHA=
Received: by 10.101.178.21 with SMTP id f21mr6686044anp.3.1327891373314;
        Sun, 29 Jan 2012 18:42:53 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id z3sm28732673yhd.3.2012.01.29.18.42.51
        (version=SSLv3 cipher=OTHER);
        Sun, 29 Jan 2012 18:42:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1327883371-25573-1-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189314>

Felipe Contreras wrote:

>  * ${1-} is the same as $1

| $ git log -S'${1-}' contrib/completion/git-completion.bash
| [...]
| commit 25a31f81
| Author: Ted Pavlic <ted@tedpavlic.com>
| Date:   Thu Jan 15 11:02:21 2009 -0500
|
|     bash-completion: Support running when set -u is enabled
|
|     Under "set -u" semantics, it is an error to access undefined variables.
|     Some user environments may enable this setting in the interactive shell.
|
|     In any context where the completion functions access an undefined
|     variable, accessing a default empty string (aka "${1-}" instead of "$1")
|     is a reasonable way to code the function, as it silences the undefined
|     variable error while still supplying an empty string.
|
|     In this patch, functions that should always take an argument still use
|     $1. Functions that have optional arguments use ${1-}.
|
|     Signed-off-by: Ted Pavlic <ted@tedpavlic.com>
|     Acked-by: Shawn O. Pearce <spearce@spearce.org>
|     Signed-off-by: Junio C Hamano <gitster@pobox.com>

Hope that helps,
Jonathan
