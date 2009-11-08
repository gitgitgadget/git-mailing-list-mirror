From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [RFC/PATCH 1/4] Teach the --all option to 'git fetch'
Date: Sun, 08 Nov 2009 22:08:11 +0100
Message-ID: <hd7bvr$aul$2@ger.gmane.org>
References: <4AF6E7A6.5060209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 08 22:08:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7F0A-0007BN-4o
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 22:08:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755098AbZKHVIf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Nov 2009 16:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755094AbZKHVIf
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 16:08:35 -0500
Received: from lo.gmane.org ([80.91.229.12]:60403 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755048AbZKHVIe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2009 16:08:34 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N7Ezy-00077k-1L
	for git@vger.kernel.org; Sun, 08 Nov 2009 22:08:34 +0100
Received: from 85.93.118.17 ([85.93.118.17])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 08 Nov 2009 22:08:34 +0100
Received: from bonzini by 85.93.118.17 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 08 Nov 2009 22:08:34 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 85.93.118.17
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.4pre) Gecko/20091014 Fedora/3.0-2.8.b4.fc11 Lightning/1.0pre Thunderbird/3.0b4
In-Reply-To: <4AF6E7A6.5060209@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132415>

On 11/08/2009 04:45 PM, Bj=C3=B6rn Gustavsson wrote:
> 'git remote' is meant for managing remotes and 'git fetch' is meant
> for actually fetching data from remote repositories. Therefore, it is
> not logical that you must use 'git remote update' to fetch from
> more than one repository at once.
>
> Add the --all option to 'git fetch', to tell it to attempt to fetch
> from all remotes. Also, if --all is not given, the<repository>
> argument is allowed to be the name of a group, to allow fetching
> from all repositories in the group.
>
> Other options except -v and -q are silently ignored.

I'm not sure about the naming of the option.  The reason is that while=20
there is no "git remote push", it makes sense (at least in this case=20
symmetry) between "git fetch" and "git push".  I would love to have a=20
way to push to multiple remotes, for one thing. :-)

What about having "git fetch --multiple" without arguments do the same=20
thing as "git fetch --all" (possibly renaming skipFetchAll to=20
skipFetchDefault)?

Paolo
