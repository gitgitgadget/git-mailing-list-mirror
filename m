From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/v3] bundle.c: added --stdin option to git-bundle
Date: Sat, 5 Jul 2008 18:54:45 +0200
Message-ID: <200807051854.46798.jnareb@gmail.com>
References: <c376da900807050930i6d1da898s624be58adc6f1751@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Mark Levedahl" <mdl123@verizon.net>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Adam Brewster" <adambrewster@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 05 18:56:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFB3A-0000cD-2i
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 18:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbYGEQyx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Jul 2008 12:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751877AbYGEQyx
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 12:54:53 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:53645 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532AbYGEQyw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 12:54:52 -0400
Received: by fg-out-1718.google.com with SMTP id 19so600848fgg.17
        for <git@vger.kernel.org>; Sat, 05 Jul 2008 09:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=EAfKi7QVBMD+/nrO67VQQ3f9Tdk+dVP1PIOcmoNuou4=;
        b=AP5mp3cN6ElzA2yYqs+fSkDk2KN6ys3WOTxViNSI65xxRik0gY71hkmr+UJijW9HZ7
         ST4hWFuP0uKk8akuZ9GnS0mXR3T1N6hJLJa6j/iPKoWPdnRWFlH5SV24mu2uqtkpwSOE
         8g0kPoHBu677J/TDoZXZMWteyYkW5shULY0YA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=aROXWUqPFYbKhPa82d7rc0/QyPfw2KExk23udc8cguLgvAmWc9Fxm7jTi93Mem6beg
         iLWV1U3woEfJCLtCN8J9crXnZb1FbR4xKsG2kJVANSsOsE1j6aoEQh2Z3HeQGLNIHVRR
         sD9a13fdjyVtNFd4NWatDLdVHhm2/KQc+mXRY=
Received: by 10.86.23.17 with SMTP id 17mr2203586fgw.32.1215276890697;
        Sat, 05 Jul 2008 09:54:50 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.224.192])
        by mx.google.com with ESMTPS id 4sm2336381fgg.9.2008.07.05.09.54.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Jul 2008 09:54:48 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <c376da900807050930i6d1da898s624be58adc6f1751@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87450>

On Sat, 5 Jul 2008, Adam Brewster wrote:

> It seems that the consensus is that the other half of my original
> patch is no good. =A0You have some pretty good ideas about how to
> correctly address the problem I was trying to solve, and I look
> forward to seeing them actually implemented.

It is not that the other half is "no good", it is rather that there
is no consensus how and in what way it should be implemented; be
it separate git-bases command, git-bundle--bases helper script, or
incorporated in git-bundle code; should it be written in Perl or
as shell script (only in case of git-bases or git-bundle--bases),
or should it be written in C.

Adding some documentation, with example usage (example "workflows")
would help adding git-bases to git core... perhaps at start send
it as script in contrib/ ?

> For now, I offer separately the modification I made to bundle.c to
> allow git-bundle to handle the --stdin option. =A0

That's the way it is preferred here on git mailing list, to not bundle=20
non-controversial change with the one that needs (or seem to need) some=
=20
further discussion - do not hold features hostage ;-)

> There is no accompanying change to the documentation because it
> already implies that this option is available.

Adding an example of using `--stdin' to "[git-rev-list-args...]::"
in Documentation/git-bundle.txt would be good.

--=20
Jakub Narebski
Poland
