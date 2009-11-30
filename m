From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/6] INSTALL: document a simpler way to run
 uninstalled builds
Date: Sun, 29 Nov 2009 22:48:52 -0800
Message-ID: <7vaay41p9n.fsf@alter.siamese.dyndns.org>
References: <1259561971-25730-1-git-send-email-mmogilvi_git@miniinfo.net>
 <1259561971-25730-2-git-send-email-mmogilvi_git@miniinfo.net>
 <1259561971-25730-3-git-send-email-mmogilvi_git@miniinfo.net>
 <1259561971-25730-4-git-send-email-mmogilvi_git@miniinfo.net>
 <1259561971-25730-5-git-send-email-mmogilvi_git@miniinfo.net>
 <1259561971-25730-6-git-send-email-mmogilvi_git@miniinfo.net>
 <1259561971-25730-7-git-send-email-mmogilvi_git@miniinfo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
X-From: git-owner@vger.kernel.org Mon Nov 30 07:49:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF04J-0007ag-0E
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 07:49:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126AbZK3Gsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 01:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752433AbZK3Gsz
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 01:48:55 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49005 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310AbZK3Gsz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 01:48:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 25DA5A2333;
	Mon, 30 Nov 2009 01:48:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MD/QC3Yptb8mOSMKkpgdtUQX2tU=; b=W04kpe
	IBmECDJV+BPTztw2G3gxVVAZuG8UEaScL1WEOH4R9ZRVRY6mgY1xdp1K9LPlI4Md
	uMVSjWICl6fZUxhOxkb9u9Wvy0XsyUjmZ1TYw0I+lUBV8Q2q4mTsWYWJIY1xfwIi
	QtLtvloXhVY99uOMPfFbAdh7ogAO2z7S7sIZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cF+VwbYTUaMXQY5UYgYrk7aC6nbjkEyr
	5QP3WdtxBTpIiJ57bkSJHxYYt06qTBP/w/tpbphE++paDdHLVBxNRtuM1Th5RXR7
	z67/a616HUVgITjjtCYykttepKSOhqQm7i+6LklDvewGM6X2f7DllUS4TGC6fEix
	qf/UnW1+kr0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0343AA232D;
	Mon, 30 Nov 2009 01:48:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B3F20A232C; Mon, 30 Nov 2009
 01:48:53 -0500 (EST)
In-Reply-To: <1259561971-25730-7-git-send-email-mmogilvi_git@miniinfo.net>
 (Matthew Ogilvie's message of "Sun\, 29 Nov 2009 23\:19\:31 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6E926302-DD7C-11DE-BE8B-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134059>

Matthew Ogilvie <mmogilvi_git@miniinfo.net> writes:

> diff --git a/INSTALL b/INSTALL
> index be504c9..ee718c6 100644
> --- a/INSTALL
> +++ b/INSTALL
> @@ -39,7 +39,19 @@ Issues of note:
>     with --disable-transition option to avoid this.
>  
>   - You can use git after building but without installing if you
> -   wanted to.  Various git commands need to find other git
> +   want to.
> +
> +   The simplest option for running some manual tests of a build
> +   before installing it is to use the wrapper scripts that are built
> +   and saved into `pwd`/bin-wrappers.  Either invoke the scripts in
> +   bin-wrappers using their full paths, put bin-wrappers in your
> +   PATH, or copy/symlink just the bin-wrappers scripts into somewhere
> +   already in your PATH.  But this option is slightly inefficient,
> +   so for a more permanent solution we recommend either installing
> +   git (you can set a prefix to install right next to your
> +   build directory), or use the alternative below.

Drop "simplest" and "slightly".

I think you forgot to mention an important improvement you made since the
earlier iteration on the wrap-for-bin script in the cover letter.  With
the new wrap-for-bin, we do not have to worry about the case a random
binary in the directory is run without first adding anything to user's
$PATH anymore, no?

With that change, this round's implementation deserves to be recommended
as the new preferred way to run "use after building without installing", I
think.  So how about making the text like this?

    You can use git after building but without installing if you want to
    test drive it.  Simply run git found in bin-wrappers directory in the
    build directory, or prepend that directory to your $PATH.  This
    however is less efficient than running an installed git, as you always
    need an extra fork+exec to run any git subcommand.

    It is still possible to use git without installing by setting a few
    environment variables, which was the way this was done traditionally.
    But using git found in bin-wrappers directory in the build directory
    is far simpler.  Just for a historical reference, the old way went
    like this:

	GIT_EXEC_PATH=`pwd`
	PATH=`pwd`:$PATH
	GITPERLLIB=`pwd`/perl/blib/lib
	export GIT_EXEC_PATH PATH GITPERLLIB
