From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: git-svn commit id.
Date: Wed, 28 May 2008 16:50:54 +0200
Message-ID: <8aa486160805280750q5a214961re21ed1dc731cf181@mail.gmail.com>
References: <1211983320.15736.11.camel@omicron.ep.petrobras.com.br>
	 <483D6F10.5000403@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Victor Bogado da Silva Lins" <victor@bogado.net>,
	git@vger.kernel.org
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed May 28 16:54:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1N0O-0000oV-Fu
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 16:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbYE1OvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 10:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbYE1OvA
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 10:51:00 -0400
Received: from ti-out-0910.google.com ([209.85.142.186]:43574 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbYE1Ou7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 10:50:59 -0400
Received: by ti-out-0910.google.com with SMTP id b6so2038837tic.23
        for <git@vger.kernel.org>; Wed, 28 May 2008 07:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=E4R/X14A07AhGBd3QuMQFn4TdlzIo1Iszu6rgG/RuB4=;
        b=PfiMQ+EIZtKqCaKe4YEQRHabtPdasLSJ2xyDiyhVtL5V4QMnA6WIM6bgvwYZpAje8Ox3q7t2YHEHNHYo59tZUpgk+ps7bK/QOT/Ie5FjUnod0aAJJJaxVu+NlQNaLXHXAf9BAmnkGovQuvUwvLv2LjudCZAoSr7AilypV4Kv2EA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X3YzQXbtmkjlTjTOBgrXFMRMWPYpid8Awbb963tqVL3lWW9Nu5K8mzfDXAW4/5WFHwKgB19pLSEH1wqdgAhdYKkGDPkG0+zUnNjy9bA+8+KiepqFOApWY5XamPvHkmGx8J+tEsWDmogQPqgOpzTZkNIZ72A914Mruqe9O4MVJyI=
Received: by 10.150.229.16 with SMTP id b16mr2823966ybh.239.1211986254663;
        Wed, 28 May 2008 07:50:54 -0700 (PDT)
Received: by 10.150.152.19 with HTTP; Wed, 28 May 2008 07:50:54 -0700 (PDT)
In-Reply-To: <483D6F10.5000403@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83096>

On Wed, May 28, 2008 at 4:41 PM, Andreas Ericsson <ae@op5.se> wrote:
> Victor Bogado da Silva Lins wrote:
>>
>> I have two git-svn repositories here and I noticed that the same commit
>> have different ids in them. How this came to be, both commits share the
>> exact same git-svn-id and are the same (as far as I know).
>
> If the have exactly the same history leading up to them, source trees
> and commit object (including timestamps), the only way they can be any
> different is if you've run into a bug in the SHA1 libraries.
>
> If either of the above three are different though, you *will* end up
> with different commits.
>
> Try doing "git cat-file commit <sha1-of-one-commit>" and then
> "git cat-file commit <sha1-of-other-commit>". If you take a diff
> between the two, you'll see how they differ (my guess would be the
> timestamps)
>

Git-svn uses the same timestamps as in svn, my guess is that one has
more history than the other.

Santi
