From: John Szakmeister <john@szakmeister.net>
Subject: Re: [RFC/PATCH] completion: avoid "words" as variable name for zsh portability
Date: Wed, 27 Apr 2011 05:59:05 -0400
Message-ID: <BANLkTim8ofv63uPutcMJpo1PAVHv7dwVRg@mail.gmail.com>
References: <1303867612-15975-1-git-send-email-felipe.contreras@gmail.com>
	<20110427013534.GA14286@elie>
	<7v62q0b8e0.fsf@alter.siamese.dyndns.org>
	<20110427064033.GB4226@elie>
	<BANLkTinA5hfddqpGwOBjk+2oFDpwqORrSg@mail.gmail.com>
	<20110427091140.GB14849@elie>
	<BANLkTi=3T2B=Gtyk7V_3DB3V+GkbXAaqPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stefan Haller <lists@haller-berlin.de>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Mark Lodato <lodatom@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 12:01:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF1YQ-0006x5-SJ
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 12:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757514Ab1D0KBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 06:01:00 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47579 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755947Ab1D0KA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 06:00:59 -0400
Received: by wwa36 with SMTP id 36so1698422wwa.1
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 03:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=hkdEmg6QXBSxsUOPpcVwMs3fQRPJirj1UXv9oK7evmE=;
        b=rA8IWy9IyQDVcU5GvbD8ZoLu8VIDH56rqJVmL1zibh4jC4e8nYBtINa5psDBtPr+Yt
         Ozn1s9c2BmpxbhwbhGWc6+Aixt/Xu6q+ri0TX2XJc52/ktR3yHYVndwg2J+yuWPJOhhT
         kUvnGUMxsDCuzgB6+MBMD88O/bvAb+oXYUqZs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=lz2m8La9D0e1shkhNyoto0sR1mB6d79xV7hP2Gaq9m0mwOr905tKiNMHS8DT0etZNg
         nbK7mCak3VM6pjd2KBEq0K7cjGG8FddE8w41FlRGYsCkx+bf4g7HfmIpHeD66xMz8oSd
         6YSjJ3TVZVqgtpjpsGNJ7NJ/Lr5b94K/NLEAU=
Received: by 10.216.134.207 with SMTP id s57mr1927037wei.25.1303898345830;
 Wed, 27 Apr 2011 02:59:05 -0700 (PDT)
Received: by 10.216.26.15 with HTTP; Wed, 27 Apr 2011 02:59:05 -0700 (PDT)
In-Reply-To: <BANLkTi=3T2B=Gtyk7V_3DB3V+GkbXAaqPw@mail.gmail.com>
X-Google-Sender-Auth: cXVVYZN7kv7JkuPbgjIgUDdwf4M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172211>

On Wed, Apr 27, 2011 at 5:49 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
[snip]
> Where does that 'bash_completion' file comes from? I don't have it on
> my system. Do we really need to use _get_comp_words_by_ref from there?
> Can't we have our own _get_comp_words_by_ref?

It typically comes from the bash-completion package for your system.
Depending on your distro, it may or may not be there by default.  You
can get the source from here though:
   <http://bash-completion.alioth.debian.org/>

/me goes back to lurking.

-John
