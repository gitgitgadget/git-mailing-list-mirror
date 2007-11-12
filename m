From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH] status&commit: Teach them to show submodule commit summary
Date: Tue, 13 Nov 2007 00:42:59 +0800
Message-ID: <46dff0320711120842s40441614n82343bc75057201e@mail.gmail.com>
References: <1194877277-31777-1-git-send-email-pkufranky@gmail.com>
	 <4738784F.7010106@viscovery.net> <fh9u0i$n93$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 17:43:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrcNh-0007QS-Pr
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 17:43:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755489AbXKLQnH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 11:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755392AbXKLQnG
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 11:43:06 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:33420 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755334AbXKLQnF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 11:43:05 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1219470rvb
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 08:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=cBr6YQ8fgb/bL5MzPGwUxzCbfFVvtb5FxgWvknpMjp8=;
        b=FgGf1Uy+JmZkyli3WIICIsvmbecVF9OJrfOYjK/IDHELnZcqtxMGbhjYBF0vhXQcthoHSS7UNxuTG7E2eAtDJnzPRMNZv0zcQbjzmwBXrDueDwHq/AVR0rVwUvEEHpY0tmADkfaPOKNSsXYf7UxiD/BDKMRZul5z+6j2+r0tvDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N6p9R41NybUf9Kpn3xuIya6GNRqT3OMwQuXR/g2FC/G95Ql9B9W9OwI18nS9cKAszJ4tzGTc1fKql5ef8/wiVPEnTogp/KxsjhRRvVJTCSp4NZjsl8LiJSj56I8ysTEKTlzLG+8iTKdZtxsy/pcVa+WOzGcOh6hngKhx3opyCYk=
Received: by 10.141.21.19 with SMTP id y19mr2480953rvi.1194885784290;
        Mon, 12 Nov 2007 08:43:04 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Mon, 12 Nov 2007 08:42:59 -0800 (PST)
In-Reply-To: <fh9u0i$n93$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64660>

On Nov 13, 2007 12:12 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> Johannes Sixt wrote:
>
> >> A configuration variable 'submodule.status' is used to turn this summary
> >> behaviour on or off (default off). Also --submodule and --no-submodule options
> >> are added.
> >
> > There is already 'status.color', I suggest the configuration to become
> > 'status.submoduleSummary'.
>
> Or status.submodule.summary, although we usually use
> section.<variable_sub>.key configuration variables,
> e.g. branch.<name>.remote. But we have exception:
> color.branch.<slot>

maybe submodule.status.summary better?
later new variables can be added easily such as
submodule.status.recursive, submodule.diff, submodule.log
>
> --
>
> Jakub Narebski
> Warsaw, Poland
> ShadeHawk on #git
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Ping Yin
