From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 2/2] Documentation: git-clean: make description more readable
Date: Sat, 25 Apr 2009 11:36:35 -0700
Message-ID: <49F35833.5070005@gmail.com>
References: <1240672421-10309-1-git-send-email-wjl@icecavern.net> <1240672421-10309-3-git-send-email-wjl@icecavern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Wesley J. Landaker" <wjl@icecavern.net>
X-From: git-owner@vger.kernel.org Sat Apr 25 20:46:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxmtA-0003DJ-Fl
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 20:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753242AbZDYSgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2009 14:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751865AbZDYSgl
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 14:36:41 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:48298 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbZDYSgl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2009 14:36:41 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1390410rvb.1
        for <git@vger.kernel.org>; Sat, 25 Apr 2009 11:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=R3vw4xayQBilT+/ydFALW5VznbfXR5Pn53ULjHE83mk=;
        b=YWgeunncVh685lGgy93zcgw7ADYvFOGApjzXUAvceBHC0qd0b/adQs3fynd1BeBrpJ
         DmlUQfEcII5myZuXkTKTuVqod704mF8hEvqlhGpe0w89hpRdOZs8RYyLhXr7iD5qS8OC
         T8GyP0fK+ZV2j/x8ZGKBPVpFTaZab9NJfJbks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=cJ/eRUFRvEdqA/o54dNJIgGugr2zsU/b0AGpbG48wq85kDFrx3KRCv4tPjzlshuLtl
         JMv+Oq9jB4p/dKPAW7Pgz2nQB6vbAe2aqD4LhJKSuvzH+qDCm9FeeM9FjibEDOvhD27N
         mbT+v7wjGmJIlTLaEdxqwDQDbGKQciF3PEfKw=
Received: by 10.141.50.11 with SMTP id c11mr1130088rvk.45.1240684598822;
        Sat, 25 Apr 2009 11:36:38 -0700 (PDT)
Received: from ?192.168.1.3? ([76.89.212.195])
        by mx.google.com with ESMTPS id f42sm3383336rvb.11.2009.04.25.11.36.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Apr 2009 11:36:37 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090321)
In-Reply-To: <1240672421-10309-3-git-send-email-wjl@icecavern.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117567>

Wesley J. Landaker wrote:
>  DESCRIPTION
>  -----------
> -Removes files unknown to git.  This allows cleaning the working tree
> -of files that are not under version control.  If the '-x' option is
> -specified, ignored files are also removed, allowing the removal of all
> -build products.
> +
> +This allows cleaning the working tree by removing files that are not
> +under version control.
> +

Why is the "Removes files unknown to git" part lost? Maybe it should be
replaced with a copy of the Name section, similar to log and diff. For
example:

DESCRIPTION
-----------
Removes untracked files from the working tree. This allows cleaning the
working tree by removing files that are not under version control.

But then the second sentence becomes redundant.

> +Normally, only files unknown to git are removed, but if the '-x'
> +option is specified, ignored files are also removed. This can, for
> +example, be useful to remove all build products.

This seems overly wordy. Maybe:

Specifying the '-x' option will also remove ignored files. This is
useful to remove generated files.

Better?

On a side note, why is -x getting special treatment here but not -X or
-d? You might want to just describe the general usefulness of the
command and let the reader move onto the options to learn more.
