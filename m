From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3] git-send-email.perl: make initial In-Reply-To apply only to first email
Date: Fri, 05 Nov 2010 23:36:02 +0100
Message-ID: <vpqtyjvo0tp.fsf@bauges.imag.fr>
References: <20101020004533.b64d446c.ospite@studenti.unina.it>
	<1288990769-13307-1-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Antonio Ospite <ospite@studenti.unina.it>
X-From: git-owner@vger.kernel.org Fri Nov 05 23:39:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEUwS-0004kH-0Z
	for gcvg-git-2@lo.gmane.org; Fri, 05 Nov 2010 23:39:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755026Ab0KEWjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Nov 2010 18:39:24 -0400
Received: from imag.imag.fr ([129.88.30.1]:44677 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755020Ab0KEWjX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Nov 2010 18:39:23 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id oA5Ma373004207
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 5 Nov 2010 23:36:03 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PEUt9-0000NL-DM; Fri, 05 Nov 2010 23:36:03 +0100
In-Reply-To: <1288990769-13307-1-git-send-email-ospite@studenti.unina.it> (Antonio Ospite's message of "Fri\,  5 Nov 2010 21\:59\:29 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 05 Nov 2010 23:36:04 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160828>

Antonio Ospite <ospite@studenti.unina.it> writes:

> When an initial In-Reply-To is supplied it should apply only to the
> first email, second and subsequent messages should behave just according
> to the --[no-]chain-reply-to setting; this is the typical behaviour we
> want when we send a series with cover letter in reply to some
> discussion,

+1 on this. I've been biten by this behavior sending the v2 of
a patch serie --in-reply-to the cover letter for the v1. The two
versions of each patch appear as reply to the original cover letter,
it's kind of a mess. I was really expecting the patch serie to appear
as a separate subtree in the discussion.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
