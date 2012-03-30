From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: git-svn: cloning an SVN repo with sub-branches and sub-tags
Date: Fri, 30 Mar 2012 18:05:45 +0530
Message-ID: <CALkWK0k7eCTuDdjdABpYrecf7G4_ejcsNmeCxPKSN46406U_2g@mail.gmail.com>
References: <4F7467E1.3090004@pocock.com.au> <CALkWK0mn=vWexhYMNPV5iKf-hX5gTHYjOS4o+E1mFjUtL49hmg@mail.gmail.com>
 <4F75A571.2020304@pocock.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Daniel Pocock <daniel@pocock.com.au>
X-From: git-owner@vger.kernel.org Fri Mar 30 14:36:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDb3t-0001mH-UE
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 14:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760087Ab2C3MgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 08:36:09 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:64619 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759519Ab2C3MgI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 08:36:08 -0400
Received: by wejx9 with SMTP id x9so334872wej.19
        for <git@vger.kernel.org>; Fri, 30 Mar 2012 05:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hEjU2r+CIn81d1y7pxKzYrOD+UNu+k4uI/Fe9TGA938=;
        b=bZ7M1iwVLLBcisqjzCiv3+CvIOi+h/NO1rcpN1BM5sNpqlgB1D8lSV3syY8V8POTvP
         8vGVcDAwAo7quMF+T05TJVBySitla8FH0XkFh3fcc4CuRZlX77wiamPFsfumqJcNLKbX
         mofEQF07rBiSx7gtter+9ilDfYcXmuIQkfevQ10rCtvKlaHp3GjHiAPpGOuB0GfFOUBX
         lv0L/NyFVfl44OxHKhHsErv8Dyh33MkTPU0ggcWJKjs/0T+tTvR5fiS4KsqlkCzzdoWh
         cXdKYSTjKHR6GlmIntCu5CWw+GCaL4o2vy4DW31q+SfVXs49z5luPcKVsbJJ6MQZaTgy
         Ug2Q==
Received: by 10.180.102.101 with SMTP id fn5mr6140462wib.6.1333110965367; Fri,
 30 Mar 2012 05:36:05 -0700 (PDT)
Received: by 10.216.11.199 with HTTP; Fri, 30 Mar 2012 05:35:45 -0700 (PDT)
In-Reply-To: <4F75A571.2020304@pocock.com.au>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194353>

Hi again,

Daniel Pocock wrote:
> One other factor I didn't mention in the original email, some of the
> branches have been renamed/moved within the SVN repo - is that a problem for
> git-svn?

Yes, I think so.

> One compromise I have thought about would be just extracting trunk, and
> forgetting about the branches, and manually tagging the official releases
> (as there were very few of them, this is quick)

Just use contrib/svn-fe in that case: it's really quick and
lightweight.  You can then filter-branch the history and pull out
branches by hand.

> However, based on the errors/warnings, is it possible that there is any
> corruption in the gitified version of trunk (or the history of trunk)?

No corruption is possible on the Git side of things- it has
cryptographic hashes for everything.

    Ram
