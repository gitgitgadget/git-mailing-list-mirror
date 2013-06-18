From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH 4/8] status: do not depend on rebase reflog messages
Date: Tue, 18 Jun 2013 13:40:07 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1306181338330.10630@perkele.intern.softwolves.pp.se>
References: <1371557670-12534-1-git-send-email-artagnon@gmail.com> <1371557670-12534-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 14:40:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UovCv-0000Sy-Br
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 14:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262Ab3FRMkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 08:40:14 -0400
Received: from mx.getmail.no ([84.210.184.8]:60991 "EHLO bouvier.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755275Ab3FRMkL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 08:40:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by bouvier.getmail.no (Postfix) with ESMTP id 3809F45E2E;
	Tue, 18 Jun 2013 14:40:13 +0200 (CEST)
X-Spam-Flag: NO
X-Spam-Score: -2.87
X-Spam-Level: 
X-Spam-Status: No, score=-2.87 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, T_FAKE_REPLY_SURE_A=0.01,
	T_FAKE_REPLY_SURE_B=0.01, T_KHOP_THREADED=-0.01,
	T_LONG_HEADER_LINE_80=0.01, T_UNKNOWN_ORIGIN=0.01] autolearn=ham
Received: from bouvier.getmail.no ([127.0.0.1])
	by localhost (bouvier.get.c.bitbit.net [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id qHrpwXhSu81X; Tue, 18 Jun 2013 14:40:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by bouvier.getmail.no (Postfix) with ESMTP id 7B3FE45E60;
	Tue, 18 Jun 2013 14:40:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
Received: from bouvier.getmail.no ([127.0.0.1])
	by localhost (bouvier.get.c.bitbit.net [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FvXh9FzVIGLD; Tue, 18 Jun 2013 14:40:12 +0200 (CEST)
Received: from perkele (cm-84.215.89.29.getinternet.no [84.215.89.29])
	by bouvier.getmail.no (Postfix) with ESMTP id 5B41E45E51;
	Tue, 18 Jun 2013 14:40:12 +0200 (CEST)
Received: by perkele (Postfix, from userid 501)
	id DF9B22FCF3; Tue, 18 Jun 2013 14:40:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by perkele (Postfix) with ESMTP id DC3E62FCF2;
	Tue, 18 Jun 2013 13:40:07 +0100 (CET)
In-Reply-To: <1371557670-12534-5-git-send-email-artagnon@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228223>

Ramkumar Ramachandra:

> +				on_what = _("rebase in progress; onto ");

Could you please add a

   /* TRANSLATORS: Followed by branch name. */

or something similar here (and possibly to the other "on_what"s in the 
function)?

Ideally, the "%s" for the branch name should be inside that 
on_what string, but I guess that can be difficult since it is output 
in a different colour?

-- 
\\// Peter - http://www.softwolves.pp.se/
