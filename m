From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/6] revert: decouple sequencer actions from builtin
 commands
Date: Sun, 8 Jan 2012 14:09:10 -0600
Message-ID: <20120108200910.GK1942@burratino>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326025653-11922-3-git-send-email-artagnon@gmail.com>
 <20120108193454.GG1942@burratino>
 <CALkWK0kHn+SDaeRHa8bUHWvOEVkr01sVDzvnw9E+-Nne2cii1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 08 21:04:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjyyR-0007DA-3T
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 21:04:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754479Ab2AHUEG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jan 2012 15:04:06 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48123 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754449Ab2AHUEE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Jan 2012 15:04:04 -0500
Received: by iaeh11 with SMTP id h11so5684138iae.19
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 12:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WlxMe89FpIQP+zM6akkz0CjMqFwrNx4CijSQhRx0lwo=;
        b=BHHTzoVq7DxrbOta8D6uH5CArAtLW/E2CT/ugR8YzhF6QGDH6sCtk1ik3SH/bCR6Bk
         DtPqRNLhc985F2L1Wrdz9nR2HdHQGvwINhUnR78dtUFwE1Dg8QQps+VF/0YYgVoimPam
         8TOs2+4xnVPfj2yIhbIUzbVs5oev2PI6zLVmk=
Received: by 10.50.186.226 with SMTP id fn2mr16269145igc.25.1326053043153;
        Sun, 08 Jan 2012 12:04:03 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id h9sm241926721ibh.11.2012.01.08.12.04.02
        (version=SSLv3 cipher=OTHER);
        Sun, 08 Jan 2012 12:04:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALkWK0kHn+SDaeRHa8bUHWvOEVkr01sVDzvnw9E+-Nne2cii1Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188123>

Ramkumar Ramachandra wrote:
> Jonathan Nieder wrote:

>> So what change does the patch actually make? =C2=A0Is this a renamin=
g?
>
> Yes, it renames "action" to "command" where appropriate.

Wouldn't a simple renaming have a diffstat with the same number of adde=
d
and removed lines?
