From: Endre Czirbesz <endre@czirbesz.hu>
Subject: Re: git to p4 conversion
Date: Mon, 7 Feb 2011 13:57:18 +0000
Message-ID: <AANLkTimP81rVPwvpaCSgBJiZ2Jm131+Q9E-Fkj0-jZfd@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tor Arvid Lund <torarvid@gmail.com>, git@vger.kernel.org,
	Ian Wienand <ianw@vmware.com>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 14:57:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmRan-0007LZ-DZ
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 14:57:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809Ab1BGN5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 08:57:20 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54561 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752779Ab1BGN5T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 08:57:19 -0500
Received: by vws16 with SMTP id 16so2912645vws.19
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 05:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=9F9BI55ZT2npLWVdrt2WWeURcRyqD9YwgJVdytYuOZY=;
        b=Rc8fYAF24OgAp13TWVPgJw+1UdU7HeS6+lgpBMG7QPxRm+aKyjKhyIzhB6fsyPJDUB
         ds9O4KN9mPIJ9EO95NQLV6IDZ7PilxIFxqGJjv7ZXPv5QB9WVBTyh2sVMFwtPl6255ej
         hJZaIj8Oz9dRId51ybUwvu+FoXhBt0GF16u1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=mw1V8DyvK58XNhR6srPRJCRC/n9uQ+u3TMH+CyNdebcER3vm6KESCjkcYY8HLtfSIF
         87nUgvWYevG8n8GWHVsX8z5qPIJtdefdVZqxLV2cpj7gqO4N/XSprQW0OJgFk5ubrwvG
         H8AmsxJ5BRe1UUhjAdvDys+VuWPVnoev505OA=
Received: by 10.220.190.5 with SMTP id dg5mr4347630vcb.115.1297087038118; Mon,
 07 Feb 2011 05:57:18 -0800 (PST)
Received: by 10.220.161.21 with HTTP; Mon, 7 Feb 2011 05:57:18 -0800 (PST)
In-Reply-To: <AANLkTimV1aRiEMa2z-H2bOvRa9H6YAyET1=hn+_O0-0u@mail.gmail.com>
X-Google-Sender-Auth: 69wkwfF9vOTLahJgBSRUrT9ZtrY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166261>

Hi,

Thanks for your patience and the detailed help.
I forgot only one thing, that I need two separate directories... :)

So, after some minor mods in git-p4 (I have some directories with
spaces, and some files with #@*% in their names), it seems as if it
worked, my files are in P4 depot, although I got an error message:

Failed to merge in the changes.
Patch failed at 0001 Initial commit

When you have resolved this problem run "git rebase --continue".
If you would prefer to skip this patch, instead run "git rebase --skip".
To restore the original branch and stop rebasing run "git rebase --abort".

Exception: command failed: git rebase remotes/p4/master

Regards,

Endre
