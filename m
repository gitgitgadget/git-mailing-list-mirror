From: Endre Czirbesz <endre@czirbesz.hu>
Subject: Re: git to p4 conversion
Date: Fri, 4 Feb 2011 16:52:05 +0000
Message-ID: <AANLkTimJm81V0D8_j3OfZTcEkyn_jd6_QB2nv8T69JBY@mail.gmail.com>
References: <AANLkTi=0TSD6p7WtsVzx=pq8=GVu+jHUdxt1bnC++CT+@mail.gmail.com>
	<4D4AF29E.7070509@vmware.com>
	<AANLkTikW_sU8oCmU9wN5q1OPPJrQbS2YZAvS0C_nBQbD@mail.gmail.com>
	<loom.20110204T004658-497@post.gmane.org>
	<AANLkTikfGapDfZtD9H10797Ted_Av78WD8M7XrACOCpW@mail.gmail.com>
	<AANLkTimrwUxNOAnfxgvReGN+-h4_0jhZ731y22TB6u1K@mail.gmail.com>
	<AANLkTi=_spLE-KMnou-2LLQjwq4FUZxNr9pk7D9C=4PK@mail.gmail.com>
	<AANLkTi=dZdSqcNckyU7Lb2Zj-khfj=Xiyzbv7LSC+zT2@mail.gmail.com>
	<AANLkTimGaPQ=hRp+2pvw-hAOg+wp50nvc_sv9jNTay=n@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ian Wienand <ianw@vmware.com>,
	Tor Arvid Lund <torarvid@gmail.com>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 04 17:52:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlOtK-0005r0-0S
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 17:52:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582Ab1BDQwI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Feb 2011 11:52:08 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:42482 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752060Ab1BDQwG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Feb 2011 11:52:06 -0500
Received: by qwa26 with SMTP id 26so1934467qwa.19
        for <git@vger.kernel.org>; Fri, 04 Feb 2011 08:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=49C/0I8eR4/z1ck1ovWjL0SzNzSmXzLH4Z6zLVQnO9Q=;
        b=XW+aQItaTMbyaAUl4FruHHNyD9hNYaiB77Ft0mxAAFwGRUlrsF3VHGno0OzgQzNARa
         PR+cd8MH3uZEI3Ehni+oelNh81ax5d0vY8heTBqCaI0gB1tITfXmB1P/IQUqcZQKjsN1
         x5X0m/Rvd4KtVZ8PoUo0fKtId94J7ETk6bgQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=R5sPXEy+rPypd3ZDzg15ecPGlb5cBLCEFTZl3s23Fa9TpKS/1HGmWdkZqXcWkhsUob
         0HirPN77oStGVVlUu1Ub4MMdKZ77RpjoDUABeAJBaIrjBQc4FpWhRZ43ZLBEaeckdRu+
         SurPUB1S9CRuEhA0TteLilZPQvOR+EnT+Qo+s=
Received: by 10.229.90.196 with SMTP id j4mr10306338qcm.144.1296838325724;
 Fri, 04 Feb 2011 08:52:05 -0800 (PST)
Received: by 10.229.67.26 with HTTP; Fri, 4 Feb 2011 08:52:05 -0800 (PST)
In-Reply-To: <AANLkTimGaPQ=hRp+2pvw-hAOg+wp50nvc_sv9jNTay=n@mail.gmail.com>
X-Google-Sender-Auth: gdHSRMQf6Coo--drYUJFxyrmqMI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166048>

Hi Vitor,

2011/2/4 Vitor Antunes <vitor.hda@gmail.com>:
>> I dropped the whole directory, and then recreated it, I do not know
>> any better 'cleanup'. :)
>
> Which directory did you drop? Was is the git repository or the P4 workspace?
> You need to clean up the later. Basically, a "rm -rf
> path/to/p4_workspace" and a "p4 sync -f" should do the trick :)

It is almost the same in my case. :)
My p4 client root is ~/work/, my project dir is ~/work/projdir (and at
the moment this is the only directory within ~/work/), and I dropped
the latter.
And then it was created again by git-p4 clone.

I can drop the workspace root, but I do not think it would help.

Regards,

Endre
