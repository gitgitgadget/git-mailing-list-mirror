From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] tag: make list exclude !<pattern>
Date: Sat, 11 Feb 2012 02:13:13 -0800 (PST)
Message-ID: <m3sjihu18t.fsf@localhost.localdomain>
References: <20120210185516.GA4903@tgrennan-laptop>
	<1328926618-17167-1-git-send-email-tmgrennan@gmail.com>
	<7vaa4qnk4u.fsf@alter.siamese.dyndns.org>
	<7vy5s9n70x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tom Grennan <tmgrennan@gmail.com>, pclouds@gmail.com,
	git@vger.kernel.org, krh@redhat.com, jasampler@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 11:13:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rw9xi-0004rd-AL
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 11:13:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754581Ab2BKKNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Feb 2012 05:13:16 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:33568 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754431Ab2BKKNP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 05:13:15 -0500
Received: by eekc14 with SMTP id c14so1208312eek.19
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 02:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=YrAmGT10t5YctsMTPdIKHAZStKvK4HPXfdplfWkORVA=;
        b=PlV5ABxrSM3og8GwRVE2qnoOoQ4Oeb02wBwej/ZQv6uJwj4nkVYq73vTPMfavoGnBk
         G8GnRFlFrt9ktqeWwGcNAZYw4wcqMZu1tf8dKFv7J6r2WLjtXcyB5oX90CTvXZyLl1ia
         i6aFpzLLO4k02GvA/Jakmw2GWDMOHLr42AEWw=
Received: by 10.14.99.2 with SMTP id w2mr3101313eef.69.1328955193826;
        Sat, 11 Feb 2012 02:13:13 -0800 (PST)
Received: from localhost.localdomain (abwi47.neoplus.adsl.tpnet.pl. [83.8.232.47])
        by mx.google.com with ESMTPS id v51sm33350542eef.2.2012.02.11.02.13.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 11 Feb 2012 02:13:13 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q1BAD82u009050;
	Sat, 11 Feb 2012 11:13:08 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q1BAD7Zl009045;
	Sat, 11 Feb 2012 11:13:07 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vy5s9n70x.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190505>

Junio C Hamano <gitster@pobox.com> writes:

> In a future versions, we may want to have "branch/tag --list" also ask for
> FNM_PATHNAME (this *is* a backward incompatible change, so it needs to be
> performed across major version boundary, with backward compatibility
> configurations, deprecation warnings and whole nine yards). Under the new
> match function, today's "branch --list 'maint*'" needs to be spelled as
> "branch --list 'maint*/*'" or something.

Or "branch --list 'maint**'

-- 
Jakub Narebski
