From: demerphq <demerphq@gmail.com>
Subject: Re: Rebase and incrementing version numbers
Date: Thu, 19 Jan 2012 19:12:21 +0100
Message-ID: <CANgJU+WWq=+BP1ZDbGY3weB5Xey2TtbryDJvz5=eMLFzNet3xQ@mail.gmail.com>
References: <CADo4Y9jGYJasDL9m7_50aOTrOyoezdyg=vcsZhQ87Qk-1XfTUQ@mail.gmail.com>
	<CADo4Y9iKvoXhKg5pEAB+cbA7Rkfa=nF4TLu0xgcS3dnkNi_n4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: mike@nahas.com
X-From: git-owner@vger.kernel.org Thu Jan 19 19:12:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnwTL-0005ag-Lf
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 19:12:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932684Ab2ASSMX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jan 2012 13:12:23 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43380 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932195Ab2ASSMW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2012 13:12:22 -0500
Received: by yenm6 with SMTP id m6so149629yen.19
        for <git@vger.kernel.org>; Thu, 19 Jan 2012 10:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=HxDAUqrv/cTAGYCo/ZV2rX3VDyBGgw80cKaS3JL3UnQ=;
        b=CxE0kXyOlSiHjzdzaTRwkczoaiWTqSZz7eZy40w1pRRZBqWtKBPLCKXFIwPkI36LDo
         Tmh+R7FNWuSIc2kZ6djFDtAUYug2mHSKWZvCAjKND3RG1L3gpsN34fLa9AZLrnf0Jo4j
         8aEHTdRuRzhKD/k2JCg4Oh4VEDYIbaxvP1qy0=
Received: by 10.236.9.97 with SMTP id 61mr41105506yhs.71.1326996741924; Thu,
 19 Jan 2012 10:12:21 -0800 (PST)
Received: by 10.236.63.2 with HTTP; Thu, 19 Jan 2012 10:12:21 -0800 (PST)
In-Reply-To: <CADo4Y9iKvoXhKg5pEAB+cbA7Rkfa=nF4TLu0xgcS3dnkNi_n4g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188821>

On 19 January 2012 18:20, Michael Nahas <mike.nahas@gmail.com> wrote:
> I'm at a new job and using Git-SVN at a place that is accustomed to S=
VN.
>
> The problem I'm running into is that whenever I change a file in a
> directory, I have to bump up the version number in the configuration
> file. =A0The larger version value in the config file causes my change=
s
> to be loaded over the old ones.
>
> Most of my commits are edits to a file like "foo.js" and an increment
> to the version number in "config". =A0Ideally, each of my features
> should live in a single commit and I should be able to make a sequenc=
e
> of them, each time incrementing the version number in config.
>
> The problem I'm running into starts with me editing version=3D100. =A0=
I
> create new commits where I set the version to 101, 102, 103, 104.
> When I go to push ("git svn dcommit"), my coworkers have incremented
> the version to 103. =A0So, I rebase my changes, and get conflicts eve=
ry
> time because of the version number!
>
> Is there a good way to avoid these conflicts? =A0Is there a hook I ca=
n
> write? =A0Is there a change to this process that would work smoother
> with Git and its distributed development? =A0It's okay if the version
> number skips numbers (e.g., jumps from 100 to 104), as long as it
> increases.

Stop using version numbers and start using the git sha1 of the code
you are using.

Yves

--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
