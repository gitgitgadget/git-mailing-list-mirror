From: Alfonso de la Osa <arfonzi@gmail.com>
Subject: One file is in one place in the server's repo but in another in local ones.
Date: Mon, 29 Nov 2010 18:39:38 +0100
Message-ID: <AANLkTi=CC8wa+C3xq5fc6mM58-Xo8yXRuFox6Yx9Uqvw@mail.gmail.com>
References: <AANLkTinRExEjYMHbUZevtR7nSbO1sbqMH8UCY0x5t1s1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 29 18:39:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PN7hX-0006Iq-WA
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 18:39:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754992Ab0K2Rjk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Nov 2010 12:39:40 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:59730 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755355Ab0K2Rjj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Nov 2010 12:39:39 -0500
Received: by qwb7 with SMTP id 7so4741237qwb.19
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 09:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=tdDuMzQem6mGspDweJ6ebKOJ4gpLw3og0bHels6+JrM=;
        b=IK0iP8GsuRkxFLbPphoopzBTR/OwCEABT5PxjaPQb5IaMDKyYOY0GmTFILjA96pPvB
         J1Lkjic0vMQmZzpVjqFYbFBTXD1bt6zoGOyw4O3uTHNQV/tDzMt9YSHeKvvZJULEPyas
         rIlr4VsK3mfYi5O6NtrurD0R1XEftkA/GT2/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=u8N2CP+X4ZsuzWyNJHlO38eupzUfwLQCjS7eLhh3w03okMFvGWs/aLsXwFWL0kTgEe
         6F1YszsKVneAtPECpC4g3j6p/s6EqWwzF7iTp5jt15utE9MqMg/ehMFKUAdgCWnjKItI
         p4O/7s4RFe1DMIhJKAeV0AkpIQqxc9ZMGaJ44=
Received: by 10.229.97.13 with SMTP id j13mr4993478qcn.251.1291052378782; Mon,
 29 Nov 2010 09:39:38 -0800 (PST)
Received: by 10.229.240.6 with HTTP; Mon, 29 Nov 2010 09:39:38 -0800 (PST)
In-Reply-To: <AANLkTinRExEjYMHbUZevtR7nSbO1sbqMH8UCY0x5t1s1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162408>

Hi,
I have a problem, it may be a bug.
I have only one branch (master),
I pushed some changes when I moved one file to a folder that was
called in the same way than the original but in lowercase
lib/Imagine/Imagine.php =3D> lib/imagine/Imagine.php,
Then I decided to move it back and removed the new folder and pushed
it in another commit.
so the file is like this: lib/Imagine/Imagine.php again, the lowercase
folder imagine exist no more
But now the repo has two folders Imagine and imagine, when I change
anything, the repo takes the changes: added a README file,
changed some lines in Imagine.php (the conflicted file), and
everything goes right, in my computers everything is in the place, but
in github or when I do a new clone, the file is in the wrong folder
(with the last changes ok, but in the wrong place) and is the only
thing that is not ok.
How can I test if this is a bug? how can I solve it if it isn't?
Thank you for your time!

--

alfonso.delaosa@gmail.com
Alfonso=A0de la Osa
