From: Daed Lee <daed@thoughtsofcode.com>
Subject: Re: Partially private repository?
Date: Sun, 31 Jan 2010 23:59:00 -0500
Message-ID: <78d8a6b51001312059s1811b631y838679a3f63188b0@mail.gmail.com>
References: <78d8a6b51001291401ib93976el25c03694d53aaced@mail.gmail.com>
	 <32541b131001291410g252ddff4lbf04ac7c1d2d33fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 05:59:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NboNS-0006vO-9M
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 05:59:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753614Ab0BAE7F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Jan 2010 23:59:05 -0500
Received: from mail-ew0-f214.google.com ([209.85.219.214]:34543 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023Ab0BAE7D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jan 2010 23:59:03 -0500
Received: by ewy6 with SMTP id 6so233125ewy.37
        for <git@vger.kernel.org>; Sun, 31 Jan 2010 20:59:00 -0800 (PST)
Received: by 10.213.1.132 with SMTP id 4mr2596812ebf.40.1265000340534; Sun, 31 
	Jan 2010 20:59:00 -0800 (PST)
In-Reply-To: <32541b131001291410g252ddff4lbf04ac7c1d2d33fc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138579>

On Fri, Jan 29, 2010 at 5:10 PM, Avery Pennarun <apenwarr@gmail.com> wr=
ote:
> On Fri, Jan 29, 2010 at 5:01 PM, Daed Lee <daed@thoughtsofcode.com> w=
rote:
>> Hi, I'm wondering if git can handle the following use. I have a
>> project that started as private experiment, but has morphed into
>> something I'd like to release publicly. I want to give others access
>> to the repository, but only to commits after a certain cutoff date.
>> Commits prior to that date have things like hardcoded file paths,
>> emails, etc. that I'd like to keep private.
>>
>> I suppose the easiest thing to do would be to create a new repositor=
y,
>> add the project files to it, and make that public, however I'd like =
to
>> keep my private commit history along with the public commit history
>> going forward in a single repository if possible. Is there a way to =
do
>> this with git?
>
> You should probably split your history into two pieces: the "before"
> and "after" parts. =C2=A0To split out the "after" part, you could use
> git-filter-branch
> (http://www.kernel.org/pub/software/scm/git/docs/v1.6.0.6/git-filter-=
branch.html).
> =C2=A0Then, in your private copy of the repo, you could reattach the
> "before" part of the history using git grafts.

Going forward, if I made changes to my private repository (containing
the "before" and "after" parts) and pushed to the public repository
(containing only the "after" part), would this only push the commits
in the "after" part? Essentially, I want to develop in my private
repository and see my "before" and "after" changes when I "git
log/show", but only push the "after" changes to the public repository.

I've also been looking into private branches. Could I do something
like keep my "before" changes on a private branch, and then do all
future development on a public branch?

Thanks for the pointer to git grafts, I'll have to read up on it furthe=
r.
