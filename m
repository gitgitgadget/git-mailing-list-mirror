From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] git/gitweb.git repository
Date: Tue, 04 Sep 2007 01:19:25 -0700
Message-ID: <7vejhe7she.fsf@gitster.siamese.dyndns.org>
References: <20070831000149.GK1219@pasky.or.cz>
	<7v8x7n7zqn.fsf@gitster.siamese.dyndns.org>
	<20070904055048.GW18160@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org, jnareb@gmail.com,
	ltuikov@yahoo.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 04 10:19:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISTdN-0001je-Ea
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 10:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121AbXIDITh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 04:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752115AbXIDITh
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 04:19:37 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:35982 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752081AbXIDITg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 04:19:36 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id D60E812C53E;
	Tue,  4 Sep 2007 04:19:49 -0400 (EDT)
In-Reply-To: <20070904055048.GW18160@spearce.org> (Shawn O. Pearce's message
	of "Tue, 4 Sep 2007 01:50:48 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57539>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> * Incremental blame
>> 
>>   It does not seem to break the blame, but at least from where I
>>   sit accessing repo.or.cz this does not look incremental to me.
>>   The entire browser session freezes until the blame page
>>   displays in full.  My local installation behaves the same way.
>
> What kind of repo are you trying that on?

linux-2.6.git (block/ll_rw_blk.c).

But I think I figured it out.  With firebug disabled, I can see
it is trying incremental.
