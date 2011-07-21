From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git log decipher
Date: Wed, 20 Jul 2011 18:50:45 -0700
Message-ID: <CAJo=hJvvsqki3tLoQRjgf7vQpcH6EHMXXxUbYALw8MvtLzF=gA@mail.gmail.com>
References: <1311212351172-6605124.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: gbhumphrey <greg_spam@gbhumphrey.com>
X-From: git-owner@vger.kernel.org Thu Jul 21 03:51:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjiPy-0006lu-R3
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 03:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905Ab1GUBvK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jul 2011 21:51:10 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:38184 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686Ab1GUBvI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jul 2011 21:51:08 -0400
Received: by ewy4 with SMTP id 4so920482ewy.19
        for <git@vger.kernel.org>; Wed, 20 Jul 2011 18:51:05 -0700 (PDT)
Received: by 10.204.25.194 with SMTP id a2mr2635944bkc.197.1311213065224; Wed,
 20 Jul 2011 18:51:05 -0700 (PDT)
Received: by 10.204.144.195 with HTTP; Wed, 20 Jul 2011 18:50:45 -0700 (PDT)
In-Reply-To: <1311212351172-6605124.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177573>

On Wed, Jul 20, 2011 at 18:39, gbhumphrey <greg_spam@gbhumphrey.com> wr=
ote:
> Hi so in the .git/logs/refs/heads there are log files, i'm tryign to =
decipher
> the timestamp, at least I think it's a time stamp. An entry looks lik=
e this:
> a391d7a96af8c06a626eec23565ceccef81bc350
> fdfb6d8c87521d56d8a6034e8575304013ecdd6c Greg Humphrey &lt;XXX@XXXX.c=
om&gt;
> 1307594233 -0700 =A0 =A0 =A0 =A0merge US199: Merge made by recursive.
>
> The "1307594233 -0700" seems to be a timestamp, but I'm not sure what
> format, anyone have any ideas how to convert to a human readable?

The first number is the seconds since the UNIX epoch. A standard
time_t... in base 10. :-)

The second number is the timezone offset from GMT, in HHMM format. So
-0700 is 7 hours behind GMT.

Its the same format as what appears in a Git commit object for either
the author or committer line.

--=20
Shawn.
