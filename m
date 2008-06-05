From: "Cedric Vivier" <cedricv@neonux.com>
Subject: Re: [PATCH] use natural ordering to display list of branches.
Date: Thu, 5 Jun 2008 22:08:13 +0200
Message-ID: <d45085aa0806051308y16bcca95xad126022fd3ee053@mail.gmail.com>
References: <d45085aa0806051041y42ce467fq2e07371d225ccca3@mail.gmail.com>
	 <alpine.DEB.1.00.0806051946100.21190@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 22:09:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4Llr-0007bF-Cx
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 22:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393AbYFEUIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 16:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752661AbYFEUIP
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 16:08:15 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:41370 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796AbYFEUIO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 16:08:14 -0400
Received: by py-out-1112.google.com with SMTP id p76so623430pyb.10
        for <git@vger.kernel.org>; Thu, 05 Jun 2008 13:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=RgRE4YmINtzlrAjpZFhTncU4qY7CpgvhgR4JLE26A5E=;
        b=epkCjuo1gtF0MzauKQGGALDAKZWxMfYLhHlYwjpdIpz5SONiifR0l0tYwqY+XqYIUE
         iBpyXfZdlL4Orlkk+XJDcCfo6pkmsDx1jXgTYoKShB7P0Y6VLAlkymszZpifaN9XIAID
         10M8R5amYr4MeGKJQO8vKJCotyORmfkWxyv4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=YhGoWFv9naVC6MjZyhosZ+tDcm9dppe9Rg8Rzw1d98gmPgowm121P3mpTeqLZWC2hk
         Q/EUi9Jx6K5HRwbbDLVkqBJiaDi137OwlyA7UZ6dKM9Tkn59GiRJyosmVz56W3FA2qvb
         8R9TGWVfUyIoDHnYh91L41eE2QewznHK9J0WQ=
Received: by 10.114.159.6 with SMTP id h6mr2179973wae.65.1212696493356;
        Thu, 05 Jun 2008 13:08:13 -0700 (PDT)
Received: by 10.115.33.3 with HTTP; Thu, 5 Jun 2008 13:08:13 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0806051946100.21190@racer>
Content-Disposition: inline
X-Google-Sender-Auth: 82c7d633f8508929
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83965>

On Thu, Jun 5, 2008 at 8:47 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> What about people preferring the status quo?  I think a command line
> option would be in order.

Is there really people preferring the status quo ? ;)
Of course we probably need some debate about making it default or not
but you're completely right there should be an option about that - and
maybe a config variable as well?
How about --sort=ascending|descending|natural (with branch.sort as the
corresponding config var) ?


> Also, you _might_ want to provide a test case, so that it does not get
> broken by accident.

Okay.


> Other than that: nice.

Thanks,


Junio, about the borrowed code, indeed I was not sure where to put it,
initialliy I thought using directory strnatcmp/ like it's done for
mozilla-sha1/ and xdiff/, but well... probably a more general
directory that will be used for other 'borrowed' stuff in the future
makes sense.


Regards,
