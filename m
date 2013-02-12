From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: A good Git technique for referring back to original files
Date: Tue, 12 Feb 2013 09:56:34 +0100
Message-ID: <vpq1ucl9agt.fsf@grenoble-inp.fr>
References: <loom.20130212T085620-989@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: MikeW <mw_phil@yahoo.co.uk>
X-From: git-owner@vger.kernel.org Tue Feb 12 09:57:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5Bfi-0004jF-UU
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 09:57:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277Ab3BLI4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 03:56:39 -0500
Received: from mx1.imag.fr ([129.88.30.5]:46613 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932089Ab3BLI4i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 03:56:38 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r1C8uYw1027090
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 12 Feb 2013 09:56:34 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1U5BfG-0001o4-Vd; Tue, 12 Feb 2013 09:56:34 +0100
In-Reply-To: <loom.20130212T085620-989@post.gmane.org> (MikeW's message of
	"Tue, 12 Feb 2013 08:11:27 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 12 Feb 2013 09:56:34 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r1C8uYw1027090
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1361264196.08996@/SIY2C8yS1P8r09poHNnhg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216121>

MikeW <mw_phil@yahoo.co.uk> writes:

> Since git is so good at tracking file content, I wondered whether there was any
> technique using git that would simplify the back-referencing task.

I'm not sure I understand the question, but if you want to add meta-data
to Git commits (e.g. "this Git commit is revision 42 in CVS repository
foo"), then have a look at git-notes. It won't give you directly
"reference to other VCS", but at least can be used as a storage
mechanism to store these references.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
