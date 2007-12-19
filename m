From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Re: Serious bug with pretty format strings & empty bodies?
Date: Wed, 19 Dec 2007 22:37:24 +0000
Message-ID: <57518fd10712191437s6f192feds50d006fdfc624444@mail.gmail.com>
References: <57518fd10712190632o490af924n61326fddf1819014@mail.gmail.com>
	 <20071219184457.GC3015@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 23:38:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J57YP-0001AD-NO
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 23:38:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753108AbXLSWh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 17:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752998AbXLSWh1
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 17:37:27 -0500
Received: from nz-out-0506.google.com ([64.233.162.225]:10882 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752902AbXLSWh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 17:37:26 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1668373nze.1
        for <git@vger.kernel.org>; Wed, 19 Dec 2007 14:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=p29dl4MVJrCcEsC4I0V+Kc7wzhj4yy54eePGVZDuuYs=;
        b=Gmj1bw3Pe6IZcuOGVP4syyEn1rvK2Xlk+CAGtvQHGCoVEo0y3RMclTjpY6fXWQAhug7rVb5Fj7PkYsqNcpcIZR1GkCT6YhYsFSxImwk9iuaW/1+4Ww5+pADZPZGtldfL4GixLNXyvth+RqJHJEZBNY0M662RYvi41ukcIBUINsw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=M3+84NAEzq4mkKC7/dqHpChE902lPeQhY8meq9xS1IR+dpWNu1xOUaEK6jOWZJHpQoZ2G8E6+yB4vG5Qo7qYF4VY9lwJYJZfQeEywuTO3ZS1xIiScN80zlBHugrAsh5QAt/fDlXKc0wcusbQRL+CyJtUuoQOjB+UD89/yGH3LKE=
Received: by 10.141.13.16 with SMTP id q16mr196321rvi.99.1198103844926;
        Wed, 19 Dec 2007 14:37:24 -0800 (PST)
Received: by 10.140.134.14 with HTTP; Wed, 19 Dec 2007 14:37:24 -0800 (PST)
In-Reply-To: <20071219184457.GC3015@steel.home>
Content-Disposition: inline
X-Google-Sender-Auth: 92cfc0e791b38e1b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68949>

On Dec 19, 2007 6:44 PM, Alex Riesen <raa.lkml@gmail.com> wrote:
> Could you try
>
>     git cat-file 18d2480ab689b483ef1ebbdb3f7420904049ba0b
>
> (or any other problematic commit) and post its output here?

You mean git cat-file commit ... ?
I get the normal output, but the problematic commits don't show a
newline character at the end of the cat-file output.


> Or is the repo publised somewhere?

Afraid not - it's private code.


I'll try bisecting e52a5de tomorrow, see if that gets me anywhere.
