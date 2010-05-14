From: Michael Witten <mfwitten@gmail.com>
Subject: Re: many files, simple history
Date: Thu, 13 May 2010 22:27:42 -0500
Message-ID: <AANLkTimHB9jZq-SUxD2YUfCXKfTOHSxEnANETDL7i6DB@mail.gmail.com>
References: <AANLkTinHZbJ4obpa1FpT8boFWjNYpgU184HUTvki_A0G@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Ali Tofigh <alix.tofigh@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 14 05:28:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OClZT-00049a-Hi
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 05:28:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305Ab0END2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 23:28:14 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57773 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822Ab0END2N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 23:28:13 -0400
Received: by fxm6 with SMTP id 6so1048795fxm.19
        for <git@vger.kernel.org>; Thu, 13 May 2010 20:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=cX/YQHEOIXyZ4J2mrqSKBA9XbHCw9DtDbrWn6SFhCLA=;
        b=PYr/zfXydiEcy9BMcjlI+rLl73ZbFP64WwI4jL6jKRJPjAGUHLUM5EAdReqCAyFb+g
         35gU199UfLSlbtdfpp3uGxkNvBjuAFljK2AoG7nEZ4SzVkVcHKZA0vGzE/ylJbMuUpKF
         9S9qErCNP5nxei2VKJMzjmPn9jdx9RhdVfuB0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=rm7hSpcaDgJSTrwvtz8lq4DV4hceTA+7sNhdwdL494f/LAQAAyB+hkTTF4xPom0pni
         iQECa2eqaAgbT8O4YV50kIohuNNn6JtvGo17JJ4p/RjLOkyuMEpL3mSHnhJ/akHPhlnH
         yds+6RXfyO3AKZC5x88YwfliPaI0lsYAPsm7Y=
Received: by 10.239.148.137 with SMTP id f9mr75543hbb.14.1273807692130; Thu, 
	13 May 2010 20:28:12 -0700 (PDT)
Received: by 10.239.189.143 with HTTP; Thu, 13 May 2010 20:27:42 -0700 (PDT)
In-Reply-To: <AANLkTinHZbJ4obpa1FpT8boFWjNYpgU184HUTvki_A0G@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147041>

On Thu, May 13, 2010 at 21:57, Ali Tofigh <alix.tofigh@gmail.com> wrote:
> (i almost
> always build from source code and install in non-standard locations).

It would make a lot more sense to use a package manager.

You might find that Arch Linux's `pacman' provides everything that you
need; it's really easy to define your own packages and build from
source, allowing pacman to manage dependencies, locate which package
owns which file, and upgrade/remove packages.

I bet gentoo's `emerge' would also be viable.
