From: Endre Czirbesz <endre@czirbesz.hu>
Subject: Re: git to p4 conversion
Date: Thu, 3 Feb 2011 19:50:28 +0000
Message-ID: <AANLkTikW_sU8oCmU9wN5q1OPPJrQbS2YZAvS0C_nBQbD@mail.gmail.com>
References: <AANLkTi=0TSD6p7WtsVzx=pq8=GVu+jHUdxt1bnC++CT+@mail.gmail.com>
	<4D4AF29E.7070509@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Ian Wienand <ianw@vmware.com>
X-From: git-owner@vger.kernel.org Thu Feb 03 20:50:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pl5CM-0006VD-CY
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 20:50:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756631Ab1BCTu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 14:50:29 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:53007 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756588Ab1BCTu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 14:50:28 -0500
Received: by qwa26 with SMTP id 26so1250137qwa.19
        for <git@vger.kernel.org>; Thu, 03 Feb 2011 11:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=jx8cOchLKEGOikYw3xjOiShglqYfOdwxCCAKSX+Wa38=;
        b=bR0jR6ZFCiEs+sFQ5Q3s+H1+aVEttR8HJ8q3FPHKxcntiop6wvfI0etJjYrguWFwR6
         YafLdJ1iryG8ff5JUT4e5r2LOG4MCNLSNJgv01woafdlVBX1zbCRPzpvZXrxczSUWQj/
         eJvKjKL6W+UwMWTos7I4Q93k0lIOKqs+SsKW4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=rkEWIjtbCCu7eHUCveYDLp8+l6FM52vcgAZXX+9ezuywepkUiobDCmpPu9u+46D27b
         IOwQbil5piFwqJZR1sk7yoFaPeEg3u43sQWSh8VE3UKIQuwb2nUMfz5jz25+LrUQwmRO
         boZ5B2CbtXUFYm/FWcd/kcF+J2AteNPvZt9Kc=
Received: by 10.229.90.196 with SMTP id j4mr9452116qcm.144.1296762628208; Thu,
 03 Feb 2011 11:50:28 -0800 (PST)
Received: by 10.229.67.26 with HTTP; Thu, 3 Feb 2011 11:50:28 -0800 (PST)
In-Reply-To: <4D4AF29E.7070509@vmware.com>
X-Google-Sender-Auth: 9lWV3UtlOWuSUthTE8J7j2_ImK8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165991>

Hello Ian,

Thanks for your reply.

2011/2/3 Ian Wienand <ianw@vmware.com>:
> What exactly did you try?
I am not at my work computer now, but as I remember:

cd workdir
git-p4 clone //depot/projectdir/...@all .
git clone myprojectrepo .

(Everything went fine till this point.)

git-p4 sync
git-p4 submit
Fatal error...

I don't remember the exact message, but it tried to reach a
non-existing git commit (HEAD~xx, where xx was count of my commits, so
it tried to refer to a commit before my initial commit).
I tried to change the order of the clone steps, but the result was the same.

Rgds,

Endre
