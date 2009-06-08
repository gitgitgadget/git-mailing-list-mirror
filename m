From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] show-branch: don't use LASTARG_DEFAULT with OPTARG
Date: Mon, 08 Jun 2009 19:24:30 +0200
Message-ID: <4A2D494E.3030803@lsrfire.ath.cx>
References: <4A2ACE32.8080504@gmail.com> <1244417955-21226-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git list <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@madism.org>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 19:25:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDiad-00051n-U2
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 19:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbZFHRYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 13:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751872AbZFHRYq
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 13:24:46 -0400
Received: from india601.server4you.de ([85.25.151.105]:37200 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbZFHRYq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 13:24:46 -0400
Received: from [10.0.1.101] (p57B7D4B6.dip.t-dialin.net [87.183.212.182])
	by india601.server4you.de (Postfix) with ESMTPSA id F2B502F8055;
	Mon,  8 Jun 2009 19:24:46 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1244417955-21226-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121090>

Stephen Boyd schrieb:
> 5734365 (show-branch: migrate to parse-options API 2009-05-21)
> incorrectly set the --more option's flags to be
> PARSE_OPT_LASTARG_DEFAULT and PARSE_OPT_OPTARG. These two flags
> shouldn't be used together. An option taking a default should just set
> the default value desired and parse options will take care of the rest.
> 
> Update the header comment to better convey this information.

Thank you!
