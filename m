From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb: charset problem
Date: Tue, 25 Oct 2005 10:44:47 -0700
Message-ID: <7v64rlfq40.fsf@assigned-by-dhcp.cox.net>
References: <200510241356.j9ODuAHn005060@laptop11.inf.utfsm.cl>
	<Pine.LNX.4.64.0510241743280.25300@iabervon.org>
	<7vwtk2k08z.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510251138290.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 25 19:45:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUSqy-00041N-0f
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 19:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbVJYRot (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 13:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbVJYRot
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 13:44:49 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:62964 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932225AbVJYRot (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 13:44:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051025174408.PCQX2059.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 25 Oct 2005 13:44:08 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0510251138290.25300@iabervon.org> (Daniel
	Barkalow's message of "Tue, 25 Oct 2005 12:01:15 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10604>

Daniel Barkalow <barkalow@iabervon.org> writes:

> It wouldn't be hard to convert at some point between the editor and the 
> commit object, and you don't re-edit the commit objects like you do 
> tracked files. It probably wouldn't even be hard for commit-tree to 
> convert its input based on locale. (And stuff which prints commit contents 
> for user consumption probably ought to re-encode it if necessary, too)

Don't get me wrong.  I am not opposed to giving preferential
treatment to UTF-8 by supporting it better.  I think it may be a
good idea to have an *option* in commit-tree and mktag to
convert from LC_CTYPE to utf-8, just like mailinfo does.

I am just opposing to make UTF-8 mandatory.
