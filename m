From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: Re: strange "git clone" behavior wrt an active branch
Date: Sun, 28 Sep 2008 21:43:11 +0200
Message-ID: <adf1fd3d0809281243x24974ddfk3fd6ce2667ac2edc@mail.gmail.com>
References: <ee2a733e0809280505n69f62e0fy89667c175bcc16c@mail.gmail.com>
	 <adf1fd3d0809280537k7adffe3dte9579fe70c7f990e@mail.gmail.com>
	 <ee2a733e0809280623i30a9e298i30db2a84b8530d61@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: SLONIK.AZ@gmail.com
X-From: git-owner@vger.kernel.org Sun Sep 28 21:45:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kk2D0-0000By-SX
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 21:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752353AbYI1TnO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Sep 2008 15:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752270AbYI1TnO
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 15:43:14 -0400
Received: from mu-out-0910.google.com ([209.85.134.189]:53752 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115AbYI1TnN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Sep 2008 15:43:13 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1460836muf.1
        for <git@vger.kernel.org>; Sun, 28 Sep 2008 12:43:11 -0700 (PDT)
Received: by 10.103.217.7 with SMTP id u7mr3048597muq.102.1222630991463;
        Sun, 28 Sep 2008 12:43:11 -0700 (PDT)
Received: by 10.102.247.10 with HTTP; Sun, 28 Sep 2008 12:43:11 -0700 (PDT)
In-Reply-To: <ee2a733e0809280623i30a9e298i30db2a84b8530d61@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96986>

On Sun, Sep 28, 2008 at 3:23 PM, Leo Razoumov <slonik.az@gmail.com> wro=
te:
> On 9/28/08, Santi B=E9jar <santi@agolina.net> wrote:
>> On Sun, Sep 28, 2008 at 2:05 PM, Leo Razoumov <slonik.az@gmail.com> =
wrote:
>>  > Hi All,
>>  > I am using the latest stable version git-1.6.0.2.
>>  >
>>  > The man page for git-clone states explicitly that "git clone"
>>  >
>>  > " Clones a repository into a newly created directory, ...[snip]..=
=2E
>>  >  and creates and checks out an initial branch equal to the
>>  >  cloned repository's currently active branch. "
>>  >
>>  > I noticed that while my active branch "My" happens to point to th=
e
>>  > same commit as the "master" the git clone will check out master
>>  > instead of My (currently active branch). Is it a bug?
>>  >
>>
>>
>> Currently it is only guessed which is the active branch (with a
>>  preference for the master branch as it is the default), as the curr=
ent
>>  protocol does not allow transferring the ref links:
>
> This is quite unfortunate design decision.

This is not a design decision, git has evolved, not designed. The ref
links are younger than the transfer protocols.

> There can be any number of
> local branches referring to the same commit. Without being able to
> pick into .git/HEAD it is impossible to decide which of them is
> "active".

I'm sure patches are welcome.

>
> --Leo--
>
