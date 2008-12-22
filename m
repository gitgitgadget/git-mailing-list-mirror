From: "Dylan Martin" <dmartin@sccd.ctc.edu>
Subject: Merge two repos with history included? (was Re: How do I..?)
Date: Mon, 22 Dec 2008 14:04:06 -0800
Message-ID: <e1a4c7f60812221404k57a5e150kac74f53c784b6b4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 22 23:06:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEsuO-0002LJ-5T
	for gcvg-git-2@gmane.org; Mon, 22 Dec 2008 23:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757273AbYLVWEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 17:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757867AbYLVWEK
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 17:04:10 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:59688 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758997AbYLVWEI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 17:04:08 -0500
Received: by bwz14 with SMTP id 14so8850082bwz.13
        for <git@vger.kernel.org>; Mon, 22 Dec 2008 14:04:06 -0800 (PST)
Received: by 10.223.108.75 with SMTP id e11mr3710781fap.97.1229983446069;
        Mon, 22 Dec 2008 14:04:06 -0800 (PST)
Received: by 10.223.109.143 with HTTP; Mon, 22 Dec 2008 14:04:06 -0800 (PST)
Content-Disposition: inline
X-Google-Sender-Auth: 2a7e636cdd05cfd6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103775>

I tried converting an existing SVN repo to git and then adding it to
my main git repo using the subtree merge technique described at
http://www.kernel.org/pub/software/scm/git/docs/howto/using-merge-subtree.html.
 I now have the various files in my repo, but they have no history.
I checked, and my initial SVN to git conversion does contain history.

I'm trying to add an exising repo as a subdir of my main repo with
history included.  Can anyone tell me how to do that?

I'm sorry if I'm phrasing my question badly, or if I'm asking
something that should be obvious...

Thanks!
-Dylan

On Wed, Dec 17, 2008 at 3:49 PM, Miklos Vajna <vmiklos@frugalware.org> wrote:
> On Wed, Dec 17, 2008 at 03:16:59PM -0800, Dylan Martin <dmartin@sccd.ctc.edu> wrote:
>> Sorry if this is a dumb question.  I've poked around the docs and
>> tried the google searches I could think of, but I don't even know what
>> kind of search terms one would use in trying to answer this.
>>
>> I'm a sysadmin and I've got a big monolithic git repo of all my
>> scripts, documents, etc...  It used to be a CVS repo but I converted
>> it to git a while ago.
>> Before I switched to git, I played around with SVN a bit, and started
>> a few tiny SVN repos for various scripts I was working on.  So, I know
>> have one git repo with %90 of my stuff and a handful of SVN repos.
>> I'd like to be able to add the SVN repos as subdirectories inside my
>> git repo.  I've found lots of pages describing how to convert an SVN
>> repo into a _new_ git repo, but I haven't found anything yet about
>> importing the contents of an SVN repo as a subdirectory of an
>> _existing_ git repo.
>
> I would convert each repo to git, then merge them using subtree merge.
> See Documentation/howto/using-merge-subtree.txt.
>
