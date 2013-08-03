From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git_mkstemps: improve test suite test
Date: Fri, 2 Aug 2013 17:36:36 -0700
Message-ID: <20130803003636.GB2945@elie.Belkin>
References: <201308030027.r730RNWS022924@freeze.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Dale R. Worley" <worley@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Aug 03 02:36:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5Ppt-0000Jp-3O
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 02:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752978Ab3HCAgl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Aug 2013 20:36:41 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:40743 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461Ab3HCAgk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Aug 2013 20:36:40 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so1250540pbc.21
        for <git@vger.kernel.org>; Fri, 02 Aug 2013 17:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=a+DhwH3z6KWJ9Gd3f5kPiwme6aOMfasAJC5FboZUtEk=;
        b=DG3ngiNwl1y9pJyVIoDo/fFcdf3XowMnR4SiUO+qW8HXwLjfvhv4dQEhiux7ttYkWx
         VzPKgp2qxkUjIMooxxsmU74MgB8dvfHsa3R49oWorFpzKM1MSNb/3lQNidlrmUFUFVll
         pz0cGpJaxd1M7DLM/HoIAPjTuoMc3BBn4QaTB8rFKId6YAUZGgEwPneR/IL84NGzeEkR
         KQOoFv7BUKts9+2u2CKyOtGASrEkQXxIFWvuAQtMnH9yUmsrqwi5TpeoCpFMiewoFSTN
         uYMcOQD2iG6CxcefLO9uMcE7JgQ4Zr9DUIOlClfhtNvn9JJ47tbidgE0mQZBTiX8kGfw
         XhEw==
X-Received: by 10.68.36.132 with SMTP id q4mr10462659pbj.118.1375490200381;
        Fri, 02 Aug 2013 17:36:40 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id qv4sm12859094pbc.16.2013.08.02.17.36.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 02 Aug 2013 17:36:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201308030027.r730RNWS022924@freeze.ariadne.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231554>

Hi,

Dale R. Worley wrote:

> Commit 52749 fixes a bug regarding testing the return of an open()

 $ git show 52749
 fatal: ambiguous argument '52749': unknown revision or path not in the working tree.

Could you mention its subject line or date so it's easier to find?

> call for success/failure.  Improve the testsuite test for that fix by
> removing the helper program 'test-close-fd-0' and replacing it with
> the shell redirection '<&-'.  (The redirection is Posix, so it should
> be portable.)
> 
> Signed-off-by: Dale Worley <worley@ariadne.com>
[...]
> Someone has gone ahead and made the code change, so all that remains
> is to update the testsuite test by replacing the helper program
> 'test-close-fd-0' with the Posix shell redirection '<&-'.

The above paragraph should be part of the commit message, since
otherwise the patch is hard to understand.

The patch text looks good.

Thanks and hope that helps,
Jonathan
