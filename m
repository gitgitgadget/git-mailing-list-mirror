From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 8/8] git-config: use git_config_with_options
Date: Wed, 24 Oct 2012 21:14:50 +0200
Message-ID: <CACBZZX7NtpzDJsRa7ie6GhWE3b0VUMvTgeNkuxhF3UuQJtTNKQ@mail.gmail.com>
References: <20121023223502.GA23194@sigill.intra.peff.net> <20121023224119.GH17392@sigill.intra.peff.net>
 <50878BB1.8050902@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 24 21:15:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TR6QL-0006jC-CE
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 21:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161158Ab2JXTPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 15:15:15 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35579 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161129Ab2JXTPO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2012 15:15:14 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so803515obb.19
        for <git@vger.kernel.org>; Wed, 24 Oct 2012 12:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5WsLNVTLiCmIkg3oN+hR+YeWrDmcF8gcO1SnMn384to=;
        b=Se/YQdyuINzrXBODfnAui9wyoGqXMzU6/0zZ1FQwPWo4nehmn3zR14Ec0pgd8zA2ST
         m7eNCrR7AeF9SMfNWGKJw7afkO2AXOYBhD3vUBPhf/wIKZ2kErK0+hBv3tkyEIJCh11F
         SeL9S52onyqa3Ovouk1WPYLU8N0sL2goyt2pVmDeBzJGnllLw/vC/9ph/xCfFt375TWK
         qFcvI9SzpQBmKvKBvB6T1KY3q0fVgDmuF+h3gz+68pGuntSwjvJCPk+cutoqtebFtTVz
         7EVznVb03oKtzl8Qpp3sVAshTeeOrguzS49HP9SOTcS9QrYy9KTr/2xI9HE6yMVCHgl3
         g1Kw==
Received: by 10.60.8.36 with SMTP id o4mr14500680oea.70.1351106111251; Wed, 24
 Oct 2012 12:15:11 -0700 (PDT)
Received: by 10.60.94.225 with HTTP; Wed, 24 Oct 2012 12:14:50 -0700 (PDT)
In-Reply-To: <50878BB1.8050902@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208320>

Yeah same here. Thanks for tackling this bug. Looking forward to using
the include mechanism for overriding user.email in future versions.
