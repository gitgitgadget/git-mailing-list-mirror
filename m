From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: VCS comparison table
Date: Mon, 16 Oct 2006 23:35:53 +0100
Message-ID: <45340949.9070606@shadowen.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <egr3ud$nqm$1@sea.gmane.org> <45340713.6000707@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 00:36:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZb4a-0001Mf-Dv
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 00:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422881AbWJPWge (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 18:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422888AbWJPWge
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 18:36:34 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:50194 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1422881AbWJPWge (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Oct 2006 18:36:34 -0400
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1GZb3q-0000bX-Pj; Mon, 16 Oct 2006 23:35:54 +0100
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
To: Aaron Bentley <aaron.bentley@utoronto.ca>
In-Reply-To: <45340713.6000707@utoronto.ca>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28990>

Aaron Bentley wrote:

>>> Git supports renames in its own way; it doesn't use file ids, nor
>>> remember renames (the new "note" header for use e.g. by porcelains 
>>> didn't pass if I remember correctly). But it does *detect* moving
>>> _contents_, and even *copying* _contents_ when requested. And of
>>> course it detect renames in merges.
> 
> You'll note we referred to that bevhavior on the page.  We don't think
> what Git does is the same as supporting renames.  AIUI, some Git users
> feel the same way.

In my experience there are two key features to rename support.  The
first that files move about efficiently ie. we don't have to carry a
different copy of the same file for each name it has had, this git
handles nicely.  The second is the seemless following of history 'back',
this git does not do trivially (when limited to specific files).  git
log on a renamed file pretty much stops at the rename point and you have
deal with it yourself.

I would love to see someone respond with a pickaxe like command line
which would list each and every change and its origin though merges and
the like.

Hmmm.

-apw
