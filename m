From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make git-clone obey "--" (end argument parsing)
Date: Fri, 02 Nov 2007 14:32:11 -0700
Message-ID: <7vwst0z63o.fsf@gitster.siamese.dyndns.org>
References: <20071102142150.GD9632@jolt.modeemi.cs.tut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Heikki Orsila <shd@modeemi.fi>
X-From: git-owner@vger.kernel.org Fri Nov 02 22:32:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io481-0000i2-Ep
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 22:32:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754522AbXKBVcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 17:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754375AbXKBVcS
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 17:32:18 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:44055 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122AbXKBVcR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 17:32:17 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 486352EF;
	Fri,  2 Nov 2007 17:32:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id D3C8E91820;
	Fri,  2 Nov 2007 17:32:35 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63178>

Heikki Orsila <shd@modeemi.fi> writes:

> Junio C Hamano wrote:
>> I do not think this breaks anything, but does it _help_
>> anything in practice?
>> 
>> What kind of breakage does this patch fix?
>
> It doesn't fix anything, but it is a good usability standard to obey --.
> I was creating a script that would _automatically_ clone repositories of 
> other users. As a little bit pedantic shell script writer I added "--" 
> and noticed that git clone doesn't handle that,...

The first real parameter will always be the remote repo
URL^Wlocator, and sane people won't have anything that begin
with a hyphen for that, will they?

So the change is only for consistency's sake.

I am not saying that is a bad thing.  I just wanted to
understand if there was a real breakage there.

Thanks. Will apply.
