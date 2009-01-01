From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-cherry: make <upstream> parameter optional
Date: Thu, 01 Jan 2009 13:00:24 -0800
Message-ID: <7vr63mivx3.fsf@gitster.siamese.dyndns.org>
References: <200812291845.20500.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Thu Jan 01 22:02:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIUg0-0005dT-Rj
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 22:01:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbZAAVAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 16:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751738AbZAAVAc
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 16:00:32 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51531 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647AbZAAVAc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 16:00:32 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B1DC68C146;
	Thu,  1 Jan 2009 16:00:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0A8C68C145; Thu,
  1 Jan 2009 16:00:25 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 382444B0-D847-11DD-815A-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104321>

Markus Heidelberg <markus.heidelberg@web.de> writes:

> diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
> index 74d14c4..556ea23 100644
> --- a/Documentation/git-cherry.txt
> +++ b/Documentation/git-cherry.txt
> @@ -7,7 +7,7 @@ git-cherry - Find commits not merged upstream
>  
>  SYNOPSIS
>  --------
> -'git cherry' [-v] <upstream> [<head>] [<limit>]
> +'git cherry' [-v] [<upstream>] [<head>] [<limit>]

Shouldn't this be [<upstream> [<head> [<limit>]]]?
