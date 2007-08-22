From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Wed, 22 Aug 2007 17:41:19 +0200
Message-ID: <86sl6bd1b4.fsf@lola.quinscape.zz>
References: <46CC3090.7080500@gmail.com> <86absjenc3.fsf@lola.quinscape.zz> <46CC3C17.8040901@op5.se> <864pirej6w.fsf@lola.quinscape.zz> <20070822144943.GA25527@glandium.org> <20070822150252.GA10531@pe.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 17:41:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INsKt-00089d-N9
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 17:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762803AbXHVPlc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 11:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762769AbXHVPlc
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 11:41:32 -0400
Received: from main.gmane.org ([80.91.229.2]:41406 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762581AbXHVPlb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 11:41:31 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1INsKl-00020H-Er
	for git@vger.kernel.org; Wed, 22 Aug 2007 17:41:27 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Aug 2007 17:41:27 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Aug 2007 17:41:27 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:HbES7He72E/CWniRXlvlqOZmY3I=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56393>

Chris Shoemaker <c.shoemaker@cox.net> writes:

> On Wed, Aug 22, 2007 at 04:49:43PM +0200, Mike Hommey wrote:
>> On Wed, Aug 22, 2007 at 04:29:43PM +0200, David Kastrup <dak@gnu.org> wrote:
>> > The problem I see is that C sucks really really bad as a scripting
>> > language, and tying together plumbing functionality into porcelain is
>> > one of the most powerful, flexible and hack-friendly features of git.
>> > Deprecating scripts is making git more opaque.
>> (...)
>> 
>> Having tools being implemented in C rather than shell won't remove the
>> tools for you to be able to write scripts and do your plumbing. It might
>> remove some examples for you to write your plumbing, though.
>
> Actually, the scripts are being moved into contrib/examples for this
> reason, so, they're still available.

But they will eventually fall prey to bitrot and stop corresponding to
the actual documented commands.

-- 
David Kastrup
