From: "James Henstridge" <james@jamesh.id.au>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 16:26:39 +0800
Message-ID: <a7e835d40610200126y5edc2ad0v8ca0a95655b2e029@mail.gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	 <egr3ud$nqm$1@sea.gmane.org> <45340713.6000707@utoronto.ca>
	 <Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>
	 <45345AEF.6070107@utoronto.ca>
	 <BAYC1-PASMTP08A746E5FA6B87BC65BD37AE0E0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Aaron Bentley" <aaron.bentley@utoronto.ca>,
	"Linus Torvalds" <torvalds@osdl.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	"Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 20 10:26:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GapiH-0006Po-Cd
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 10:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWJTI0m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 04:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWJTI0m
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 04:26:42 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:43783 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932204AbWJTI0l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 04:26:41 -0400
Received: by nf-out-0910.google.com with SMTP id c2so1346560nfe
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 01:26:40 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=PhbskmHQsnzsY0VsgNztM5DOGzSOsy2Hv1ksaZ5k6KtZ9Z41tst+Ho3mZF+mKFDtUk0oRqttviZ1nIeOZh7LFL5PbbdpyZQO7KZgvaAI1RuCXb04BkMJiUMywwhew+Ofe4R7FFf0uuD3xz//UFVsDTO19IFTHvxpm6gGncZBxyg=
Received: by 10.82.114.3 with SMTP id m3mr395560buc;
        Fri, 20 Oct 2006 01:26:39 -0700 (PDT)
Received: by 10.82.108.1 with HTTP; Fri, 20 Oct 2006 01:26:39 -0700 (PDT)
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP08A746E5FA6B87BC65BD37AE0E0@CEZ.ICE>
Content-Disposition: inline
X-Google-Sender-Auth: 861e5fa893d42bdb
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29418>

On 17/10/06, Sean <seanlkml@sympatico.ca> wrote:
> > - - you can use a checkout to maintain a local mirror of a read-only
> >   branch (I do this with http://bazaar-vcs.com/bzr/bzr.dev).
>
> I'm not sure what you mean here.  A bzr checkout doesn't have any history
> does it?  So it's not a mirror of a branch, but just a checkout of the
> branch head?

There are two forms of checkout: a normal checkout which contains the
complete history of the branch, and a lightweight checkout, which just
has a pointer back to the original location of the history.

In both cases, a "bzr commit" invocation will commit changes to the
remote location.  In general, you only want to use a lightweight
checkout when there is a fast reliably connection to the branch (e.g.
if it is on the local file system, or local network).

Aaron would be talking about a normal (heavyweight) checkout here.
With a heavyweight checkout, you can do pretty much anything without
access to the branch.  In contrast, almost all operations on a
lightweight checkout need access to the branch.

James.
