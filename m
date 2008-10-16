From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: Usability of git stash
Date: Thu, 16 Oct 2008 10:22:44 -0500
Message-ID: <vCcONcOJu3QKQyRgPdT5Dws3F2P25RNAFOgM5GX6FWWKJe40papCRw@cipher.nrlssc.navy.mil>
References: <87wsg9acfv.fsf@cup.kalibalik.dk> <nKimSsYZj6xfGNCQS3i5cRwnWQfbHrtUrwdGB2zGWVfMOcfZMwJDKg@cipher.nrlssc.navy.mil> <86vdvsg4up.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Oct 16 17:24:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqUhn-0005SI-49
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 17:24:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754583AbYJPPWy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 11:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754120AbYJPPWy
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 11:22:54 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:42334 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754210AbYJPPWx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 11:22:53 -0400
Received: by mail.nrlssc.navy.mil id m9GFMidr015143; Thu, 16 Oct 2008 10:22:44 -0500
In-Reply-To: <86vdvsg4up.fsf@lola.quinscape.zz>
X-OriginalArrivalTime: 16 Oct 2008 15:22:44.0544 (UTC) FILETIME=[09AF7C00:01C92FA3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98392>

David Kastrup wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
>> Anders Melchiorsen wrote:
>>
>>> When trying to recover from that scenario, I do "git stash apply" as
>>> recommended by the "git stash" output. Now I still lost my index
>>> state, all changes are unstaged.
>> See the documentation, apply has a '--index' option.
> 
> Still, the shoot-yourself-in-the-foot potential is quite larger than
> appropriate for what is mostly workflow porcelaine.  It is even larger
> than appropriate for plumbing IMHO.

I think it is excessive to call the action taken by 'git stash', when it
is unwanted, "shoot[ing]-yourself-in-the-foot". More like stub-your-toe.

In exchange for allowing new users to stub their toe on new commands, the
work flow of more experienced users is made a little easier.

> I mean, even misspellings like
> git stash lisp
>
> cause action that is not easily reversible, and the given help output is
> misleading with regard to index state.

$ git stash lisp
Usage: git stash list [<options>]
   or: git stash (show | drop | pop ) [<stash>]
   or: git stash apply [--index] [<stash>]
   or: git stash branch <branchname> [<stash>]
   or: git stash [save [--keep-index] [<message>]]
   or: git stash clear


Maybe you are referring to the long since changed behavior where
'git stash' == 'git stash save' and so "lisp" in your example
would have been taken as a stash description. This behavior existed
for less than 6 months, and has been changed now for over 10 months.

-brandon
