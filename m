From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-add--interactive works only in top level
Date: Mon, 03 Dec 2007 21:44:51 -0800
Message-ID: <7vwsrv9fos.fsf@gitster.siamese.dyndns.org>
References: <058EB5A2-1EFE-43B9-9886-7272A955CE51@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Reid Barton <rwbarton@MIT.EDU>
X-From: git-owner@vger.kernel.org Tue Dec 04 06:45:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzQat-0004xu-KO
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 06:45:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbXLDFo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 00:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbXLDFo5
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 00:44:57 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:49322 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456AbXLDFo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 00:44:56 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id C971B2EF;
	Tue,  4 Dec 2007 00:45:17 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 649669A9C4;
	Tue,  4 Dec 2007 00:45:15 -0500 (EST)
In-Reply-To: <058EB5A2-1EFE-43B9-9886-7272A955CE51@mit.edu> (Reid Barton's
	message of "Mon, 3 Dec 2007 22:19:32 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67005>

Reid Barton <rwbarton@MIT.EDU> writes:

> When the working directory is not the top of the working tree, git-
> add--interactive fails silently and confusingly.

Sheesh, you got me worried.

This is a non issue; git-add--interactive is not for direct end user
consumption.  It relies on being run from git-add wrapper, which does
cdup to the top of the work tree before launching add--interactive
helper.
