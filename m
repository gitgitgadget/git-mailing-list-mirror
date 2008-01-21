From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git gui and commit-msg hook
Date: Sun, 20 Jan 2008 20:32:40 -0800
Message-ID: <7vmyqz3ijb.fsf@gitster.siamese.dyndns.org>
References: <054F21930D24A0428E5B4588462C7AEDC5F8DB@ednex512.dsto.defence.gov.au>
	<054F21930D24A0428E5B4588462C7AEDC5F8DC@ednex512.dsto.defence.gov.au>
	<20080121040819.GE24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Blucher, Guy" <Guy.Blucher@dsto.defence.gov.au>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 05:33:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGoLV-0008CQ-Tm
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 05:33:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756480AbYAUEct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 23:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756800AbYAUEct
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 23:32:49 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54871 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756305AbYAUEcs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 23:32:48 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CDE03BE6;
	Sun, 20 Jan 2008 23:32:47 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id AA71D3BE5;
	Sun, 20 Jan 2008 23:32:42 -0500 (EST)
In-Reply-To: <20080121040819.GE24004@spearce.org> (Shawn O. Pearce's message
	of "Sun, 20 Jan 2008 23:08:19 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71214>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> "Blucher, Guy" <Guy.Blucher@dsto.defence.gov.au> wrote:
>> I've just setup a commit-msg hook in my local repository.  It works as
>> advertised from the command-line when using git commit, but if I use git
>> gui to do the commit, then the hook is ignored.
>
> Fixed in my latest git-gui master, which will be gitgui-0.9.2 or .3.
>
> I apparently missed git 1.5.4-rc4, but will have to ask Junio nicely
> if this can be included into 1.5.4 final.

Absolutely.  That's a consistency-and-usability bugfix, isn't
it?
