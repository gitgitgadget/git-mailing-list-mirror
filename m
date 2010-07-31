From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] test-lib: Remove 3 year old no-op --no-python option
Date: Sat, 31 Jul 2010 16:52:52 +0000
Message-ID: <AANLkTinPx6HbaQQF04XoDu6ACBYzyCNFhCQgFQiy=ayO@mail.gmail.com>
References: <1280594993-2481-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 31 18:53:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfFIx-0004Pp-RX
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 18:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756014Ab0GaQwy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 12:52:54 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37006 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755836Ab0GaQwx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Jul 2010 12:52:53 -0400
Received: by iwn7 with SMTP id 7so2467890iwn.19
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 09:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=01bRUwlCcPBHEXrmLqzSnM2N787v2J34gOLLrl0y9sg=;
        b=RBA3iZLS9l7OmCJ43Ohk1OYaUg7KiXAtKivBlQcP85W+6IcvpY03+9CL7KUb3L5/yF
         89EhVbIUx/SJE8YLrULU6SsrIWO0ZBChLCgFv5bh5fMgruYZI5qyOB6C7yHc0BsXBeh5
         E6ZA8Am/ZJxuG+HPwlCjp9TB3nbuTLE5MOA2M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xTz2gmYnSszi9ixQWeFnm5ouYG+NmtS1Kg3OLkYxUYJMSywyak2GYYZk8wRHvEKYg/
         sTDtoRdhauP/vrWo7pD6l0H9aRDP/+7BLP8RQk5T0lPcdHdG5LktjNEzAKTsK1LnCeoB
         PeSsnUqI1UnFYsPK6buKSycRndClzGblW50Hg=
Received: by 10.231.157.143 with SMTP id b15mr3855565ibx.113.1280595172784; 
	Sat, 31 Jul 2010 09:52:52 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Sat, 31 Jul 2010 09:52:52 -0700 (PDT)
In-Reply-To: <1280594993-2481-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152334>

On Sat, Jul 31, 2010 at 16:49, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> The --no-python option was added to test-lib.sh by Johannes Schindeli=
n
> in early 2006 in abb7c7b3. It was later turned into a no-op by Junio =
C
> Hamano in 7cdbff14 the same year.

Sorry for the resend. git-send-email was hanging and I thought the
original didn't go through:

    Subject: [PATCH] test-lib: Remove 3 year old no-op --no-python opti=
on
    Date: Sat, 31 Jul 2010 16:49:18 +0000
    Message-Id: <1280594958-2314-1-git-send-email-avarab@gmail.com>
    X-Mailer: git-send-email 1.7.1
    MIME-Version: 1.0
    Content-Type: text/plain; charset=3DUTF-8
    Content-Transfer-Encoding: 8bit

    Send this email? ([y]es|[n]o|[q]uit|[a]ll): y
    Password:
    ^C

    stty: standard input: Input/output error

But evidently that went through, here's the output from the second
one:

    Send this email? ([y]es|[n]o|[q]uit|[a]ll): y
    Password:
    OK. Log says:
    Server: smtp.gmail.com
    MAIL FROM:<avarab@gmail.com>
    RCPT TO:<git@vger.kernel.org>
    RCPT TO:<gitster@pobox.com>
    RCPT TO:<avarab@gmail.com>
    From: =3D?UTF-8?q?=3DC3=3D86var=3D20Arnfj=3DC3=3DB6r=3DC3=3DB0=3D20=
Bjarmason?=3D
<avarab@gmail.com>
    To: git@vger.kernel.org
    Cc: Junio C Hamano <gitster@pobox.com>,
            =3D?UTF-8?q?=3DC3=3D86var=3D20Arnfj=3DC3=3DB6r=3DC3=3DB0=3D=
20Bjarmason?=3D
<avarab@gmail.com>
    Subject: [PATCH] test-lib: Remove 3 year old no-op --no-python opti=
on
    Date: Sat, 31 Jul 2010 16:49:53 +0000
    Message-Id: <1280594993-2481-1-git-send-email-avarab@gmail.com>
    X-Mailer: git-send-email 1.7.1
    MIME-Version: 1.0
    Content-Type: text/plain; charset=3DUTF-8
    Content-Transfer-Encoding: 8bit

    Result: 250 2.0.0 OK 1280595002 j1sm1835091wej.39

Perhaps git-send-email should indicate that it has aquired a
connection to the server?
