From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] Support "core.excludesfile = ~/.gitignore"
Date: Tue, 26 Aug 2008 08:42:18 +0200
Message-ID: <48B3A5CA.6090201@viscovery.net>
References: <quack.20080821T2114.lthvdxtvg7b@roar.cs.berkeley.edu>	<7vsksw92nh.fsf@gitster.siamese.dyndns.org>	<quack.20080824T0140.lth3aku956e@roar.cs.berkeley.edu>	<7vprnyqo59.fsf@gitster.siamese.dyndns.org>	<20080824220854.GA27299@coredump.intra.peff.net>	<7vzln2j9y2.fsf@gitster.siamese.dyndns.org>	<20080824231343.GC27619@coredump.intra.peff.net>	<7vhc9aj82i.fsf@gitster.siamese.dyndns.org> <quack.20080825T1207.lthk5e46hi4_-_@roar.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Karl Chen <quarl@cs.berkeley.edu>
X-From: git-owner@vger.kernel.org Tue Aug 26 08:43:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXsH1-0001Cs-DW
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 08:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbYHZGmX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 02:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbYHZGmX
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 02:42:23 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:4725 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbYHZGmX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 02:42:23 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KXsFu-00042B-Jo; Tue, 26 Aug 2008 08:42:18 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 60A4554D; Tue, 26 Aug 2008 08:42:18 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <quack.20080825T1207.lthk5e46hi4_-_@roar.cs.berkeley.edu>
X-Spam-Score: 3.8 (+++)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5, SUBJECT_FUZZY_TION=2.08
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93715>

Karl Chen schrieb:
> +/*
> + * Expand ~ and ~user.  Returns a newly malloced string.  (If input does not
> + * start with "~", equivalent to xstrdup.)
> + */
> +static char *expand_userdir(const char *value) {

There is user_path() in path.c that does the same thing.

Watch your style: The opening brace of functions is on the next line.

-- Hannes
