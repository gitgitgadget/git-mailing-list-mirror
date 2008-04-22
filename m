From: Michael Weber <michaelw@foldr.org>
Subject: Re: [PATCH] Always copy template files (no symlinking)
Date: Tue, 22 Apr 2008 21:12:32 +0200
Message-ID: <30F967B1-A971-4F8B-A74D-4BDA8BB184B5@foldr.org>
References: <20080422140359.GA9590@roadkill.foldr.org> <7vprshyg5e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 21:13:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoNvg-0001zQ-Aa
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 21:13:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755316AbYDVTMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 15:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756423AbYDVTMh
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 15:12:37 -0400
Received: from lambda.foldr.org ([88.198.49.16]:45036 "EHLO mail.foldr.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755185AbYDVTMg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 15:12:36 -0400
Received: from roadkill.lan (cc1285279-a.hnglo1.ov.home.nl [82.75.4.249])
	(authenticated bits=0)
	by mail.foldr.org (8.14.2/8.14.2/Debian-3) with ESMTP id m3MJCWcg019333
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Tue, 22 Apr 2008 21:12:34 +0200
In-Reply-To: <7vprshyg5e.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80161>

[accidentally sent as PM]

On Apr 22, 2008, at 19:05 , Junio C Hamano wrote:

> Michael Weber <michaelw@foldr.org> writes:
>
>> Previously, git would readlink(2) template files that are symlinks,
>> and then symlink(2) the result into .git/.  This does not work for
>> relative symlinks (as produced by, e.g., encap), and is probably  
>> not a
>> good idea either: it is an irrelevant detail that a file in the
>> template directory is symlinked.
>
> This was very deliberately done to allow a relative symlink that  
> points at
> e.g. ../../hooks/pre-commit with .git/hooks/pre-commit.  IOW, "use  
> what
> the project suggests".

I see.  How can I get the same functionality on a platform which does  
not support symlinks?


Cheers,
Michael
