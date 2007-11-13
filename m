From: Sergei Organov <osv@javad.com>
Subject: Re: [Newbie] How to *actually* get rid of remote tracking branch?
Date: Tue, 13 Nov 2007 21:44:11 +0300
Message-ID: <874pfq7zpg.fsf@osv.gnss.ru>
References: <874pfq9q8s.fsf@osv.gnss.ru> <fhcdpv$9u3$1@ger.gmane.org>
	<87ve86889o.fsf@osv.gnss.ru>
	<Pine.LNX.4.64.0711131600590.4362@racer.site>
	<87prye832v.fsf@osv.gnss.ru>
	<Pine.LNX.4.64.0711131819490.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 13 19:45:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is0lJ-0003Fb-4h
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 19:45:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760523AbXKMSo1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 13:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761338AbXKMSo0
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 13:44:26 -0500
Received: from javad.com ([216.122.176.236]:1863 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760523AbXKMSoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 13:44:25 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lADIiG056061;
	Tue, 13 Nov 2007 18:44:17 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1Is0k7-0005DE-5p; Tue, 13 Nov 2007 21:44:11 +0300
In-Reply-To: <Pine.LNX.4.64.0711131819490.4362@racer.site> (Johannes Schindelin's message of "Tue\, 13 Nov 2007 18\:21\:18 +0000 \(GMT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64825>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Tue, 13 Nov 2007, Sergei Organov wrote:
>
>> Sorry, but *I* didn't *explicitly* fetch it _again_!
>> 
>> 1. I cloned git.git repo making no custom steps.
>
> Which means that you wanted to track that repository.  Yes, the complete 
> repository.  Not a single branch.  Not all branches except a single one.
>
>> 2. I decided I don't need to track some of branches.
>
> The you should have done that.

I think I did my best to try to do that (basing my attempts on current
git documentation). Isn't it?

> But that is different from "I decided to delete the tracking
> _branch_".

Yes, but the question is *why*? Isn't it an obvious application of
deleting tracking branch? And, as I've already asked in another
sub-thread of this one, what the following example in the man git-branch
is supposed to achieve?:

<quote Documentation/git-branch.txt>
Delete unneeded branch::
+
------------
$ git clone git://git.kernel.org/.../git.git my.git
$ cd my.git
$ git branch -d -r origin/todo origin/html origin/man   <1>
$ git branch -D test                                    <2>
------------
+
<1> Delete remote-tracking branches "todo", "html", "man"
</quote>

Sorry, but I still believe that it's not me who needs fixing.

-- 
Sergei.
