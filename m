From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Support ent:relative_path
Date: Fri, 4 May 2007 10:20:28 +0200
Message-ID: <81b0412b0705040120r4ac596b9k72c354dff1cb1d0f@mail.gmail.com>
References: <463ADE51.2030108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Dana How" <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 04 10:20:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hjt1p-0000r6-Ce
	for gcvg-git@gmane.org; Fri, 04 May 2007 10:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767729AbXEDIUe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 04:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767734AbXEDIUe
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 04:20:34 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:42484 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767729AbXEDIU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 04:20:29 -0400
Received: by an-out-0708.google.com with SMTP id b33so760198ana
        for <git@vger.kernel.org>; Fri, 04 May 2007 01:20:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Az6tnVD8GML6cSmB4LrwRdR1qHUYQ5FeROl71Ne5NwLLipw4GD7Ck9P4qVzCTYJN6LaN3AA6guQS6cVu5MSD5GDjWC+t5EHbYOzmxK2zrscKuJ28OAw9Uen8/zxPzpbgnV79c/Utxqijxjlp3Io+rAycksTTRKjC3UkkQokDzfY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YoZvvHrl5dnr94evt/YzSbhrsExCcgPXhTi9Ajwasaa7j+BfkNFbZHcROj6KVfxMq6B0vDkVgky/+ryLGvjJpBd0eQsodpfpyC0Iy+d0G7nWs/b3IlOSBoZT/KV5c3bf5m06trkGGgr3+p+KfM77OkP939FvaU5dJGUi0gXh3II=
Received: by 10.100.111.16 with SMTP id j16mr2427907anc.1178266828702;
        Fri, 04 May 2007 01:20:28 -0700 (PDT)
Received: by 10.100.86.19 with HTTP; Fri, 4 May 2007 01:20:28 -0700 (PDT)
In-Reply-To: <463ADE51.2030108@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46143>

On 5/4/07, Dana How <danahow@gmail.com> wrote:
> +       if (!strcmp(var, "core.relativepaths")) {
> +               assume_relative_paths = git_config_bool(var, value);
> +               return 0;
> +       }

Maybe we should use relative path always, unconditionally.
