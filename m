From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git clone questions relating to cpio
Date: Mon, 01 Oct 2007 16:32:48 -0700
Message-ID: <7vwsu6pg0v.fsf@gitster.siamese.dyndns.org>
References: <3f4fd2640710011228w61ce34b5ve47ea529eed384fd@mail.gmail.com>
	<Pine.LNX.4.64.0710020022470.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Reece Dunn <msclrhd@googlemail.com>, Git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 02 01:33:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcUl7-0003Rd-Ol
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 01:33:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbXJAXcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 19:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751757AbXJAXcz
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 19:32:55 -0400
Received: from rune.pobox.com ([208.210.124.79]:32885 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750970AbXJAXcz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 19:32:55 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 4FF9F13FC04;
	Mon,  1 Oct 2007 19:33:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 6B0C113F1C7;
	Mon,  1 Oct 2007 19:33:12 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0710020022470.28395@racer.site> (Johannes
	Schindelin's message of "Tue, 2 Oct 2007 00:23:57 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59650>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 1 Oct 2007, Reece Dunn wrote:
>
>> I am running a Linux From Scratch 6.2 system that does not have cpio
>> installed on it. This means that I can't clone a local repository
>> unless I install cpio.
>
> You might be interested in the workaround Hannes did in mingw.git; he made 
> a wrapper script called 'cpio' using 'tar'.

I think that may be good enough as workaround, but I do not
think you would get the space saving from hardlinks that way.
