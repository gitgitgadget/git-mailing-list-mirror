From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 6/8] gitweb: Highlight interesting parts of diff
Date: Fri, 10 Feb 2012 05:23:10 -0800 (PST)
Message-ID: <m339aivn4z.fsf@localhost.localdomain>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
	<1328865494-24415-7-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-2?q?Micha=B3_Kiedrowicz?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 14:23:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvqRb-0007Wc-0R
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 14:23:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758741Ab2BJNXM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 08:23:12 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:42293 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754427Ab2BJNXL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2012 08:23:11 -0500
Received: by eekc14 with SMTP id c14so954466eek.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 05:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=y23jIHLjqCm9t4+o8G5RZDIIAQ2/ogYrPDyciZWn3yU=;
        b=GheXbILu1loMjm1LDisc3g90vQ8MD1gitzyfuPysm9c5PrNcFCR8Swy8T1jDaU68sU
         XGX4oySwc2hLvfHk91yZkAmqnJRBkxysJFMYF0Y2fSH2lrwKS8S7pzphOCYmFWCUmLXJ
         8VpLZyNWq8mwA/R7iUnLWTcVPlPEA3TIFm3Q8=
Received: by 10.14.94.134 with SMTP id n6mr2013794eef.63.1328880190453;
        Fri, 10 Feb 2012 05:23:10 -0800 (PST)
Received: from localhost.localdomain (abwh187.neoplus.adsl.tpnet.pl. [83.8.231.187])
        by mx.google.com with ESMTPS id o49sm22165590eei.0.2012.02.10.05.23.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Feb 2012 05:23:10 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q1ADMm7J026645;
	Fri, 10 Feb 2012 14:22:58 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q1ADMb4K026641;
	Fri, 10 Feb 2012 14:22:37 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1328865494-24415-7-git-send-email-michal.kiedrowicz@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190407>

Micha=B3 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:

> The code that comares lines is based on
> contrib/diff-highlight/diff-highlight, except that it works with
> multiline changes too.  It also won't highlight lines that are
> completely different because that would only make the output unreadab=
le.
> Combined diffs are not supported but a following commit will change i=
t.

I was thinking that if gitweb were to support "diff refinement
highlighting", it would either use one of *Diff* packages from CPAN,
or "git diff --word-diff" output.
=20
--=20
Jakub Nar=EAbski
