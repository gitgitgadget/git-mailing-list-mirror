From: "Ryan Anderson" <rda@google.com>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 20:25:03 -0700
Message-ID: <87dcb0bd0610172025l25d6646dq761dd08792e2b290@mail.gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	 <45349162.90001@op5.se> <453536AE.6060601@utoronto.ca>
	 <200610172301.27101.jnareb@gmail.com> <45354AD0.1020107@utoronto.ca>
	 <Pine.LNX.4.64.0610171448150.3962@g5.osdl.org>
	 <45355EEE.3060105@utoronto.ca>
	 <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org>
	 <45357411.20500@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Jakub Narebski" <jnareb@gmail.com>,
	"Andreas Ericsson" <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 05:25:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga23W-0002sa-Bi
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 05:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbWJRDZT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 23:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWJRDZS
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 23:25:18 -0400
Received: from smtp-out.google.com ([216.239.45.12]:15799 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751225AbWJRDZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 23:25:16 -0400
Received: from zps38.corp.google.com (zps38.corp.google.com [172.25.146.38])
	by smtp-out.google.com with ESMTP id k9I3PBMM021294
	for <git@vger.kernel.org>; Tue, 17 Oct 2006 20:25:11 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=SxTZA5gjb1MqA5RmOdYiE46NbqcbL6taEUwI6LdApiJjEUzpCMKE5kC6zU96fvUzl
	gfku69Xl7V5MpSrpQx49g==
Received: from py-out-1112.google.com (pyex66.prod.google.com [10.34.175.66])
	by zps38.corp.google.com with ESMTP id k9I3P3Na010151
	for <git@vger.kernel.org>; Tue, 17 Oct 2006 20:25:03 -0700
Received: by py-out-1112.google.com with SMTP id x66so191836pye
        for <git@vger.kernel.org>; Tue, 17 Oct 2006 20:25:03 -0700 (PDT)
Received: by 10.64.148.8 with SMTP id v8mr13466514qbd;
        Tue, 17 Oct 2006 20:25:03 -0700 (PDT)
Received: by 10.64.83.11 with HTTP; Tue, 17 Oct 2006 20:25:03 -0700 (PDT)
To: "Aaron Bentley" <aaron.bentley@utoronto.ca>
In-Reply-To: <45357411.20500@utoronto.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29183>

On 10/17/06, Aaron Bentley <aaron.bentley@utoronto.ca> wrote:
> > In other words, the empty merge is totally semantically empty even in the
> > bazaar world. Why does it exist?
>
> It exists because it is useful.  Because it makes the behavior of bzr
> merge uniform.  Because in some workflows, commits show that a person
> has signed off on a change.

In the Git world that happens via "git tag -s", i.e, a
cryptographically strong "signoff".
(There's also the secondary convention of appending Signed-off-by: to
email-applied patches, but that's something that would translate
effectively to any other system, since it's outside the SCM.)
