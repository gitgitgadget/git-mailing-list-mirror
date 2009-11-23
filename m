From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: 'error: unable to set permission to './objects/...'
Date: Mon, 23 Nov 2009 10:52:49 +0100
Message-ID: <46a038f90911230152j34f42e85ibf4ed57660bd2cf2@mail.gmail.com>
References: <9bbf67fa0911221202r605de38coc2496b1f09123725@mail.gmail.com>
	 <7vd43acf7y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Rafal Rusin <rafal.rusin@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 23 11:14:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCVw0-0007K8-5H
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 11:14:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756884AbZKWKOA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Nov 2009 05:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756818AbZKWKOA
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 05:14:00 -0500
Received: from mail-ew0-f215.google.com ([209.85.219.215]:65530 "EHLO
	mail-ew0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756145AbZKWKN7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Nov 2009 05:13:59 -0500
X-Greylist: delayed 1271 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Nov 2009 05:13:58 EST
Received: by ewy7 with SMTP id 7so1683353ewy.28
        for <git@vger.kernel.org>; Mon, 23 Nov 2009 02:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4C8thnVPi1jBRyixpApmFshmG9fE/0gkjvy/4hT/CUM=;
        b=JxlN5FQl9lA0YNwv351eP49JsR0x4olf4Ck/D356WEy/1x8om+OjAUfcHRpcbL8Xm2
         4GW9JtqLzMyOyn8WFHYVLpEPSLAc3DJXpazCs71Wxpd+WtP8cA2+RhyRVVXGMRHphXMj
         UXARMpgAtYlOeVDPNTKTJhKPlscKIVYKhzILo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dfF3TlmRvlh+ccGVTMfybaPsH1fvr/FI9D6XfGMwwF4CK5jpFu4FREpDhpmA70iZtT
         xkEBnbB+RwVGfcWJTkf3zUIehrc3x+3vQ+1fIT65sqxEU7eRfwPM/HfD0RySrthp3Frq
         0t7AMEOSOwp7wM1zWl+cM4+fswEKHhMiyZel4=
Received: by 10.213.23.76 with SMTP id q12mr3300005ebb.83.1258969969479; Mon, 
	23 Nov 2009 01:52:49 -0800 (PST)
In-Reply-To: <7vd43acf7y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133495>

On Mon, Nov 23, 2009 at 12:27 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> And the chmod() fails
> in this codepath. =A0Then what? =A0Wouldn't it make the resulting rep=
ository
> unusable?

Slightly off-topic: I keep encountering hosts where
core.sharedrepository doesn't always work with git+ssh. It may be
related to old git versions (I see 1.5.8 in a host where I've seen it
happen recently), but I never fails to baffle me.

Been sysadmin'ing and developing on linux  since '98 and there is
nothing to prevent git from chmod'ing things right. And I know a few
things about git's plumbing :-) -- don't think it should be
mysteriously failing.

(And in several git repo servers I've spotted a cronjob doing chmod -R
g+rwx, applied by sysadmins to make the devs STFU about it ;-) ).

Is there a shortlist somewhere of reasons for it to be ignored?
Perhaps it is a known bug in old versions? -- the repo servers are
often behind...

Puzzled minds want to know.



m
--=20
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
