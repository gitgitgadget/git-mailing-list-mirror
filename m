From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Fri, 25 Apr 2014 09:48:53 +0200
Message-ID: <CAGK7Mr6dss7BF-srQ3SqeZe2hAe9nS07fGe--ka1rvC5hXvbSA@mail.gmail.com>
References: <20140422213039.GB21043@thunk.org> <alpine.DEB.2.02.1404221523060.14881@nftneq.ynat.uz>
 <53588713347b7_59ed83d308cf@nysa.notmuch> <CAHYYfeHeJYZ67chSTQk2grsFGr07KXcVNR-T6kOPo0bVYDm59g@mail.gmail.com>
 <53588f448d817_59ed83d3084e@nysa.notmuch> <CAHYYfeFKW93GH+6-ssR5L_uoo3OL2-LFAsj-4+8uEmL0BhT3ow@mail.gmail.com>
 <5358bae8ab550_1f7b143d31037@nysa.notmuch> <877g6fb2h6.fsf@fencepost.gnu.org>
 <5358ca1a55a69_1f7b143d3101c@nysa.notmuch> <20140424134106.GA27035@thunk.org>
 <20140424195559.GA1336@luc-arch> <CALZVapn0gEHc7t2fjk7YGd2o0yfpGLu0JCgUtdREvROC8_mqXg@mail.gmail.com>
 <5359c9d612298_771c15f72f02a@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Javier Domingo Cansino <javierdo1@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 09:49:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wdasy-0000Ph-JZ
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 09:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbaDYHtY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 03:49:24 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:58360 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbaDYHtX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 03:49:23 -0400
Received: by mail-oa0-f51.google.com with SMTP id i4so3837525oah.38
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 00:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NvPbmfdc7Z2y6I67NEk5vRW9JnFjqonz9ZJjICakSIg=;
        b=xI+uQVOTijoOvTKrEcL5jfUfBBYUxITCGekDuKtueowTypiTLekCTT0baGBd/lfmG2
         OW+lJtNrzZMnG+idqo5pAYh7LXBt9AdJ9zXw5tRm1C1TI27SVAFUVax24wisAywYd2b7
         +bgbQxsdF/SSp57IRlbNbShUJhgzxVkQT08/KmWR+2ZjgDZo1Y4i9VX0OWy61Ciw1hOs
         jcbGzEjOk6wep/WcnFNVP+Sy8dipKqwMnXE6scl90tSwrztOk8C6MdNcRFRNxIfL+5XZ
         dtvITB21J3MOoAMv1Bedln23aA2VAS/Q178h6s+n22p9JLU4/Mb9c48oIgy2aWTrqo6R
         Ka0g==
X-Received: by 10.60.146.201 with SMTP id te9mr5635982oeb.38.1398412163151;
 Fri, 25 Apr 2014 00:49:23 -0700 (PDT)
Received: by 10.76.85.229 with HTTP; Fri, 25 Apr 2014 00:48:53 -0700 (PDT)
In-Reply-To: <5359c9d612298_771c15f72f02a@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247038>

> I think you are on the right track but the solution is not to shrug shoulders.
> We should acknowledge there are serious problems with the interface, list them,
> and try to fix them. One example is `git add $tracked_file` being wrong, it
> should be `git stage $tracked_file`.

I agree. The "stage area" is a very important concept in git, why not
talk git commands that refers to it? Then we could add flags like
--new-files or --deleted-files for better granularity than the current
--all flag.


> The real problem is that the core developers of Git don't acknowledge these
> user-interface issues, according the them the interface doesn't require any
> major changes. Which goes contrary to what most of the world believes.

I think most people agree with these interfaces issues but it's a hard
problem to solve, so  they are reluctant to talk about it because they
fear the can of worm. If someone came with a good solution most people
would be willing to consider it.

I think starting by documenting the issues is a good idea, maybe on a
wiki, and start some draft of a proposed solution that would improve
in an iterative process.

Philippe
