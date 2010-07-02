From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [WIP/PATCH] Teach fast-import to print the id of each imported 
	commit
Date: Fri, 2 Jul 2010 16:55:01 +0200
Message-ID: <AANLkTintWyhcx9pURSqxs3e9BBkPx9KSPPYh4UOU7kv6@mail.gmail.com>
References: <20100701031819.GA12524@burratino> <20100701054849.GA14972@burratino> 
	<20100702051201.GC7209@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 16:55:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUheV-0001PG-B9
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 16:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758067Ab0GBOz0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Jul 2010 10:55:26 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41803 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755996Ab0GBOzW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Jul 2010 10:55:22 -0400
Received: by gye5 with SMTP id 5so423373gye.19
        for <git@vger.kernel.org>; Fri, 02 Jul 2010 07:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=gwO6JwkukDKYrDmer6ojITa507p1YrSBqEc/OLd65aU=;
        b=sjB64kwR/zPSOhkeoJ3UqmqyC0Qcoq1oU9yhSPKCVWv7BXAgYqNpWQn1fcYHzEzMZm
         j/99qi8Zu+FnoqS/5aNfVpGY0AJWRaAH1pXkjilclvlmuBVmVKsj4f/LjOJvxLEukQFq
         83k39E8ll4Koxs6gakv/ShboG9aGDPNUYpSWU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=dW5v8tZdF/KlASI/u2UlzyJA46rgcufgD6nYTcKCFX4uSN6D1sZC0FnwYH+t0AvC2G
         Bi8NDUAxTAr2eqByJ0BNyvuqOIbbU9gTcMBa8s9bPe4BVgp/cv0Gib0U15EscEEhIpFk
         w2jGZlbsnp9hdLtJozfFNa32Mw6aj2ZegID9Y=
Received: by 10.229.97.69 with SMTP id k5mr553369qcn.236.1278082521511; Fri, 
	02 Jul 2010 07:55:21 -0700 (PDT)
Received: by 10.150.184.8 with HTTP; Fri, 2 Jul 2010 07:55:01 -0700 (PDT)
In-Reply-To: <20100702051201.GC7209@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150127>

Heya,

On Fri, Jul 2, 2010 at 07:12, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> A =E2=80=98cat=E2=80=99 command (suggested by David) would also be us=
eful, so the
> caller can read trees and blobs before they are accessible through
> the object db. =C2=A0The svn importer would use this when applying
> (svndiff0-format) deltas to import changes to regular files.

How would the output be delimited? The same way fast-import expects
its blob input?

--=20
Cheers,

Sverre Rabbelier
