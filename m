From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Feature Enhancement Idea.
Date: Wed, 23 Sep 2009 10:26:49 +0200
Message-ID: <c07716ae0909230126w36b3309fqe9ae8ccec0db49c3@mail.gmail.com>
References: <5b5e291e0909222317q47ae36d4la470f17ec3902124@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Deon George <deon.george@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 10:27:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqNC3-0004D2-Og
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 10:27:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754566AbZIWI0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2009 04:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754506AbZIWI0w
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Sep 2009 04:26:52 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:64915 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754503AbZIWI0r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2009 04:26:47 -0400
Received: by bwz6 with SMTP id 6so356442bwz.37
        for <git@vger.kernel.org>; Wed, 23 Sep 2009 01:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=r396s6XcWiQMzl4veekQwz2Mpfhmw4WjcJTeZXmANJY=;
        b=RyC2++K3cbcMT1owbhh+t1kJO6V5Pj3XanAn1X7UYZA5TrcpN2Ln7AEIaqbcIZ/Rhc
         3UHYRVjKUDbVVZDIankOQKrupT86fkFoJFv79yY52OLqT1h5pZ7E9uFBJw0I6AZrO8Hd
         gRFjp3naM28Xh03PEFy0G4YgdilbHxlpspvUU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=D9L7gyE9AP9ky4k9WPCM3ekTOXykNACR4NdMMFfEnvkWf05UdpYQByxpoSpgjjgj9J
         Sih4YNYlbzZpkqG7ajMoPmfnHk2U7W5JGqQgwvLRfFoQBLGshyEUbcYwDxvdV1jILOGL
         0C0yh1chAiHW+VFARpacVatEqJPKgNNNNM5M0=
Received: by 10.103.76.5 with SMTP id d5mr830183mul.131.1253694409902; Wed, 23 
	Sep 2009 01:26:49 -0700 (PDT)
In-Reply-To: <5b5e291e0909222317q47ae36d4la470f17ec3902124@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128973>

Hi,

On Wed, Sep 23, 2009 at 8:17 AM, Deon George <deon.george@gmail.com> wrote:
> Hi,
>
> I'm not sure if this is the right place, but I thought I'd post my
> idea and maybe somebody will either redirect me to the right place, or
> give me that "that wont happen".
>
> Im fairly new to GIT (wish I had discovered it long ago), and I really
> like using it - great work guys/garls :)
>
> My idea is to enhance GIT to support (I'll call it) development
> "layers". The current design of GIT is that the working repository and
> working directory assume that all files belong together in the same
> project. I would like to see GIT go 3D and support layers, so that
> files (and/or file content) can belong to multiple repositories (or
> considered unique projects), even though the working tree presents all
> files as if they were one.

Perhaps you could have a look at "git replace" that is now in the master branch.
It could be improved to provide different "views" of a single repository.
I don't think that alone it would provide everything you want though.

Best regards,
Christian.
