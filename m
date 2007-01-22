From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: commit message columns
Date: Mon, 22 Jan 2007 16:44:19 -0500
Message-ID: <20070122214419.GD6614@fieldses.org>
References: <20070122211902.GC6614@fieldses.org> <20070122212304.GA17243@vual.tchpc.tcd.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 22:45:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H96xk-0002s1-27
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 22:44:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbXAVVoV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 16:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751851AbXAVVoV
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 16:44:21 -0500
Received: from mail.fieldses.org ([66.93.2.214]:47342 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751838AbXAVVoU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 16:44:20 -0500
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1H96xf-0002aa-Py; Mon, 22 Jan 2007 16:44:19 -0500
To: Jimmy Tang <jtang+2007-01@tchpc.tcd.ie>
Content-Disposition: inline
In-Reply-To: <20070122212304.GA17243@vual.tchpc.tcd.ie>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37459>

On Mon, Jan 22, 2007 at 09:23:04PM +0000, Jimmy Tang wrote:
> Hi,
> 
> On Mon, Jan 22, 2007 at 04:19:02PM -0500, J. Bruce Fields wrote:
> > Uh, I feel like I must be missing something simple here--when editing
> > commit messages, you'd like the editor (vim in my case) to wrap text
> > sooner than it normally would, since commit messages are displayed
> > indented.  What's the easiest way to ensure this always happens?
> 
> vim -c 'set tw=60'
> 
> where 60 is the column width. dont know how useful that is to you though

I was trying to figure out how to get that for git's invocations of vim,
but not all others.

But, come to think of it, maybe I'd rather have the textwidth just be 72
everywhere.

--b.
