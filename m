From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCHv3 2/3] cvsimport: fix the parsing of uppercase config options
Date: Wed, 1 Dec 2010 11:18:14 -0500
Message-ID: <AANLkTinJD_WRBxFBMs-p5ox0wZWZvddhSfan0yhaNyGk@mail.gmail.com>
References: <cover.1291207768.git.git@drmicha.warpmail.net>
 <7vd3pmw9n5.fsf@alter.siamese.dyndns.org> <b61288036e756c78709438491416d573459a732e.1291207768.git.git@drmicha.warpmail.net>
 <AANLkTi=cb0i28oGi9vrYfEyU_fPHhQGhNNtramtCpCHy@mail.gmail.com> <20101201160503.GB26120@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 01 17:18:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNpOG-000487-Ck
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 17:18:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754957Ab0LAQSg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Dec 2010 11:18:36 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59998 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752756Ab0LAQSf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Dec 2010 11:18:35 -0500
Received: by iwn35 with SMTP id 35so95634iwn.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 08:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=0aM/VDlQMPiCk9qVXDu1CmMtF5anJ/HHlYS95oO9dqo=;
        b=PiviQpNJ0J1OPipjcDgQ4C0tg8TEcXeqEV+uUAvPJtQqKWOxFNjgznZkd+zQGgB2e3
         59KLSkMDzdyF0qbzdVthawcy3BMTMuAZslY7lUbjN2kFh2XZv+ZuWFYbjc0j9dJsKuHc
         nujVkNwqxZ5pb87GCaSe/eIbJSCO2mx2IyMHw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=UI40p0Zl0Oe616b5atMUWi3Pwi1sNF0wfgy9vRWydLYC35EVYvOhfAVf1kzRgf07a0
         UkQwmJOL5ryX7TNVDAHrf5y8l8HmulWBpXbeUTxs2fDX1M0j6X1lSyaoVcuBUZy27ws6
         do7k7v9m1Kbw1cCouNprUKW7N/eaJJEMP5RQ8=
Received: by 10.231.143.202 with SMTP id w10mr9011260ibu.195.1291220314973;
 Wed, 01 Dec 2010 08:18:34 -0800 (PST)
Received: by 10.231.33.1 with HTTP; Wed, 1 Dec 2010 08:18:14 -0800 (PST)
In-Reply-To: <20101201160503.GB26120@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162543>

On Wed, Dec 1, 2010 at 11:05 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> I somewhat like this idea. =A0So let's build a full table, shall
> we? =A0The embedded dashes are meant for the command-line options
> rather than the config file.

The suggested expansions sound good to me, with one comment:

> =A0 =A0 =A0 =A0-o =A0 =A0 =A0mainline

I am not sure about this one. The 'o' originally stood for 'origin'
branch (back when git didn't use 'origin/master', or maybe I was stuck
with Cogito's mental model).

It is the branchname for CVS HEAD; it defaults to 'origin' -- given
today's conventions it should be 'master'.

I would call it cvshead.




m
--=20
=A0martin.langhoff@gmail.com
=A0martin@laptop.org -- School Server Architect
=A0- ask interesting questions
=A0- don't get distracted with shiny stuff=A0 - working code first
=A0- http://wiki.laptop.org/go/User:Martinlanghoff
