From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [DOC PATCH] State the effect of filter-branch on graft explicitly
Date: Fri, 10 Apr 2009 17:57:24 +0200
Message-ID: <fabb9a1e0904100857q1a77cad8u4a404b893b8e3309@mail.gmail.com>
References: <1239344809-4451-1-git-send-email-j16sdiz+freenet@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: "Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 10 18:00:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsJ95-0006YA-4N
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 17:59:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbZDJP5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 11:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbZDJP5l
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 11:57:41 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:47285 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918AbZDJP5l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2009 11:57:41 -0400
Received: by fxm2 with SMTP id 2so1109773fxm.37
        for <git@vger.kernel.org>; Fri, 10 Apr 2009 08:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=IgxQk5bX29r7yC4CNKqaMocB9/yAaT9l1UaPWsbmmHg=;
        b=gIg2skBbdDoPjHW30CnCXb0yU3VkcYBsoD4x6J9O/KEoVA7C/EfqvIS9OG0Qx5ePs6
         oYQN10QVYw6wJz399oyord9zt5rjx5MM2hv88lv8VvfVioSQQyM+lajqhQVfvLFnh/VH
         UUp+i2sTAA+gsx4urnT/krZKRljG/8EndmJSw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Mfw8y9hPKsl71p23hMbY+CMo8poNq7lUtuYQlOL8NIdacANCWQjL4R0RILhLTIIeNj
         IhvyvXThJyK6FCbMNqQEOsuzYLEvomEfYenuEQu2lS/r1Q4wnOrHF1Z7Zu39N3q3Y00t
         GDPM/dqGGB29+BCmpjdD85f226Lo13ji2puBM=
Received: by 10.103.174.16 with SMTP id b16mr1916593mup.28.1239379059276; Fri, 
	10 Apr 2009 08:57:39 -0700 (PDT)
In-Reply-To: <1239344809-4451-1-git-send-email-j16sdiz+freenet@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116262>

Heya,

On Fri, Apr 10, 2009 at 08:26, Daniel Cheng (aka SDiZ)
<j16sdiz+freenet@gmail.com> > +*NOTE*: This command honor
`.git/info/grafts`. If you have any grafts
> +defined, running this command will make them permanent.

s/honor/honors/

-- 
Cheers,

Sverre Rabbelier
