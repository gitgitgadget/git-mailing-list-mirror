From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: git-send-email, prompt for Message-ID: bug or feature?
Date: Thu, 07 Jan 2010 17:59:32 +0100
Message-ID: <vpqr5q1lukr.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 07 18:02:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSvkg-0008RV-0A
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 18:02:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753309Ab0AGRCU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 12:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753247Ab0AGRCU
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 12:02:20 -0500
Received: from imag.imag.fr ([129.88.30.1]:42327 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752888Ab0AGRCT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 12:02:19 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o07GxWeT025414
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 7 Jan 2010 17:59:33 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NSvhs-0007DK-Hx; Thu, 07 Jan 2010 17:59:32 +0100
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 07 Jan 2010 17:59:35 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

When I send a mail with

  git send-email -s --to git@vger.kernel.org --annotate -1

I normally get prompted for my from address, and then "Message-ID to
be used as In-Reply-To for the first email?".

If I set sendemail.from to avoid the first question, then the same
question doesn't ask for a Message-ID anymore.

This behavior seems to have been introduced here:

  commit 1f038a0c31e06e7a248be0990549ac717399c540
  Author:	Ryan Anderson <ryan@michonline.com>  Mon Sep  5 07:13:07 2005
  Committer:	Junio C Hamano <junkio@cox.net>  Mon Sep  5 08:33:17 2005
  
  [PATCH] Make git-send-email-script ignore some unnecessary options when operating in batch mode.
  
  Add a "--compose" option that uses $EDITOR to edit an "introductory" email to the patch series.

I understand the need to be possibly non-interactive, but how does one
get git send-email ask just one question for the Message-ID, and skip
the others?

Thanks,
  
-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
