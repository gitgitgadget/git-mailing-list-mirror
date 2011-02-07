From: Endre Czirbesz <endre@czirbesz.hu>
Subject: Re: git to p4 conversion
Date: Mon, 7 Feb 2011 15:07:45 +0000
Message-ID: <AANLkTi=9vzPH2zrGTvmCLYjgvQJQs=Y+W40Jz8g5FyTS@mail.gmail.com>
References: <AANLkTi=0TSD6p7WtsVzx=pq8=GVu+jHUdxt1bnC++CT+@mail.gmail.com>
	<4D4AF29E.7070509@vmware.com>
	<AANLkTikW_sU8oCmU9wN5q1OPPJrQbS2YZAvS0C_nBQbD@mail.gmail.com>
	<loom.20110204T004658-497@post.gmane.org>
	<AANLkTikfGapDfZtD9H10797Ted_Av78WD8M7XrACOCpW@mail.gmail.com>
	<AANLkTimrwUxNOAnfxgvReGN+-h4_0jhZ731y22TB6u1K@mail.gmail.com>
	<AANLkTi=_spLE-KMnou-2LLQjwq4FUZxNr9pk7D9C=4PK@mail.gmail.com>
	<AANLkTi=dZdSqcNckyU7Lb2Zj-khfj=Xiyzbv7LSC+zT2@mail.gmail.com>
	<AANLkTimGaPQ=hRp+2pvw-hAOg+wp50nvc_sv9jNTay=n@mail.gmail.com>
	<AANLkTimJm81V0D8_j3OfZTcEkyn_jd6_QB2nv8T69JBY@mail.gmail.com>
	<AANLkTi=onuZtGWPTYvw_-rKsR6t-R2UquAUPLHAm-TVV@mail.gmail.com>
	<AANLkTimV1aRiEMa2z-H2bOvRa9H6YAyET1=hn+_O0-0u@mail.gmail.com>
	<AANLkTimP81rVPwvpaCSgBJiZ2Jm131+Q9E-Fkj0-jZfd@mail.gmail.com>
	<AANLkTikCVNoxyNezHVM=8gg6wZNzhV2eOytL952SSP3s@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Vitor Antunes <vitor.hda@gmail.com>, git@vger.kernel.org,
	Ian Wienand <ianw@vmware.com>
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 16:08:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmSh6-00052E-43
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 16:08:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753868Ab1BGPHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 10:07:47 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:54365 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753762Ab1BGPHq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 10:07:46 -0500
Received: by vxb37 with SMTP id 37so1604321vxb.19
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 07:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=ojCo37UMkebdq/QpR5kZN9DhYOOPTHOkXGdstakE2tY=;
        b=NtdubNF81lMf5/ifdANbxYq91c5xSJ6FWzirW57OGJEsdcpeKFBjcGb+fejnmZXx6F
         bBJqFVmLr5l6qm23HSuhNyh5C7/9kHJ/8/X6F8g6mpm7/z5N2hzSvlBbTMrHBj9efeps
         kZOJXmxwlwwajENntrna+Fh51ThrSwmVuJbiw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=MnT0L5PzKaFhV9cQEnX8ElhZwYfEQE+NqNAlbjKN1P4lw43YoI+G1w+GWq89bS4Pki
         93C025VNtwGBqsqPDHiiuKRP/3zcc/Zvxd7O1YK5D91q8M3IUtwIpE1fHynpYwHsiUEo
         O5ScYBerUE+EL0ErMhevasnvGQ2ctyO4btJlo=
Received: by 10.220.201.195 with SMTP id fb3mr1415520vcb.80.1297091265827;
 Mon, 07 Feb 2011 07:07:45 -0800 (PST)
Received: by 10.220.161.21 with HTTP; Mon, 7 Feb 2011 07:07:45 -0800 (PST)
In-Reply-To: <AANLkTikCVNoxyNezHVM=8gg6wZNzhV2eOytL952SSP3s@mail.gmail.com>
X-Google-Sender-Auth: -5tNkMsdubrk0ZJxnWhLRFM2XC0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166264>

2011/2/7 Tor Arvid Lund <torarvid@gmail.com>:
> Maybe you could run "git p4 submit --verbose"? (the 'verbose' option
> might give you a clue as to what the underlying problem is)
I did that actually, just did not want to send the whole output. :)

I will investigate it further, but my boss gave a new highest priority
task for me... :(

Endre
