From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v4 3/3] git-remote-ext
Date: Mon, 4 Oct 2010 20:09:03 +0200
Message-ID: <AANLkTinW1cZzYACcHBqCTCJ6pybW3UnqQuY-6CcMgJCx@mail.gmail.com>
References: <1286190258-12724-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1286190258-12724-4-git-send-email-ilari.liusvaara@elisanet.fi>
 <AANLkTikenkhm0RJR0ovVyY9WLHtwWo+qQsyAhFDk=BO2@mail.gmail.com> <20101004181133.GA14661@LK-Perkele-V2.elisa-laajakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Mon Oct 04 20:09:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2pTh-0007El-Er
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 20:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756701Ab0JDSJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 14:09:27 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:60305 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755022Ab0JDSJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 14:09:26 -0400
Received: by gwj17 with SMTP id 17so1720520gwj.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 11:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=YajTOrS47WiSmO7c74AVGR3lG9f7Nb0C1OP7mst9YoY=;
        b=uOHiQRlA6dTJnypcvyoEXu5yHy5x5WDGgzQtAKc84tkdaqRuKLJRf6nxRYZ5hAzAFo
         /6NnT18aoa7ZuLfuTJPvYWQ6MCPq75MrUhDH1lRYpdTGxqDw5eGh8pcxk5ZW7yo+XsEJ
         sdvbFyU0FCZsEmaaKVuwqkNpD7GVpu7dPvxhE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=bslRA82c01CNalKSz3dJSJl9S/b1MoeyLqWSiO/aYcW+MZpn2xAm/hi313wreIX3q1
         IdFk4SksVhLnXo0VWZcoYuhtwvJLgAtRWIj+s6VPg4u5JCO3EjKeSznsUDQRgYbOOWQG
         2NSN8s56sq8sWAgtvF7bV81lwzWc8Q3myljlg=
Received: by 10.90.80.19 with SMTP id d19mr4799383agb.54.1286215763773; Mon,
 04 Oct 2010 11:09:23 -0700 (PDT)
Received: by 10.151.15.8 with HTTP; Mon, 4 Oct 2010 11:09:03 -0700 (PDT)
In-Reply-To: <20101004181133.GA14661@LK-Perkele-V2.elisa-laajakaista.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158080>

Heya,

On Mon, Oct 4, 2010 at 20:11, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
> Connect its stdin and stdout to git://-type server somewhere. It might
> be that the actual address of server is variable depending on network
> conditions, the connection is tunneled somehow, etc..

SGTM, can you add that to the doc somewhere?

-- 
Cheers,

Sverre Rabbelier
