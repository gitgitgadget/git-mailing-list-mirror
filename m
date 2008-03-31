From: John Goerzen <jgoerzen@complete.org>
Subject: Re: Git vs svn. Is ... possible ?
Date: Mon, 31 Mar 2008 10:41:08 -0500
Message-ID: <slrnfv21gk.b4c.jgoerzen@katherina.lan.complete.org>
References: <20080328132438.GA32646@blackspire>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 31 18:09:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgMZQ-0007ia-2T
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 18:09:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751752AbYCaQId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 12:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751710AbYCaQId
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 12:08:33 -0400
Received: from main.gmane.org ([80.91.229.2]:45710 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751554AbYCaQId (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 12:08:33 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JgMYh-0000mr-4v
	for git@vger.kernel.org; Mon, 31 Mar 2008 16:08:31 +0000
Received: from 63-245-179-205.kitusa.com ([63.245.179.205])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 31 Mar 2008 16:08:31 +0000
Received: from jgoerzen by 63-245-179-205.kitusa.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 31 Mar 2008 16:08:31 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 63-245-179-205.kitusa.com
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78589>

On 2008-03-28, Rafa? Mu?y?o <galtgendo@o2.pl> wrote:
> Well, the actual question is:
> In svn I can do a remote diff (diff between two remote revisions) without
> having to do a checkout, is this possible for git ?

You can craft URLs to gitweb in specific ways to do this.  For
instance:

http://git.complete.org/branches/redmine-integration/?a=commitdiff_plain;h=fb-bug-738-projects-block;hp=upstream

Shows the diff from branch upstream to branch
fb-bug-738-projects-block.  You can replace the branch names with the
full 40-character SHA1 ids as well.

Leave off the "_plain" and you get diff highlighting.

The header at the top of this thing is going to be a bit misleading,
but the content is what you want.

-- John
