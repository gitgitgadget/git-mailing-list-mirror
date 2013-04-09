From: Jed Brown <jed@59A2.org>
Subject: Re: Teaching rerere about existing merges
Date: Tue, 09 Apr 2013 10:08:24 -0500
Message-ID: <87k3ob7ndj.fsf@mcs.anl.gov>
References: <504282025.1400346.1365517106800.JavaMail.root@openwide.fr>
Mime-Version: 1.0
Content-Type: text/plain
To: Jeremy Rosen <jeremy.rosen@openwide.fr>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 09 17:08:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPa9v-0005jb-Jk
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 17:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934641Ab3DIPI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 11:08:27 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:60498 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761894Ab3DIPI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 11:08:26 -0400
Received: by mail-ie0-f169.google.com with SMTP id qd14so8715113ieb.28
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 08:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:subject:in-reply-to:references:user-agent
         :date:message-id:mime-version:content-type;
        bh=PckSXz+I9S/HVXi8Dz5tY/6yuaIjD9DN7fwX5d5yUps=;
        b=sRYia9623YXjhpiHK7mqUZMUE9vjaWYOwDkqost6GE7bP70RE7i2vbXvMERpPrHU5K
         6F/eoGcaNohxmlDIohCijqAuNKwiObA3VoR1mq/ZWwZpom4MU7q3ssa05wTcbHIpkJxy
         d+YTc5Rw5+G3vYyZ6ykhwR/pY4sRnxxDm1k70O8wR/vZaXPNT49CRr4V6M+U5JjHtLZl
         psGKL5AW8WLkOmsf8aFd9O9KEtO2FVqYwqgb++OzkXVGh4pnCMJmEsLO+5HhnPfwT6wQ
         mo7j4QdGZFo8z18nx17Ys1w6AuV2nshS0wBqHmQtA5dep44xoX5Ukl/IkbIa6o8U9CcN
         SPmQ==
X-Received: by 10.50.73.65 with SMTP id j1mr10891002igv.49.1365520105703;
        Tue, 09 Apr 2013 08:08:25 -0700 (PDT)
Received: from localhost (vis-v410v070.mcs.anl-external.org. [130.202.17.70])
        by mx.google.com with ESMTPS id n7sm22948142igb.9.2013.04.09.08.08.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Apr 2013 08:08:25 -0700 (PDT)
In-Reply-To: <504282025.1400346.1365517106800.JavaMail.root@openwide.fr>
User-Agent: Notmuch/0.15.2+78~g5404ac5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220573>

Jeremy Rosen <jeremy.rosen@openwide.fr> writes:

> is there a way to "teach" rerere about existing merge commits, or do I 
> have to re-solve all the existing merge manually once ?

See src/contrib/rerere-train.sh and Junio's blog.

http://git-blame.blogspot.com/2012/04/rebuilding-git-integration-environment.html
