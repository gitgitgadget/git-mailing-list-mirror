From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: a more helpful message on "git status" output
Date: Fri, 18 Jul 2014 14:05:00 -0700
Message-ID: <20140718210500.GU12427@google.com>
References: <CAKQhN+rK0ftwC5hX4hDhXZbcEGAfCCBXRaQXYnMFLmR=n21OLA@mail.gmail.com>
 <xmqq38dympo8.fsf@gitster.dls.corp.google.com>
 <CAKQhN+p5FpX-GEZeX0t-Y1Sq6+fdfRpE+ACqhKgdLWGFRj0ToA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?iso-8859-1?Q?Juli=E1n?= Landerreche <maniqui@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 23:05:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8FL5-0005w8-AD
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 23:05:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935063AbaGRVFF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jul 2014 17:05:05 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:63322 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932304AbaGRVFD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 17:05:03 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so4190838pdj.12
        for <git@vger.kernel.org>; Fri, 18 Jul 2014 14:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=q4wuuPR5HIr0oW9soZrS3uy1VrDG1Ev8dEsP7IFlGHI=;
        b=0wGC2Q8ggrW5272alkGIvbWfLT4yUc+eryg3Bn3QzqJ3xe5V2mNCLx9f6qxZaUMxC0
         JrI4kYvbW12P2T/gUCgCfxqPK4BWSduVMKRt4TuTAtVHN1wTDKMzaIkBvFw0ZhXUIZlO
         7BbRRZ0lGs8Mj5CagSrv8WWM7+7o2Sq0a7+7xvx4GHANbkLIoISGhdIdThGngVQ+qdp4
         xff/9LWbvWu4fucoenTOGb7ImK02W9m0bpl+R52/xGIw2FeMAqvKqqvxJedem/PjEZXK
         mEJzx6zS80ZhopG/DwGSc63GjrC+qrQFKewpS7kv9gZXsRpTPi2QDp7sa7C7YOSPyU9m
         MYdw==
X-Received: by 10.66.183.11 with SMTP id ei11mr8212694pac.116.1405717503325;
        Fri, 18 Jul 2014 14:05:03 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:6d3d:4f:6892:efc2])
        by mx.google.com with ESMTPSA id pm7sm8677805pdb.77.2014.07.18.14.05.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 18 Jul 2014 14:05:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAKQhN+p5FpX-GEZeX0t-Y1Sq6+fdfRpE+ACqhKgdLWGFRj0ToA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253846>

Juli=E1n Landerreche wrote:

> A more verbose, educational output could read:
>
>   (use "git pull" to fetch newer commits from upstream and update you=
r local branch)
>   (use "git merge" to update your local branch)

Yes, I like this idea, with a few qualifications:

 1. The first line is long.  Is there a shorter way to say the same
    thing?  Maybe

    (use "git pull" to fetch newer commits and update your local branch=
)

 2. s/from upstream/from $remote/ (e.g., "from origin") in the first
    line?  Though that would make problem (1) worse.

 3. Is there some way to make it more obvious these two hints are
    independent suggestions and that the user doesn't need to do both?
    Maybe something as simple as

    (or use "git merge" to update your local branch)

 4. Should the advice differ based on whether the current branch is set
    up for merging or rebasing?

Thanks,
Jonathan
