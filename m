From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Wed, 27 Apr 2011 15:10:49 +1000
Message-ID: <BANLkTinFX24gTR-0PK8Tyi5aOf8rnLk6Cg@mail.gmail.com>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
	<7vwrig9ta7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 07:10:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEx1c-0000Di-5F
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 07:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441Ab1D0FKv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Apr 2011 01:10:51 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56588 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304Ab1D0FKu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2011 01:10:50 -0400
Received: by ewy4 with SMTP id 4so398026ewy.19
        for <git@vger.kernel.org>; Tue, 26 Apr 2011 22:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2vJfWqIhefyj/W/OwLZvNjBzr86zplYhgdVrPlVfC0c=;
        b=eLa8GyR0d2SBAE/fhcbSZ1hr7veWCNRK0qPjzWoj8kgeiYpI6dIsRUMOBVrxv3gr04
         Csy4+Jr1OR5vd3kJxm3fJ4pNECkiZHtP+ZOpnuxQgqCgoBFJB8snj4/LtlwqxxR70KMf
         d4qMzERvCEEJZax9XcOGRk/C9ZsC4ZEldc4ng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ghls3c6hXKl85WCw4R1oW+kecEeuJQVDSsGyLKTAa7eRQkzwssZ16zvlcdeFHO5Ncj
         aPOVT9uPJDOTl3XsvoJsKGFHH+5drfCkmGtjNGMJ2+JUsnVPkxvvRZXMPyh2f5INGvud
         jsV3hEhHav+5IowzYLN/LSLwta+KnqzqFG8+0=
Received: by 10.14.123.9 with SMTP id u9mr709821eeh.53.1303881049571; Tue, 26
 Apr 2011 22:10:49 -0700 (PDT)
Received: by 10.14.22.68 with HTTP; Tue, 26 Apr 2011 22:10:49 -0700 (PDT)
In-Reply-To: <7vwrig9ta7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172171>

On Wed, Apr 27, 2011 at 3:07 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jon Seymour <jon.seymour@gmail.com> writes:
>
>> Has anyone ever given consideration to git supporting a plugin
>> architecture for git extensions?
>
> Hint. =C2=A0The output from "git help --all" is produced by finding a=
ny
> executable whose name match "git-*" on your $PATH.
>
> So if you have /home/js/bin on your $PATH, you can install your "git-=
work"
> script as /home/js/bin/git-work, and that should be sufficient.
>

Yep, that's a start, but does not a a complete plugin architecture make=
 :-)

jon.
