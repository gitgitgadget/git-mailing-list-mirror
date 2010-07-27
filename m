From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv3] Updated patch series for providing mechanism to list  available repositories
Date: Tue, 27 Jul 2010 02:02:38 -0700 (PDT)
Message-ID: <m3sk35l2n6.fsf@localhost.localdomain>
References: <1279725355-23016-1-git-send-email-gdb@mit.edu>
	<AANLkTin+EMYHrr11Dba9Mob+b_Dar_cedWmTsDF=AHFt@mail.gmail.com>
	<AANLkTilSqePFPkteFd7DBgmdhqJHfUDuW_qhkbWVVb3Y@mail.gmail.com>
	<AANLkTikG0e5dtGgMe03s=PpG793B-MkrGjdGa0LuZ5zH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Greg Brockman <gdb@MIT.EDU>
X-From: git-owner@vger.kernel.org Tue Jul 27 11:02:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odg3l-0005PJ-AK
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 11:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754553Ab0G0JCn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 05:02:43 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35774 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753811Ab0G0JCm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 05:02:42 -0400
Received: by bwz1 with SMTP id 1so3180893bwz.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 02:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=Y/NrmiukWl3jfO8T5OpBQTiw2XddQgh+WUxSzmvEXQ4=;
        b=wWUc28CGJBukLEdXlKXflhhZWwD+cKKlutwQSSFKCxW1HBXSqO+MjLNiR2Bv87mW1b
         QZd+COXbI5MUbzvYaXK+SNZW/k2/ydChCSIjm6syDYg6fmqgNYbTLXUvjXXbzPO7UDcR
         eqKL/FKyI0AzNdYQCBLt+QRIxXcmNrz3ztHWA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=W6YDFzpbknoA+Ye/+v6/VvLusB/WA9isNru8wPY83oc0QUfS4iskrh2U1w3Fi/CSL9
         x9u8oVcJRlyrFWl+BdMIMjpo6QS7p2/HMR+Mr2bdtbKSuMr7XLnJhpjkiBE3pKcruYMS
         9fHQFUPCrAatgsMgJsPPzjJbbBT6kbEqhKDh0=
Received: by 10.204.83.167 with SMTP id f39mr6229360bkl.151.1280221360719;
        Tue, 27 Jul 2010 02:02:40 -0700 (PDT)
Received: from localhost.localdomain (abwn25.neoplus.adsl.tpnet.pl [83.8.237.25])
        by mx.google.com with ESMTPS id 24sm3610944bkr.7.2010.07.27.02.02.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jul 2010 02:02:38 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o6R91kvC026364;
	Tue, 27 Jul 2010 11:01:52 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o6R91JHp026353;
	Tue, 27 Jul 2010 11:01:19 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTikG0e5dtGgMe03s=PpG793B-MkrGjdGa0LuZ5zH@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151920>

Greg Brockman <gdb@MIT.EDU> writes:

> > It would probably help if you re-send the entire thing again.
>
> Ok, will do so shortly.
> 
> > It also seems to have an unaddressed comment
> > (<7vlj96m4mc.fsf@alter.siamese.dyndns.org> from Junio).
>
> Yep, my patch series actually does incorporate that comment.  I didn't
> respond to that explicitly because I didn't want to spam the list, but
> in the future I'll be sure to respond to comments... I can imagine it
> makes things much easier for
> people-who-are-not-the-one-writing-the-patch to follow.

There are two possible solutions to providing comments about patch (I
think they are covered in Documentation/SubmittingPatches).

First is reply to email like you would usually do, and below some
delimiter, e.g. the "scissors" line i.e. '-- >8 --' put the patch
itself.  You might need to start it with 'Subject:' line if the title
of the patch is different from the subject of email.

Second, which I think would be more appropriate in your situation, is
to put comments about patch, for example how you did address the
comments, and/or how the patch changed from previous version in the
area between '---' delimiter line, and diffstat.  See for example
http://permalink.gmane.org/gmane.comp.version-control.git/151703

HTH
-- 
Jakub Narebski
Poland
ShadeHawk on #git
