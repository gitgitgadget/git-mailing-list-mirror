From: Colby Ranger <cranger@google.com>
Subject: Re: [PATCH] Add persistent-https to contrib
Date: Tue, 29 May 2012 14:29:14 -0700
Message-ID: <CAFFbUKJz=-KdNJSgqwkaBNAL6gyBzjxCkVjKgAmHQ7ztzGh=UA@mail.gmail.com>
References: <1337792767-18914-1-git-send-email-cranger@google.com>
	<7v62blxx2m.fsf@alter.siamese.dyndns.org>
	<CAJo=hJt=q-ZnLrqzcfGrKNcao2MPDSRt3Y_r2OOfu75++N+3zw@mail.gmail.com>
	<7vlikhwbdc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 29 23:29:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZTyk-0008DZ-0s
	for gcvg-git-2@plane.gmane.org; Tue, 29 May 2012 23:29:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755937Ab2E2V3R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 May 2012 17:29:17 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:45220 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755921Ab2E2V3P convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 May 2012 17:29:15 -0400
Received: by vcbf11 with SMTP id f11so2424900vcb.19
        for <git@vger.kernel.org>; Tue, 29 May 2012 14:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record;
        bh=ol0Hnori8SX5QI+LAmlhXPjWemMF0/YnlU4eTKRF5YI=;
        b=HyeQrfK0i9fOrdP7M0i++vtIBBvYcPhGhR2H11101E4MpRt4fjlLnW1gHMZNouZpS1
         sKMDPXu1kq5n6DUWAcSFKd+FOMTslpercG6ZiiWtHRXR3ZTGAJYnak9z2Y//2bpsjW+D
         IQGnlEEthzwha7+BmqLGjW9h7bvsCm7zjXSUn37o9XFVxX+NdR/ZHRYto1h6wNHd72pS
         wXa2SXrcFA0DOBDb28Kfj6AvmXZltj+FGdPqCPXjByohRDAUznLQeSPzdOxMmJptzRIA
         o3EVuz2wvxV2NRq6HhqYkeV/pH7b1auuAPBiRkUrr4c8DganhvosWM6eD7+aQBEvViVE
         HjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record
         :x-gm-message-state;
        bh=ol0Hnori8SX5QI+LAmlhXPjWemMF0/YnlU4eTKRF5YI=;
        b=ZvQ9e6cbqTn55ftbFUyRZx8d3iUFlsJ2PxwhbbR62byTvudk5kxHI5tOCL4rb1PyoL
         YWopm3aEPVdKaU7ovc8q6X8Ylucs3mvCx5IgjwdE/RpAtx2AGcA1HniK8NE8+MNigWNi
         YpLsWG4By/3LHFuDn4IYf/HPjvWb2cdw3/iVaJeorxyvz1RnaTHJNAuA0k/uL4//qt1h
         i9+ztCxV1nBdml4wm+vYjXkY3WqiOd5DAIc61TK5O2egxnd6jSMqtxL5VccsVhkp/MUh
         Sbl/c2IaE4gdzir+x8dFX+VDTxZKGxPHY3DaErAsyGz9lPGA6HwCbUVqs9aSWGgjVKic
         RfgQ==
Received: by 10.52.70.116 with SMTP id l20mr12328167vdu.19.1338326954249;
        Tue, 29 May 2012 14:29:14 -0700 (PDT)
Received: by 10.52.70.116 with SMTP id l20mr12328159vdu.19.1338326954145; Tue,
 29 May 2012 14:29:14 -0700 (PDT)
Received: by 10.52.175.232 with HTTP; Tue, 29 May 2012 14:29:14 -0700 (PDT)
In-Reply-To: <7vlikhwbdc.fsf@alter.siamese.dyndns.org>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQmeBCGU8eHZ3ShtNSTtaTdb2gKomkHLKfIte/NZKblBEld/1aNusd3hLfy20tAw+Lu4YbPxcC3OQK3ryezbFI+kMx6rFgH4dqfjRs2ZmCYYbRS/n08dmXwfLcQRF/EAVoIWqBYKGaEqedu4mb+OPTjMmhNp0w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198764>

> I do not mind carrying this in the contrib/ area (I am assuming that
> distributing Apache licensed software that does not link with GPLv2 c=
ore
> is OK).  It may be just me, but a file called COPYING that does not h=
ave
> GPL text in it was a bit surprising.  I wonder if it is more customar=
y to
> call it either LICENSE (or perhaps LICENSE-2.0)?

Agreed. I'll change the name to LICENSE.


> It might deserve its own contrib/persistent-https/Makefile in additio=
n to
> your internal "release" scripts, though.

OK. I'll update the code to use a simple Makefile for everything,
instead of the shell scripts.


> More specifically, this environment variable is a way to tell the wra=
pped
> helper who is wrapping it. =A0Users outside Google's environment of t=
he
> persistent-https helper obviously would not care about the corporate
> sanitary sewer overflow mechanism, but they may have a similar need t=
o
> tweak what happens inside the git-remote-http that is driven by the
> persistent helper. They would not care about "we can enable corpsso",=
 but
> they would benefit from knowing that either:
>
> =A0(1) the connection is "secure" (by the definition above); or
> =A0(2) the connection is going to this particular helper.

Agreed, I'll go with approach (1) and change the name of the var to be
GIT_PERSISTENT_HTTPS_SECURE. Also, I will update the code to remove
any GIT_PERSISTENT_HTTPS_SECURE from the environment.
