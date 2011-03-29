From: Joe Ratterman <jratt0@gmail.com>
Subject: Re: [PATCH] grep: allow -E and -n to be turned on by default via configuration
Date: Mon, 28 Mar 2011 22:12:27 -0500
Message-ID: <AANLkTikpjoyPWYomKsi0YA=KrcPU2Qxn0dBgjbUi2B_x@mail.gmail.com>
References: <1301088071-918-1-git-send-email-jratt0@gmail.com>
	<7vlj024wal.fsf@alter.siamese.dyndns.org>
	<7vbp0ux5c9.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 05:12:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4PM9-0001tM-TF
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 05:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755538Ab1C2DM3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Mar 2011 23:12:29 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57526 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755505Ab1C2DM2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Mar 2011 23:12:28 -0400
Received: by iwn34 with SMTP id 34so4362232iwn.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 20:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ruMnQi1BEgJA1dv6IePqw96KOzfAC+DXg3MVwvnradQ=;
        b=PRb90dBaI0w7aZ98w9lDXnbdlY4D6cqxBP5Fl/cRCbETolvwJfNAHQFWirlxuoYaoD
         wmNrf9VImFIS5Zh6IED4ns3j3wrhK2F27LaBRYn7gR/Iap0qd1J/VUGws8NLC6HW/50i
         j7ZM2wODP9yb/xhVevWEuGcOa04nK+QnjtZ4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QQxaWZWkdepFtLgbnf/hGQpI9XiO3yPcewbT4FQRPlClhG3EdAJoRFnKa4Sn9xbbSW
         boRgk719+2LBoKLKfPQ9t7EixJjbK7ABa//gQZBnCaF1irvsDo10o4ebPzhW0n4yJC6p
         2VzqdOr9/UppErM+49zELuTk1/4TbOFwCPWC4=
Received: by 10.42.147.134 with SMTP id n6mr7539985icv.216.1301368347822; Mon,
 28 Mar 2011 20:12:27 -0700 (PDT)
Received: by 10.42.218.1 with HTTP; Mon, 28 Mar 2011 20:12:27 -0700 (PDT)
In-Reply-To: <7vbp0ux5c9.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170220>

On Mon, Mar 28, 2011 at 5:12 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> =C2=A0 I did not add tests, but we do need one perhaps at the end of =
t7810 to
> =C2=A0 move things forward.


What sort of tests would be appropriate?  I cannot find anything that
tests -E/--extended-regexp.  I copied the first test that used "git
grep -n" and changed it to these:
1)  git -c grep.linenumber=3Dfalse grep -n  #  Expected to have line nu=
mbers
2)  git -c grep.linenumber=3Dtrue grep  #  Expected to have line number=
s
3)  git -c grep.linenumber=3Dtrue grep --no-line-number  #  Expected to
have no line numbers


Joe
