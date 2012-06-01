From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: GIT PULL] ext4 updates for 3.5
Date: Fri, 1 Jun 2012 10:56:43 -0700
Message-ID: <CA+55aFxgZupkAotfjUuWcfwTzHDYg0Afezme62P17=EX2KN+UQ@mail.gmail.com>
References: <E1SaTSI-0005UV-4B@tytso-glaptop.cam.corp.google.com>
 <CA+55aFwk8oYx8EKWdT=5cMTLK7RDz8GQdGmHk2KXwcCq+Bb8PA@mail.gmail.com>
 <CA+55aFwwfMTN=WGQGmFO7DYeBUOGA7V4_6XueQS4JAzeykwn3Q@mail.gmail.com> <20120601174336.GA15778@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "Ted Ts'o" <tytso@mit.edu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: linux-ext4-owner@vger.kernel.org Fri Jun 01 19:57:10 2012
Return-path: <linux-ext4-owner@vger.kernel.org>
Envelope-to: gcfe-linux-ext4@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-ext4-owner@vger.kernel.org>)
	id 1SaW61-0005Jt-NG
	for gcfe-linux-ext4@plane.gmane.org; Fri, 01 Jun 2012 19:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759261Ab2FAR5H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcfe-linux-ext4@m.gmane.org>); Fri, 1 Jun 2012 13:57:07 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:58287 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758809Ab2FAR5G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ext4@vger.kernel.org>); Fri, 1 Jun 2012 13:57:06 -0400
Received: by wgbds11 with SMTP id ds11so763504wgb.1
        for <multiple recipients>; Fri, 01 Jun 2012 10:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=v7MO6zSgVpU+P1Dk9B6zZcZnSeCFrfU46gQyvu2WtUQ=;
        b=q3a2Q3hPeHCBfSTaTSnVhkToYayuwoajgwrwNajzmyq390bXRxMte3NI0N5CZzekkQ
         rEeV1tZL6utthWWfTB/LYl67ITl0HW824wxnjhPmJn2GZGNAx2o7QPqb5Mqk9qg0qGSW
         VVb2+OTVg7RwPdRMU9bj4t4ceX0VAwQoQPrWSZWXtRluXLPjKbfvwmDZOZ1S7CWtY/xW
         vGoZLQdOadvEGjTPNDUX1Y7GueEfDJT7aRsVq42ZOoSU2X9n2H2YJO316bTI+fjcZqSl
         Q3UUs0CUR8DL577sKmvpupvE2Qgjyog7DG4SLJ7ibL9Y7B+Fo85q27ETcoDGowDV5O3E
         mIWg==
Received: by 10.216.197.4 with SMTP id s4mr2819688wen.181.1338573423899; Fri,
 01 Jun 2012 10:57:03 -0700 (PDT)
Received: by 10.216.225.99 with HTTP; Fri, 1 Jun 2012 10:56:43 -0700 (PDT)
In-Reply-To: <20120601174336.GA15778@thunk.org>
X-Google-Sender-Auth: 5b5jYqZKTZRXTifI-P41RjpAp9Q
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199007>

On Fri, Jun 1, 2012 at 10:43 AM, Ted Ts'o <tytso@mit.edu> wrote:
>
> So I should do "git request-pull origin git://... ext4_for_linus" nex=
t
> time, right?

Right.

> Sorry about that. =A0I thought it had included the reference to tag
> automatically since the text of the tag showed in the request-pull
> text.

Apparently git request-pull is too damn smart for its own good, and
will find the tags even when they aren't mentioned, making you think
it made it to me. Bot it doesn't - so then I have to go search for
them by hand.

Added Junio and git to the cc: if git finds the tag and uses that for
the request-pull message text, then it should use the tagname for the
pull request line too. Or, alternatively, don't be smart at all, and
force users to name the tag explicitly. The current "both smart and
dumb" combination seems to be the worst of both world.

              Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-ext4" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
