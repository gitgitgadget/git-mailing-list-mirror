From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: StGit: kha/safe and kha/experimental updated
Date: Thu, 20 Mar 2008 15:25:04 +0000
Message-ID: <b0943d9e0803200825y18971975qd79bf51157a97684@mail.gmail.com>
References: <20080319012804.GA28781@diana.vm.bytemark.co.uk>
	 <20080319013832.GB28781@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Alex Chiang" <achiang@hp.com>,
	"Angus Salkeld" <ahsalkeld@gmail.com>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 16:26:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcMeP-00017F-71
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 16:25:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756421AbYCTPZI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Mar 2008 11:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756552AbYCTPZH
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 11:25:07 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:58489 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756415AbYCTPZF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Mar 2008 11:25:05 -0400
Received: by wr-out-0506.google.com with SMTP id c48so880349wra.1
        for <git@vger.kernel.org>; Thu, 20 Mar 2008 08:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=cc2xCqiG/nmmxTjQL32ddajJEi3O8sv4K+W6BFcPxe0=;
        b=QyGjAI1QUztH1L5jKndGuM7rgY6jjxsR2GLKV495PLIjTONspI45+plT3tOgu8T+xVMAVttRtWZiwGAD4fXR2sAyeX2+CpDK5vmK7v700TtbogE/Re3iw4odn0vCLNHVQpwM87jGSxWy7sXvuLvqTwhCIPPmITr33BrnfL5JIvU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=F6eVQLd/hijBFr8WgTYVCt1z6ElRXb4e348uyelZPxvm+eq0SuWGFj0OaH0kE9E5wckHtF2qpiW71GdqBxHMY6OX1k5IALQ2e5VePW8AoRatQkXuBU7uF6LVjaUz875iHFlPvI5qcrvo7jrDmiTUIWYv7OO6ec79/yTSBIM4NfM=
Received: by 10.141.172.6 with SMTP id z6mr800707rvo.80.1206026704347;
        Thu, 20 Mar 2008 08:25:04 -0700 (PDT)
Received: by 10.141.206.19 with HTTP; Thu, 20 Mar 2008 08:25:04 -0700 (PDT)
In-Reply-To: <20080319013832.GB28781@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77664>

On 19/03/2008, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2008-03-19 02:28:04 +0100, Karl Hasselstr=F6m wrote:
>
>  > plus a new and shiny "stg reset" prototype!
>
>
> It works like this:
>
>   1. Every StGit command that modifies anything writes the new state
>      to a log. The log is a git branch called <branchname>.stgit.
>
>   2. When you've done something you regret, find the state in the log
>      you want to return to and just say (for example)
>
>        $ stg reset master.stgit~3
>
>      Resetting is recorded in the log just like everything else, so t=
o
>      undo a reset you just did, simply say
>
>        $ stg reset master.stgit^

That's cool :-), thanks. We can even add aliases for 'undo' and 'redo'.

--=20
Catalin
