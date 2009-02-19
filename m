From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 4/4] remote: new show output style
Date: Thu, 19 Feb 2009 17:16:30 +0100
Message-ID: <bd6139dc0902190816m3c70923eg132e89bff28a216f@mail.gmail.com>
References: <1235020471-59982-1-git-send-email-jaysoffian@gmail.com>
	 <1235020471-59982-2-git-send-email-jaysoffian@gmail.com>
	 <1235020471-59982-3-git-send-email-jaysoffian@gmail.com>
	 <1235020471-59982-4-git-send-email-jaysoffian@gmail.com>
	 <1235020471-59982-5-git-send-email-jaysoffian@gmail.com>
	 <499D82BC.7020500@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 17:18:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaBb6-00082v-Qz
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 17:18:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753968AbZBSQQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 11:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753877AbZBSQQc
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 11:16:32 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:14966 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753777AbZBSQQb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 11:16:31 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1236983fgg.17
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 08:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=nj6w/1IXPnqIYvSh1OvXSAf6OdJNceqBh1EBjRgCAGg=;
        b=KQ/2SqL8jREZa7cA9d6YIOrGAq/AGlXxooXRUBWvKCoSPQ4fpj0EDJV3q4pTbQ5j2h
         Md66JjeFkyksYDxcrN0GnJL/xOqF/chc4n+Av+OwFiFKzyRRI4zV1hOjk5dlN3w2LYUM
         QnIvhD0wlMqIy+0PwuvmS1F/pJeA9n4YMRTQo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=ZE32Hx6nmiSUnzWf1XazeuG8Kun+TSB7VMDx0wIyS22irf9HGUFvVazKhcYinUMWbN
         JYhi266N2tGmJkZelFuYntfrdvcbncgntxpIfCu7u7Pc9LI+Vifd2puawuXi6aQVuyks
         QHp9yyzLi3gKg298wBMPpiqJ4uhp9iZE1n4gU=
Received: by 10.86.99.9 with SMTP id w9mr424309fgb.31.1235060190148; Thu, 19 
	Feb 2009 08:16:30 -0800 (PST)
In-Reply-To: <499D82BC.7020500@xiplink.com>
X-Google-Sender-Auth: c46894e5e1bcbb51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110714>

On Thu, Feb 19, 2009 at 17:03, Marc Branchaud <marcnarc@xiplink.com> wrote:
> Though I'm not really happy using "updates" when + is specified in the push
> refspec.  What, precisely, is a "non-fast forward update" anyway?  Is it
> essentially a rebase?  If so, maybe "rebases onto remote " would be better
> (again with a trailing space to get nice alignment).

A non-fast forward update in terms of pushing means you overwrite
whatever the remote currently has set as that branch's head. This can
be desirable in a private repository or branch, but is usually not
desired on shared branches.

-- 
Cheers,

Sverre Rabbelier
