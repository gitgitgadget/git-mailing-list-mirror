From: "Tim Webster" <tdwebste@gmail.com>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 11:40:20 +0800
Message-ID: <72877ab10610192040u1e531f9dh3462a934b60cbad9@mail.gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	 <45357CC3.4040507@utoronto.ca>
	 <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>
	 <4536EC93.9050305@utoronto.ca>
	 <845b6e870610190002u420118b8ud634bb9594572c48@mail.gmail.com>
	 <46d6db660610190149x32442596we4112cdd044185a@mail.gmail.com>
	 <45373E27.3050209@op5.se> <vpqwt6wsmb5.fsf@ecrins.imag.fr>
	 <72877ab10610190757u3d2b4df0o204c6ffd73af69b4@mail.gmail.com>
	 <vpq7iyw2sg9.fsf@ecrins.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Christian MICHON" <christian.michon@gmail.com>,
	"Andreas Ericsson" <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 05:40:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GalFB-0001ZI-RR
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 05:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946160AbWJTDkW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 23:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946173AbWJTDkW
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 23:40:22 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:53568 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1946160AbWJTDkV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 23:40:21 -0400
Received: by ug-out-1314.google.com with SMTP id o38so657730ugd
        for <git@vger.kernel.org>; Thu, 19 Oct 2006 20:40:20 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gEmx1b+LWr0F3w1GrudxwRkeePH2qt2/1hg8RmveC/FCWq8cf9ZXHigx2eiBhIgelGFTwpltb97EhZri+RX4bkmPm/10M47y9BXF+o66ufGuGc6Nqt85s1dijJVLkVJcWPWhZi4WppWuPhP+WyYxg+ePcP9hLrruvSAVwO94KzY=
Received: by 10.67.121.15 with SMTP id y15mr1193401ugm;
        Thu, 19 Oct 2006 20:40:20 -0700 (PDT)
Received: by 10.67.100.9 with HTTP; Thu, 19 Oct 2006 20:40:20 -0700 (PDT)
To: "Matthieu Moy" <Matthieu.Moy@imag.fr>
In-Reply-To: <vpq7iyw2sg9.fsf@ecrins.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29407>

On 10/20/06, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> "Tim Webster" <tdwebste@gmail.com> writes:
>
> > First I want to say every SCM I know of sucks when it comes to tracking
> > configurations, simply because they don't record or restore file metadata,
> > like perms, ownership, and acl.
>
> That's not a simple matter.
>
> Tracking ownership hardly makes sense as soon as you have two
> developers on the same project. What does it mean to checkout a file
> belonging to user foo and group bar on a system not having such user
> and group?
.
> That said, it can be interesting to have it, but disabled by default.

Yes I agree it should be disabled by default. And enabled based on the
local settings.
