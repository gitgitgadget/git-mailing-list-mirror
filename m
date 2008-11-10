From: "Piotr Findeisen" <piotr.findeisen@gmail.com>
Subject: Re: Documentation/user-manual.txt, asciidoc and "--" escapes
Date: Mon, 10 Nov 2008 11:14:43 +0100
Message-ID: <ddb82bf60811100214j4246cf25yc1263c2ae8cd10fc@mail.gmail.com>
References: <ddb82bf60811061904t5defc492m80cd1b759674eb6@mail.gmail.com>
	 <ddb82bf60811061909m6f8a7b72o4b03ebcde8b9d188@mail.gmail.com>
	 <ddb82bf60811090044l43eb4bb1ga5a16718a4176c29@mail.gmail.com>
	 <2c6b72b30811091052k77200785j722c8aed2beb7684@mail.gmail.com>
	 <ddb82bf60811092338m3aad8041w20de23f18aa7d56e@mail.gmail.com>
	 <20081110100757.GA12868@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Jonas Fonseca" <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Mon Nov 10 11:16:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzToj-0006Zg-Bf
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 11:16:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754309AbYKJKOq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Nov 2008 05:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754318AbYKJKOp
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 05:14:45 -0500
Received: from wf-out-1314.google.com ([209.85.200.169]:52390 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754309AbYKJKOo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Nov 2008 05:14:44 -0500
Received: by wf-out-1314.google.com with SMTP id 27so2510195wfd.4
        for <git@vger.kernel.org>; Mon, 10 Nov 2008 02:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=WkoGu9nb8nSFxsjfCz2KP3F1ZJkSc2PCwCgNc4zyL9o=;
        b=CiiFuF0oDtf8OALn4GG0ducLxVUXF/KjWJMMFOOKDI/0f5igL/m2DT32IeuZbXwVHx
         9B7F2tzIC7Pd/RX8RIOM0yRtRws76SsDLr8OswS1EtYcJ5F66F6/OLTZAYbBoPzd5PsF
         Gh1dthwn9/e3Zsln2ja0JHT9zNrWhHqVbR34Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Fe6jMK2RCapdRe1oqf72INqzALp64gy4xkVitmZy+9DvrWRu5+g53uZ36Aulq/xoAb
         OKBfUKa79MIOyscx5qImDB6POKZbsz8dh5asXv6poo4HYrD33Pr0r8WN/Cr7/DZ97Ypj
         fd17aoyYsq6D4q98k3rhs5O1fjUQvUpe0KYr8=
Received: by 10.142.172.12 with SMTP id u12mr2305662wfe.60.1226312083961;
        Mon, 10 Nov 2008 02:14:43 -0800 (PST)
Received: by 10.142.157.6 with HTTP; Mon, 10 Nov 2008 02:14:43 -0800 (PST)
In-Reply-To: <20081110100757.GA12868@diku.dk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100510>

>
>> I noticed that all substitutions "--" -> "=97", where "=97" is a par=
t of
>> sentence punctuation, match \w--\w pattern (e.g. no spaces on both
>> sides) and probably this is how it should be written in English. But
>> basing on this doesn't seem to me to be fool proof.
>
> So another option is to disable all substitution of "--" and just use
> the "=97" character when it is explicitly needed. The documentation i=
s
> using UTF-8 after all. This would also fix the usage of "--" in the
> manpages, e.g.
>
>        You've now initialized the working directory--you may notice .=
=2E.
>
> in gittutorial(7). On my setup, with "--" replaced with "=97", I get =
the
> following nroff code:

On my machine, make gittutorial.7 produces manpage that displays "--"
in this place :)

>
>        You've now initialized the working directory\(emyou may notice

Anyway, this may be a good idea to use unambiguous "=97" (though people
writing docs may be used to using "--" as a punctuation). I can run
through the Documentation replacing "\w--\w" with m-dash, if you want.

Regards,
Piotr
