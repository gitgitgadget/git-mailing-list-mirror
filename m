From: "Peter Harris" <git@peter.is-a-geek.org>
Subject: Re: keeping remote branches in sync
Date: Thu, 9 Oct 2008 10:43:21 -0400
Message-ID: <eaa105840810090743pba41a98ocdf79b7c06d76e9e@mail.gmail.com>
References: <20081009141418.GF18241@morganstanley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 09 16:45:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Knwkk-0006w8-06
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 16:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753334AbYJIOnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 10:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753303AbYJIOnX
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 10:43:23 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:41353 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbYJIOnW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 10:43:22 -0400
Received: by rv-out-0506.google.com with SMTP id k40so61498rvb.1
        for <git@vger.kernel.org>; Thu, 09 Oct 2008 07:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=IACKIu29gdxc7En5EzH966UH6e9Eao/CiCeIXyhm1mQ=;
        b=sG4m/xwqaKq6gyKssi1s1e1rOmMkMh0J42sn2KXd7V310JWNV7G9aREKqHkS50fR6Y
         GpNG5m0eylX5rP2O07rand5ez181Ptex4e8uua/AdE1YMGt7fxioU4bs6JzH/DG/8G/0
         JjE0OVEeCGu9R4Kr/TtejXv1ZZqlozU6e0QZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=EmsP7aQ4ymd1qaYsLMFlr8tyYeL2VXzj+hJtlU64bSuWE02igjbMj4Z6XJzerYwq27
         YpKr3YSMuC8zaTaSydN7f/KPhnDzyL+Iu6MjXvlQhP0GJsaq7+XX3a6MYaF6++4wN8uW
         TiC37hlcYtm4bE/RRMJvKmqrjT1cgqjWET+Hs=
Received: by 10.141.5.17 with SMTP id h17mr184206rvi.8.1223563401875;
        Thu, 09 Oct 2008 07:43:21 -0700 (PDT)
Received: by 10.140.194.3 with HTTP; Thu, 9 Oct 2008 07:43:21 -0700 (PDT)
In-Reply-To: <20081009141418.GF18241@morganstanley.com>
Content-Disposition: inline
X-Google-Sender-Auth: 8377c97d5df30816
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97854>

On Thu, Oct 9, 2008 at 10:14 AM, Kevin Green wrote:
> After topic branches are merged to master, we do some cleanup by deleting them
> from the shared repo.
>
> One of the issues we have is that _my_ local repos remote branches aren't kept
> in sync with the shared repo.
...

> I'd like some comment on whether our workflow could use some improvement.
> Specifically, if there's a straightforward way to handle the issue above, that
> would be great.  I've been looking through the manual on git-fetch and
> git-pull and not seeing any options to do this.

Is "git remote prune" what you're looking for?

Peter Harris
