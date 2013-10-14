From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/2] Add password parameter to git svn commands and use
 it when provided instead of defaulting to end-user prompt
Date: Mon, 14 Oct 2013 18:40:05 +0000
Message-ID: <20131014184005.GA3352@dcvr.yhbt.net>
References: <1381569810-2167-1-git-send-email-arnaud.brejeon@gmail.com>
 <20131014141127.GA21200@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: arnaud.brejeon@gmail.com, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 14 20:40:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVn3y-0007QX-NK
	for gcvg-git-2@plane.gmane.org; Mon, 14 Oct 2013 20:40:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756707Ab3JNSkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 14:40:09 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:55484 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756692Ab3JNSkG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 14:40:06 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF0BA1F6CA;
	Mon, 14 Oct 2013 18:40:05 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20131014141127.GA21200@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236111>

Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
> 
> arnaud.brejeon@gmail.com wrote:
> 
> > Signed-off-by: Arnaud Brejeon <arnaud.brejeon <at> gmail.com>
> 
> Thanks.
> 
> Can you say a little more about the context?  Do you run a script that
> wants to pass a password to 'git svn', do you type it each time on the
> command line, or something else?  Is it ok that the password would
> show up in "ps" output?  Would the platform's keyring or netrc be
> usable here, or is there something in the context that avoids that?

I think using keyring or netrc is more appropriate.  Having a password
on the command-line and visible to all via ps doesn't seem like
something git should support.
