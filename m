From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: git for change control of software deployment updates
Date: Sat, 10 Dec 2011 23:09:47 -0600
Message-ID: <jc1dur$80q$1@dough.gmane.org>
References: <jbugm2$afc$1@dough.gmane.org> <CAJDDKr7+GeJTR986DSqKpQRWsXGFVzjBqg6WgRyG-EtycrQs7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 11 06:10:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZbgB-0000OZ-Rw
	for gcvg-git-2@lo.gmane.org; Sun, 11 Dec 2011 06:10:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845Ab1LKFKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Dec 2011 00:10:09 -0500
Received: from lo.gmane.org ([80.91.229.12]:48627 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750728Ab1LKFKI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Dec 2011 00:10:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RZbfp-0000LX-A3
	for git@vger.kernel.org; Sun, 11 Dec 2011 06:10:05 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 11 Dec 2011 06:10:05 +0100
Received: from nkreitzinger by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 11 Dec 2011 06:10:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.24) Gecko/20111103 Thunderbird/3.1.16
In-Reply-To: <CAJDDKr7+GeJTR986DSqKpQRWsXGFVzjBqg6WgRyG-EtycrQs7A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186799>

On 12/10/2011 9:19 PM, David Aguilar wrote:
> On Fri, Dec 9, 2011 at 6:37 PM, Neal Kreitzinger<neal@rsss.com>  wrote:
>> I am considering using git with submodules to deploy most of our updates to
>> our customer linux servers (not including third party rpm updates already
>> tracked by linux distro rpm repository).  Has anyone else done this?
>> Comments?  (Sanity check.)  (I am new to submodules.)
>
> I wrote a script that converts a git source repository into a redhat
> src.rpm.  We use it at my $dayjob.  How about doing something like
> that?  After you have a src.rpm you can create rpms that you can
> distribute using yum.  You are already using rpm which is why I
> mention it.  Converting a directory of rpm files into a hostable
> repository is as simple as `createrepo /path/to/rpms/`.
>
> The git project has a 'make rpm' target in its Makefile that you could
> use as an example.
We use rhel so, yes, we use the redhat repo to get rhel patches.  Is 
that what you mean by "You are already using rpm"?  (We do not write our 
own rpm's at this time.)

v/r,
neal
