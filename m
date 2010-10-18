From: Tor Arntsen <tor@spacetec.no>
Subject: Re: Git Stash stages files if there is a conflict
Date: Mon, 18 Oct 2010 11:33:36 +0200
Message-ID: <AANLkTimrVgegd4mHsEbhs3O78T=zkF4Ns7F2LMEKjm=C@mail.gmail.com>
References: <loom.20101015T220924-952@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pretty Boy Floyd <boxerab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 11:33:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7m6A-0006RI-Vw
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 11:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754297Ab0JRJdi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Oct 2010 05:33:38 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:63166 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916Ab0JRJdh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Oct 2010 05:33:37 -0400
Received: by qwa26 with SMTP id 26so378277qwa.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 02:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=Mn3LeNep+6HcFEeQyZ1WDlJW/+TzAuhQkM9J4B4gtac=;
        b=Rov6lW7OZgzE1p52XL0yQPlMS5D2JiIy+eYfc6ASrPBFCEdHsfifkL4piod9mL5KQZ
         KWfcsSaQXnyAc8brwziQ/4PKG/5vfevV+lSpJtnhJ9KjBoANaRchJbmozxv1hv+lhAz0
         WhTGGQyXVST95pJ24frij3Jw6DQvPvfUMoPM8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=mtWJxEWQ3xcECOjTEn6F3lR/mTyfwOkYrommYR+dhtoeDZak3AZpogj82euZrq3XXo
         ItQ8OFCfYWf+yhzBnNdhCb4LCVlaMreyACFBgoPxpCXvSGl9yztiolSRIuc4QVjoHLVf
         gi+OHLCvw8Exs0S0okE8QBQtUndcKAhxSee6E=
Received: by 10.229.236.8 with SMTP id ki8mr3661485qcb.102.1287394416646; Mon,
 18 Oct 2010 02:33:36 -0700 (PDT)
Received: by 10.229.69.210 with HTTP; Mon, 18 Oct 2010 02:33:36 -0700 (PDT)
In-Reply-To: <loom.20101015T220924-952@post.gmane.org>
X-Google-Sender-Auth: VtAgK9LqQW7umdW4GE_tv5T9RmA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159244>

On Fri, Oct 15, 2010 at 22:13, Pretty Boy Floyd <boxerab@gmail.com> wro=
te:
> Hello!
>
> I am running msysgit 1.7.3.1. =A0If I run stash apply, and there is a=
 conflict,
> all of my stash changes get staged. Is this the correct behaviour? I =
found it a
> little surprising.

I have no answer to the above, just noting that I observed exactly the
same yesterday (git 1.7.1) and was a little surprised too. Not that it
created any problems as such, just raised eyebrows.

[..]

-Tor
