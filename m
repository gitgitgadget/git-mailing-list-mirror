From: Michael Olson <mwolson@gnu.org>
Subject: Re: [PATCH] git-svn: Allow certain refs to be ignored
Date: Fri, 7 Oct 2011 16:33:27 -0700
Message-ID: <CAN4ruPgRed=dK8PuHCvKRBVvpSK5iDYmprZ1p_Yu8Kqyvu8sfg@mail.gmail.com>
References: <CAN4ruPiSgY+LPdDgS021WQyoHMuNrJDzrqMuCt9G5qfZ=XtjoQ@mail.gmail.com>
 <7vvcs0s7xa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 08 01:34:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCJvS-0005Pg-Ov
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 01:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759584Ab1JGXdx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Oct 2011 19:33:53 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62123 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759384Ab1JGXds convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Oct 2011 19:33:48 -0400
Received: by eye27 with SMTP id 27so26106eye.19
        for <git@vger.kernel.org>; Fri, 07 Oct 2011 16:33:47 -0700 (PDT)
Received: by 10.223.65.76 with SMTP id h12mr13964909fai.7.1318030427292; Fri,
 07 Oct 2011 16:33:47 -0700 (PDT)
Received: by 10.204.112.79 with HTTP; Fri, 7 Oct 2011 16:33:27 -0700 (PDT)
X-Originating-IP: [216.103.134.130]
In-Reply-To: <7vvcs0s7xa.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: MejRDsylrwBAze2dA90naap4gWk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183127>

On Fri, Oct 7, 2011 at 4:23 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Asking Eric to comment when he has time to do so.
>
> I find these pattern matches that are not anchored on either side
> somewhat disturbing (e.g. --ignore-refs=3Dmaster would ignore master2=
)
> but ignore-paths codepath seems to follow the same pattern, so perhap=
s it
> is in line with what git-svn users want. I dunno.

My own personal use of this takes a list of patterns, concatenates
them into one giant pattern, adds '^', '$', and writes it out to
=2Egitconfig.  So I don't really have a preference, other than to make
both options consistent.

--=20
Michael Olson=C2=A0 |=C2=A0 http://mwolson.org/
