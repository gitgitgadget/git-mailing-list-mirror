From: B Smith-Mannschott <bsmith.occs@gmail.com>
Subject: Re: Interest in locking mechanism?
Date: Tue, 12 Jan 2010 19:29:41 +0100
Message-ID: <28c656e21001121029h42544f3er6eedf8465851fec1@mail.gmail.com>
References: <1263319565-sup-1767@ezyang>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: "Edward Z. Yang" <ezyang@mit.edu>
X-From: git-owner@vger.kernel.org Tue Jan 12 19:29:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUlUy-0004OP-Fi
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 19:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754712Ab0ALS3o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jan 2010 13:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754710Ab0ALS3o
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 13:29:44 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:48065 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754300Ab0ALS3n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jan 2010 13:29:43 -0500
Received: by ewy1 with SMTP id 1so4997103ewy.28
        for <git@vger.kernel.org>; Tue, 12 Jan 2010 10:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=I0IUuNUd5OjMKtzQ3AXBDsHLkOi9qyaqmw15Fgcqtmo=;
        b=EnLmkKRiQD1i/3yRvRQr19yZFNSjJfEnEUVAKeKClmXOVUU48LY35n+Y3zuPYgR2Rf
         FArepgv+nt9uRGm8pqZUBI5uBEaCXTkhWVlRCPGR4SKlqRx5af4k3ybt/6cbBV21P8YI
         70KFHc7OXWcw6fjP9sBwWvTV7mGj71fRTF04Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pPvyjZSNq7DkWoixaL7S4M74/dt8uMNrnKi+OMNIwSwOCVoRvbKfUYxUvcAmbA7Ao3
         c4IzrBmjyKmzSkXNPQA8MTAqqHsjre3iV9mm8LKhhCxZNUP1Z5TUkeSdmPiSXLmiQXTF
         YO41zi8sCUiBRGFiXL8wvlC2+OVkbNrpeN35o=
Received: by 10.213.98.140 with SMTP id q12mr5210281ebn.1.1263320981924; Tue, 
	12 Jan 2010 10:29:41 -0800 (PST)
In-Reply-To: <1263319565-sup-1767@ezyang>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136746>

On Tue, Jan 12, 2010 at 19:10, Edward Z. Yang <ezyang@mit.edu> wrote:
> I have a few friends that still use RCS for their version control
> needs. =C2=A0We have argued over various points between RCS and Git, =
and
> as far as I can tell the one thing RCS has that Git does not is
> a locking mechanism. =C2=A0That is to say, co -l checks out a file an=
d
> also gives you a lock on it, preventing others from futzing with it,
> and ci -u checks in the file and releases your lock. =C2=A0This is
> useful if you have a shared working copy on a multiuser system or
> on a network file system, and you don't want conflicts.
>
> I was wondering if there would be interest in such a feature on
> the Git developers side.

How do you imagine that this would work in a distributed system such
as git? What would it mean to have the lock for "a file", when each
user effectively has their own branch?

// Ben
