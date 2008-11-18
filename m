From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [small bug] Surprising "Did you mean this?"
Date: Tue, 18 Nov 2008 18:05:38 +0100
Message-ID: <vpqod0dezh9.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 18 18:16:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2UC9-0001pP-Nw
	for gcvg-git-2@gmane.org; Tue, 18 Nov 2008 18:16:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755252AbYKRRPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 12:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755187AbYKRRPa
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 12:15:30 -0500
Received: from imag.imag.fr ([129.88.30.1]:43016 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754436AbYKRRP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2008 12:15:28 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id mAIH5c20013213
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 18 Nov 2008 18:05:38 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1L2U1C-00007H-3P; Tue, 18 Nov 2008 18:05:38 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1L2U1C-0002so-19; Tue, 18 Nov 2008 18:05:38 +0100
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 18 Nov 2008 18:05:38 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101275>

Hi,

The following is quite surprising:

  $ git tags 
  git: 'tags' is not a git-command. See 'git --help'.
  
  Did you mean this?
          status
  
I would have expected git to propose me "tag" (1 character removal),
while "status" is quite far from "tags" (remove g, add u, add another
t, shuffle and you're there).

my 2 cents,

-- 
Matthieu
