From: Pete Harlan <pgit@pcharlan.com>
Subject: Re: [PATCH] add-interactive: shortcut to add hunk and quit
Date: Tue, 17 May 2011 23:40:03 -0700
Message-ID: <4DD369C3.4070806@pcharlan.com>
References: <20110517071232.GA19396@mrq1.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Hermann Gausterer <git-mailinglist@mrq1.org>
X-From: git-owner@vger.kernel.org Wed May 18 08:40:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMaQj-0002BC-F8
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 08:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754489Ab1ERGkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 02:40:18 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:45165 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754222Ab1ERGkR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 02:40:17 -0400
Received: from homiemail-a45.g.dreamhost.com (caibbdcaaaaf.dreamhost.com [208.113.200.5])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 951FD17981A
	for <git@vger.kernel.org>; Tue, 17 May 2011 23:40:16 -0700 (PDT)
Received: from homiemail-a45.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a45.g.dreamhost.com (Postfix) with ESMTP id 51298480A0;
	Tue, 17 May 2011 23:40:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pcharlan.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=pcharlan.com;
	 b=DExhTxP5QIQJd1MMQBamzeoXYjWHhh68lfQCVR0Qtg2fggIXzYX/AS08nWV6i
	ssz3Pjd8u+RX7I6udafLhWKo7LSUgmpvoONxVyefhamdZ4PE0gFbOG1FMOlMw14v
	Tpw884NJ/NKCIpyjZgJHUr2C2mDnKRa7dsy2xCPm6Maa7c=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pcharlan.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=pcharlan.com; bh=qHlF
	lWNRzZOg/suGXetZP6yS/l4=; b=XZzKKtQ7F1MUTHju68+WR08z4WsW3F+sfkXc
	J318V7b9pkLw6zHTf9AmoVM/CZs74R/pKqBSMOvj88ARlHycvRQLMyvzyRXan/G7
	FAcgiH6ceFlj+eIBO2cRKh4xPBeQ+bDxFtFBWFMGl/0NUP4rf0aY1mXg873anjq9
	nGxClBI=
Received: from [192.168.0.101] (185.132-78-65.ftth.swbr.surewest.net [65.78.132.185])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: pete@tento.net)
	by homiemail-a45.g.dreamhost.com (Postfix) with ESMTPSA id 3562748075;
	Tue, 17 May 2011 23:40:04 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110424 Thunderbird/3.1.10
In-Reply-To: <20110517071232.GA19396@mrq1.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173849>

On 05/17/2011 12:12 AM, Hermann Gausterer wrote:
> this combines the two "add -i" commands "y"+"q" to one.

...

>         y - stage this hunk
>         n - do not stage this hunk
>         q - quit; do not stage this hunk nor any of the remaining ones
> +       Q - stage this hunk but none of the remaining ones
>         a - stage this hunk and all later hunks in the file
>         d - do not stage this hunk nor any of the later hunks in the file
>         g - select a hunk to go to

If "q" means "quit", I would expect "Q" to mean something like "quit immediately" (perhaps even undoing earlier adds), not "do something that 'q' wouldn't do, and then quit".

Perhaps "o" (for "stage exactly [o]ne commit"), or "t" for "stage [t]his commit" would be reasonable alternatives?

--Pete
