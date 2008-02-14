From: Sergei Organov <osv@javad.com>
Subject: Re: git clone through http bug?
Date: Thu, 14 Feb 2008 21:28:14 +0300
Message-ID: <87r6fftmtd.fsf@osv.gnss.ru>
References: <873arvv479.fsf@osv.gnss.ru>
	<ee77f5c20802140936y28be9b39i59753af66e1a5e36@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "David Symonds" <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 19:29:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPipQ-0005yM-9t
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 19:29:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755378AbYBNS2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 13:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754019AbYBNS2Y
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 13:28:24 -0500
Received: from javad.com ([216.122.176.236]:2156 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754729AbYBNS2X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 13:28:23 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id m1EISKd74242;
	Thu, 14 Feb 2008 18:28:21 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1JPiog-0001HE-SH; Thu, 14 Feb 2008 21:28:14 +0300
In-Reply-To: <ee77f5c20802140936y28be9b39i59753af66e1a5e36@mail.gmail.com> (David Symonds's message of "Thu\, 14 Feb 2008 09\:36\:22 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73903>

"David Symonds" <dsymonds@gmail.com> writes:
> On Thu, Feb 14, 2008 at 9:27 AM, Sergei Organov <osv@javad.com> wrote:
>> Hello,
>>
>>  I've just cloned the public repo (it's rather small):
>>
>>  $ git clone http://ydirson.free.fr/soft/git/cvsps.git
>>
>>  and it has created cvsps/.git, but no working copy.
>
> That's because the remote side doesn't have a HEAD. Just run "git
> checkout --track -b master origin/master" to create a local branch the
> tracks the origin/master branch.

Thanks, that works:

$ git checkout --track -b master origin/master
warning: You appear to be on a branch yet to be born.
warning: Forcing checkout of origin/master.
Already on branch "master"
$

Couldn't GIT be more clever and just do this for me? Besides, the fact
that it has created HEAD that points nowhere still seems wrong.

-- Sergei.
