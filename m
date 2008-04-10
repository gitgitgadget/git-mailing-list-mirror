From: Robert Haines <rhaines@manchester.ac.uk>
Subject: Re: permissions and packed-refs?
Date: Thu, 10 Apr 2008 17:21:36 +0100
Message-ID: <10723DA2-555B-40DB-8428-BDF07CA2510E@manchester.ac.uk>
References: <320075ff0804100530s2af22cc9r43208101e46a8154@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Nigel Magnay <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 18:22:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjzXC-0002aB-6a
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 18:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757601AbYDJQUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 12:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757561AbYDJQUx
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 12:20:53 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:64015 "EHLO
	probity.mcc.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755867AbYDJQUx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 12:20:53 -0400
Received: from gerhayn.mcc.ac.uk ([10.2.18.1])
	by probity.mcc.ac.uk with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <rhaines@manchester.ac.uk>)
	id 1JjzW7-000MOm-Jw; Thu, 10 Apr 2008 17:20:51 +0100
Received: from client090.roaming.manchester.ac.uk ([130.88.208.90]:52280)
	by gerhayn.mcc.ac.uk with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69 (FreeBSD))
	(envelope-from <rhaines@manchester.ac.uk>)
	id 1JjzW7-000CXY-GG; Thu, 10 Apr 2008 17:20:51 +0100
In-Reply-To: <320075ff0804100530s2af22cc9r43208101e46a8154@mail.gmail.com>
X-Mailer: Apple Mail (2.753)
X-Authenticated-Sender: Robert Haines from client090.roaming.manchester.ac.uk [130.88.208.90]:52280
X-Authenticated-From: Robert.Haines@manchester.ac.uk
X-UoM: Scanned by the University Mail System. See http://www.itservices.manchester.ac.uk/email/filtering/information/ for details.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79237>


On 10 Apr 2008, at 13:30, Nigel Magnay wrote:
> This is likely a really stupid question... a repo that was working,
> has now stopped accepting a push with
>
> Counting objects: 43, done.
> Compressing objects: 100% (18/18)   Compressing objects: 100% (18/18),
> done.
> Writing objects: 100% (23/23)   Writing objects: 100% (23/23), 4.65  
> KiB,
> done.
> Total 23 (delta 10), reused 0 (delta 0)
> error: Unable to append to logs/refs/heads/realtime: Permission denied
> Pushing to ssh://10.1.3.153/pub/scm/git/git-svn/realtime.git
> To ssh://10.1.3.153/pub/scm/git/git-svn/realtime.git
>  ! [remote rejected] realtime -> realtime (failed to write)
> error: failed to push some refs to
> 'ssh://10.1.3.153/pub/scm/git/git-svn/realtime.git'
>
> I think git gc was run on the server at some point, as the head in
> question has been shifted into packed-refs.

I've seen this after git gc too. Has the owner of the affected files  
changed? If so you need to make sure that git gc is run by the  
correct user. If you run it as root for example, everything it  
touches will end up owned by root!

Cheers,
Rob
