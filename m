From: "James Henstridge" <james@jamesh.id.au>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 18:45:50 +0800
Message-ID: <a7e835d40610200345o2ad83bb7k6dfc29867498971c@mail.gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	 <87ods727pn.wl%cworth@cworth.org> <45382120.9060702@utoronto.ca>
	 <200610201157.22348.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Aaron Bentley" <aaron.bentley@utoronto.ca>,
	"Andreas Ericsson" <ae@op5.se>,
	"Linus Torvalds" <torvalds@osdl.org>,
	"Carl Worth" <cworth@cworth.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 12:46:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gart4-0001BQ-2K
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 12:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161010AbWJTKp6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 06:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161011AbWJTKp6
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 06:45:58 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:3730 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161010AbWJTKp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 06:45:57 -0400
Received: by nf-out-0910.google.com with SMTP id c2so1384282nfe
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 03:45:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=KdfuFm6WeBmRKM5Ov4txP8czK/JcFk9zCyZaQev5gN5CXfMjy0wLprKf1w9/7EndC5Q563vvw3/FQcRnCZXDvhWzQSitUY+Pp3N09PfRIZLL7dZER5g0lM7MEj1GP0yjUFTgi2RsC3zOBo2XXRte5CXiQ4pxrODX+zu6mqvi5SA=
Received: by 10.82.111.8 with SMTP id j8mr413206buc;
        Fri, 20 Oct 2006 03:45:55 -0700 (PDT)
Received: by 10.82.108.1 with HTTP; Fri, 20 Oct 2006 03:45:50 -0700 (PDT)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <200610201157.22348.jnareb@gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: aa8cac08f599fcab
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29442>

On 20/10/06, Jakub Narebski <jnareb@gmail.com> wrote:
> > What's nice is being able see the revno 753 and knowing that "diff -r
> > 752..753" will show the changes it introduced. Checking the revo on a
> > branch mirror and knowing how out-of-date it is.
>
> Huh? If you want what changes have been introduced by commit
> c3424aebbf722c1f204931bf1c843e8a103ee143, you just do
>
> # git diff c3424aebbf722c1f204931bf1c843e8a103ee143
>
> (or better "git show" instead of "git diff" or "git diff-tree").
> If you give only one commit (only one revision) git automatically
> gives diff to its parent(s).

If a revision has multiple parents, what does it diff against in this
case?  Do you get one diff against each parent revision?

James.
