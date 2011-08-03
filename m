From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v14 5/8] bisect: introduce --no-checkout support into
 porcelain.
Date: Wed, 3 Aug 2011 23:45:06 +0200
Message-ID: <20110803214506.GA6740@elie.Hillsp>
References: <1312323362-20096-1-git-send-email-jon.seymour@gmail.com>
 <1312323362-20096-6-git-send-email-jon.seymour@gmail.com>
 <7voc07ct9z.fsf@alter.siamese.dyndns.org>
 <20110803185719.GA4275@elie.Hillsp>
 <CAH3AnrrMUiWkRk0ocr4RY05qj7GU5hqSkaxy+zYJRx12o=hwNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	chriscool@tuxfamily.org, j6t@kdbg.org, jnareb@gmail.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 23:45:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QojFi-0001HH-KH
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 23:45:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755018Ab1HCVpS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Aug 2011 17:45:18 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:61753 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952Ab1HCVpQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2011 17:45:16 -0400
Received: by wwg11 with SMTP id 11so3853615wwg.1
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 14:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tkXbWrrtpPQKvZU0qQNcAVN3herLXWPuu05+PCks3yE=;
        b=hCmdeVt8lpR3iSw8GH6nCK+0Tsolw52I10r+Afpju0ntvogkqm/3yovPpk9VXqZB5W
         TBf9MtcZr7GhxCZEw8y8vi7iLiZL0F2t8P1r3LSJrnt7WJxvKVlvRLW6D+Rh3QGYM2Yp
         61FpC5qBWghtYz3r6cT92dINshx83eMTsfHx0=
Received: by 10.216.21.134 with SMTP id r6mr52775wer.5.1312407915242;
        Wed, 03 Aug 2011 14:45:15 -0700 (PDT)
Received: from elie.Hillsp (94-194-201-239.zone8.bethere.co.uk [94.194.201.239])
        by mx.google.com with ESMTPS id z83sm810155weq.20.2011.08.03.14.45.12
        (version=SSLv3 cipher=OTHER);
        Wed, 03 Aug 2011 14:45:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAH3AnrrMUiWkRk0ocr4RY05qj7GU5hqSkaxy+zYJRx12o=hwNA@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178626>

Jon Seymour wrote:
> On Thu, Aug 4, 2011 at 4:57 AM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:

>> We are very inconsistent about such usage, generally, and of course
>> POSIX is very clear about the 'z' not being needed in a three-argume=
nt
>> "test" used for string comparison. =C2=A0Is there any platform that =
is
>> usable for git (e.g., that implements "$( ... )") and has that
>> problem?
>
> Thanks. Applied.

Hm --- I was just asking a question, not meant to be rhetorical.  I
guess the question was applied, or that you inferred some patch from
it. :)
