From: David Kastrup <dak@gnu.org>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 05 Sep 2007 10:47:48 +0200
Message-ID: <86tzq9cxcb.fsf@lola.quinscape.zz>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org> <200709051013.39910.johan@herland.net> <vpqtzq91p5z.fsf@bauges.imag.fr> <200709051042.04345.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 05 10:48:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISqYa-00056o-6k
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 10:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756022AbXIEIsL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 04:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755977AbXIEIsK
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 04:48:10 -0400
Received: from main.gmane.org ([80.91.229.2]:56221 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755966AbXIEIsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 04:48:09 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ISqYI-0000By-Qm
	for git@vger.kernel.org; Wed, 05 Sep 2007 10:47:58 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Sep 2007 10:47:58 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Sep 2007 10:47:58 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:Uof/F4LYVhiNYwvXeU+DWXUoNtg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57689>

Johan Herland <johan@herland.net> writes:

> On Wednesday 05 September 2007, Matthieu Moy wrote:
>> Johan Herland <johan@herland.net> writes:
>> 
>> > When git-fetch and git-commit has done its job and is about to exit, it checks 
>> > the number of loose object, and if too high tells the user something 
>> > like "There are too many loose objects in the repo, do you want me to repack? 
>> > (y/N)". If the user answers "n" or simply <Enter>,
>> 
>> I don't like commands to be interactive if they don't _need_ to be so.
>> It kills scripting, it makes it hard for a front-end (git gui or so)
>> to use the command, ...
>
> Ok, so add an option or config variable to turn on/off this behaviour.

A bad idea which one can turn optionally off remains a bad idea for
everyone that has not been bitten enough by it already to actually
look up the problem and remedy.

Make this a warning.

-- 
David Kastrup
