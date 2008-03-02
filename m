From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make builtin-reset.c use parse_options.
Date: Sat, 01 Mar 2008 18:53:45 -0800
Message-ID: <7vir05x2di.fsf@gitster.siamese.dyndns.org>
References: <47C98472.8000002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 03:54:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVeLn-0007tS-Ds
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 03:54:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbYCBCx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 21:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbYCBCx4
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 21:53:56 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61254 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695AbYCBCxz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 21:53:55 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 067951FBF;
	Sat,  1 Mar 2008 21:53:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 703D91FBE; Sat,  1 Mar 2008 21:53:48 -0500 (EST)
In-Reply-To: <47C98472.8000002@gmail.com> (Carlos Rica's message of "Sat, 01
 Mar 2008 17:29:38 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75717>

Carlos Rica <jasampler@gmail.com> writes:

> Signed-off-by: Carlos Rica <jasampler@gmail.com>

Hmmm.  "git reset -h" now defaults to --hard? 

It somehow feels a bit risky for new people.  I dunno.
