From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: git svn: Supporting multiple branch subdirs?
Date: Wed, 17 Jun 2009 11:25:50 -0400
Message-ID: <4A390AFE.5070703@xiplink.com>
References: <4A32CCA5.7040404@xiplink.com> <4A339182.1090204@drmicha.warpmail.net> <4A368509.9070801@xiplink.com> <4A38FCEE.2020002@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>, normalperson@yhbt.net
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jun 17 17:26:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGx1b-0003Vy-53
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 17:26:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483AbZFQPZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 11:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752193AbZFQPZ5
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 11:25:57 -0400
Received: from smtp182.dfw.emailsrvr.com ([67.192.241.182]:48827 "EHLO
	smtp182.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752048AbZFQPZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 11:25:56 -0400
Received: from relay8.relay.dfw.mlsrvr.com (localhost [127.0.0.1])
	by relay8.relay.dfw.mlsrvr.com (SMTP Server) with ESMTP id 7079D40457
	for <git@vger.kernel.org>; Wed, 17 Jun 2009 11:25:59 -0400 (EDT)
Received: by relay8.relay.dfw.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id F1EA840021;
	Wed, 17 Jun 2009 11:25:54 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
In-Reply-To: <4A38FCEE.2020002@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121752>

Michael J Gruber wrote:
> 
>> (Shouldn't that fetch line be head:refs/remots/head, since there's nothing called
>> "trunk" in the svn repo?  I used git-svn init --trunk=head ...)
> 
> The left hand side of the refspec refers to the svn repo, the right hand
> side only names your local ref. Feel free to put "head" there, although
> this can be confused very easily with "HEAD" which has special meaning
> in git.

Sure.  I was mostly wondering why --trunk=head didn't just reuse the name in my local ref.  A minor bug, perhaps?

(And the FreeBSD community commonly refers to that branch as "current", so that's a name I can use locally.)

> P.S.: Let me know if you give it a shot, so that we don't duplicate our
> waste of time...

I have some cycles to work on this, but I'd need some guidance around git-svn's internals.  I'm not even sure where to start implementing the "branches2" hack you described...

		M.
