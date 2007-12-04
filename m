From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-add--interactive works only in top level
Date: Mon, 03 Dec 2007 22:22:51 -0800
Message-ID: <7vmysr9dxg.fsf@gitster.siamese.dyndns.org>
References: <058EB5A2-1EFE-43B9-9886-7272A955CE51@mit.edu>
	<7vwsrv9fos.fsf@gitster.siamese.dyndns.org>
	<4BC1648E-3059-4373-B388-65AD739796D8@MIT.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Reid Barton <rwbarton@MIT.EDU>
X-From: git-owner@vger.kernel.org Tue Dec 04 07:23:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzRBe-00051f-Qr
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 07:23:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbXLDGW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 01:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751592AbXLDGW5
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 01:22:57 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:47392 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569AbXLDGW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 01:22:56 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 6C0BF2F0;
	Tue,  4 Dec 2007 01:23:17 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 03F469AC01;
	Tue,  4 Dec 2007 01:23:14 -0500 (EST)
In-Reply-To: <4BC1648E-3059-4373-B388-65AD739796D8@MIT.EDU> (Reid Barton's
	message of "Tue, 4 Dec 2007 01:07:12 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67008>

Reid Barton <rwbarton@MIT.EDU> writes:

> I understand that programs such as git-add--interactive will be moved
> out of the executable path not too long from now, which will also
> ameliorate the situation.

Honestly, there is nothing to ameliorate.  We do not even document
git-add--interactive on purpose.

Once I saw somebody who somehow got a root account on a shared UNIX box
and tryed running everything he found under /sbin one after another
without understanding what he was doing.  Needless to say, the box did
not last too long.  Somehow that "tab completion" comment reminds of
him.
