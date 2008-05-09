From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] git-format-patch: add --no-binary to omit binary changes in the patch.
Date: Fri, 9 May 2008 19:24:39 +0200
Message-ID: <200805091924.39992.robin.rosenberg.lists@dewire.com>
References: <1210096079-32399-1-git-send-email-cmarcelo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Caio Marcelo de Oliveira Filho <cmarcelo@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 19:27:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuWMI-00081v-Pn
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 19:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763868AbYEIRZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 13:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763174AbYEIRZZ
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 13:25:25 -0400
Received: from [83.140.172.130] ([83.140.172.130]:8926 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1762163AbYEIRZY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2008 13:25:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 6BFAE1434CBA;
	Fri,  9 May 2008 19:25:22 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TgcgCqbh+qyg; Fri,  9 May 2008 19:25:22 +0200 (CEST)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id E55DC1434CB3;
	Fri,  9 May 2008 19:25:21 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1210096079-32399-1-git-send-email-cmarcelo@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81625>

tisdagen den 6 maj 2008 19.47.59 skrev Caio Marcelo de Oliveira Filho:
> Add a new option --no-binary to git-format-patch so that no binary
> changes are included in the generated patches, only notices that those
> files changed.  This generate patches that cannot be applied, but still
> is useful for generating mails for code review purposes.
>
> See also: commit e47f306d4bf964def1a0b29e8f7cea419471dffd, where --binary
> option was turned on by default.
>
> Signed-off-by: Caio Marcelo de Oliveira Filho <cmarcelo@gmail.com>
> ---
>
> This is a first try on the patch.  The extra option affects only
> git-format-patch, since the special case (activating --binary if
> --text wasn't set) is only there.

Fine with me.

-- robin
