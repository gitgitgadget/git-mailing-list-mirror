From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Fri, 25 Apr 2014 02:52:49 -0500
Message-ID: <535a1451b34_2a62c2130c1d@nysa.notmuch>
References: <20140422213039.GB21043@thunk.org>
 <alpine.DEB.2.02.1404221523060.14881@nftneq.ynat.uz>
 <53588713347b7_59ed83d308cf@nysa.notmuch>
 <CAHYYfeHeJYZ67chSTQk2grsFGr07KXcVNR-T6kOPo0bVYDm59g@mail.gmail.com>
 <53588f448d817_59ed83d3084e@nysa.notmuch>
 <CAHYYfeFKW93GH+6-ssR5L_uoo3OL2-LFAsj-4+8uEmL0BhT3ow@mail.gmail.com>
 <5358bae8ab550_1f7b143d31037@nysa.notmuch>
 <877g6fb2h6.fsf@fencepost.gnu.org>
 <5358ca1a55a69_1f7b143d3101c@nysa.notmuch>
 <20140424134106.GA27035@thunk.org>
 <20140424195559.GA1336@luc-arch>
 <CALZVapn0gEHc7t2fjk7YGd2o0yfpGLu0JCgUtdREvROC8_mqXg@mail.gmail.com>
 <5359c9d612298_771c15f72f02a@nysa.notmuch>
 <CAGK7Mr6dss7BF-srQ3SqeZe2hAe9nS07fGe--ka1rvC5hXvbSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Javier Domingo Cansino <javierdo1@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Philippe Vaucher <philippe.vaucher@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 10:03:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wdb6d-00071S-QH
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 10:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbaDYID1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 04:03:27 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:42778 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbaDYIDR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 04:03:17 -0400
Received: by mail-ob0-f172.google.com with SMTP id wo20so3914011obc.31
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 01:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=sc560JX1NL3EWco/COUE1hXxCShU/yFzQO4ubMJfFfE=;
        b=RR2vMEUgW/MxBJ1D4qUjGNjQ1+gxkFl2D1AX2yKjkBQc0BAFf/Rs3kAAP3j7Yjgzid
         OVNUo3eWovm6oRT4zMwHrXI/V9SuYs3vgNhKyU0SXGthsGiL/dBX8514qZKaknwN1N9k
         Qe6sWNujUlfAeyUjPoNoMvht1p9Qs1sVJiUqvblO3JR0/tu6pSaxWjh8PdkTGu6jbtCY
         gkmn8PGQIgoIPd66eRgYAZJ0PkBP2RM7k92yoQNVrccesPUE3cDqxGSXPi0mP3YAqqQZ
         qbirjIGn6PnaLhcyZ/1S5U+8jKR56SuBifYm/3lOa8zsZgkiKqrSgYf8wDu4Mp9qNGOF
         Xhew==
X-Received: by 10.182.105.1 with SMTP id gi1mr5792469obb.9.1398412996874;
        Fri, 25 Apr 2014 01:03:16 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id j9sm14039374obh.23.2014.04.25.01.03.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Apr 2014 01:03:15 -0700 (PDT)
In-Reply-To: <CAGK7Mr6dss7BF-srQ3SqeZe2hAe9nS07fGe--ka1rvC5hXvbSA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247039>

Philippe Vaucher wrote:
> > I think you are on the right track but the solution is not to shrug shoulders.
> > We should acknowledge there are serious problems with the interface, list them,
> > and try to fix them. One example is `git add $tracked_file` being wrong, it
> > should be `git stage $tracked_file`.
> 
> I agree. The "stage area" is a very important concept in git, why not
> talk git commands that refers to it? Then we could add flags like
> --new-files or --deleted-files for better granularity than the current
> --all flag.

Like this:
http://thread.gmane.org/gmane.comp.version-control.git/236127

> > The real problem is that the core developers of Git don't acknowledge these
> > user-interface issues, according the them the interface doesn't require any
> > major changes. Which goes contrary to what most of the world believes.
> 
> I think most people agree with these interfaces issues but it's a hard
> problem to solve, so  they are reluctant to talk about it because they
> fear the can of worm. If someone came with a good solution most people
> would be willing to consider it.
> 
> I think starting by documenting the issues is a good idea, maybe on a
> wiki, and start some draft of a proposed solution that would improve
> in an iterative process.

Yes, it would be good to document these issues, but it wouldn't matter if the
developers ignore them.

For example the move away from the 'index' name was backed up by literally
everyone, except Junio, so it doesn't matter if the issue is documented, and
there are patches with good solutions, if Junio thinks it's not an issue; it's
ignored.

-- 
Felipe Contreras
