From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] doc: add some crossrefs between manual pages
Date: Tue, 9 Dec 2014 09:14:38 -0800
Message-ID: <20141209171438.GA22606@google.com>
References: <1415737027-44589-1-git-send-email-max@quendi.de>
 <xmqqppct5p1q.fsf@gitster.dls.corp.google.com>
 <96693472-344E-4ED3-B027-49A8303AF8C0@quendi.de>
 <xmqqbnoc3zli.fsf@gitster.dls.corp.google.com>
 <xmqq7fz03z7i.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Max Horn <max@quendi.de>, git@vger.kernel.org, spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 18:14:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyON7-0003hO-Qs
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 18:14:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbaLIROp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 12:14:45 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:34243 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091AbaLIROp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 12:14:45 -0500
Received: by mail-ig0-f174.google.com with SMTP id hn15so4900461igb.13
        for <git@vger.kernel.org>; Tue, 09 Dec 2014 09:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=aRXIhcBrLqgJU8e2/MBjpj753o5O9Zxe1LXamxR0bQA=;
        b=RNqe738iDUuEd+/XxAlSu3TjnodHMSnc4RcM+A2b+Ly6V+CITB8+zG/z8sITS2l1r3
         08yScDArIjjoMLohV4K9v5uXdAm70lbtlQgCna9VW8Yt5gq0YZDVeGy9B3yd6iPKQDDA
         rWmpDhwJO3zvsR/uyNfrFo3GsTNI1SLtdIuf3LuoMh+oXrPJ6zVERXkNodbbjkpjt7fy
         iB02dl5La5NttdfoMYfOmwUNMakDK9oBOg/SdMPvlZOHkhn+kE/rESt8ph8xCxXqJY8b
         yv/IB9QIp9Gy99/tRNPzg2UsH+180EVSdxL4ML+Y5hEpkQuXXRZw3YbucaxUOymSPR0r
         qUvw==
X-Received: by 10.42.212.10 with SMTP id gq10mr2799882icb.79.1418145284220;
        Tue, 09 Dec 2014 09:14:44 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:41c9:2fc6:1317:4ac])
        by mx.google.com with ESMTPSA id w9sm5739478igk.20.2014.12.09.09.14.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Dec 2014 09:14:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqq7fz03z7i.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261131>

Junio C Hamano wrote:

> So I am OK to special case fast-import and single it out as a
> notable implementation technology, which is what your patch does.

More importantly, helpers implementing the "import" or "export"
capability are indicating that they grok the fast-import format.  What
they use behind the scenes to produce or parse it is not so important
--- the relevant thing is that a fast-import stream (with format
documented in git-fast-import(1)) is part of the remote helper
protocol in this case.

Thanks,
Jonathan
