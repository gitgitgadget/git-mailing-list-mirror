From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bash completion: Hide more plumbing commands
Date: Tue, 26 Aug 2008 11:25:35 -0700
Message-ID: <7v1w0bab1c.fsf@gitster.siamese.dyndns.org>
References: <20080826171012.GO10360@machine.or.cz>
 <20080826171144.21328.82727.stgit@localhost>
 <20080826172410.GJ26523@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	gitster@pobox.com, andi@firstfloor.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 26 20:27:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY3Fk-0006jY-Qc
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 20:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757228AbYHZSZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 14:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754524AbYHZSZs
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 14:25:48 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59484 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571AbYHZSZs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 14:25:48 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4239969060;
	Tue, 26 Aug 2008 14:25:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6AA2A6905B; Tue, 26 Aug 2008 14:25:40 -0400 (EDT)
In-Reply-To: <20080826172410.GJ26523@spearce.org> (Shawn O. Pearce's message
 of "Tue, 26 Aug 2008 10:24:10 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6716AF52-739C-11DD-B316-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93794>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Petr Baudis <pasky@suse.cz> wrote:
>> git <tab><tab> still shows way too many commands, some of them
>> are clearly plumbing. This patch hides the plumbing commands
>> liberally (that is, in special cases, users still might want to
>> call one of the hidden commands, a *normal* workflow should never
>> involve these, though - and if it does, we have a UI problem anyway).
>> 
>> Signed-off-by: Petr Baudis <pasky@suse.cz>
>
> Acked-by: Shawn O. Pearce <spearce@spearce.org>
>
> Though I use git ls-remote at least once every other day to see
> what branches are available on my egit/spearce.git fork.  Its ok,
> I guess I can type a few extra characters...

Revision-requested-by: me

Unless/until we have an easy way to obtain the information "git-ls-files
-u" gives during conflict resolution, ls-files should stay on the list of
commonly used commands.
