From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: 'show' pretty %B without a diff
Date: Tue, 21 Dec 2010 15:27:52 -0500
Message-ID: <AANLkTi=BJ0NdKrANuXKObNQJbchqdSUhpnttsdU_NnQe@mail.gmail.com>
References: <20101220073842.GC10354@external.screwed.box> <7vmxo0ddbm.fsf@alter.siamese.dyndns.org>
 <20101220111214.GD10354@external.screwed.box> <7v4oa8cobn.fsf@alter.siamese.dyndns.org>
 <20101221104641.GA8600@external.screwed.box> <m38vzjl1yr.fsf@localhost.localdomain>
 <20101221180459.GA25812@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Peter Vereshagin <peter@vereshagin.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 21 21:28:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PV8ol-0000Rz-DQ
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 21:28:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752970Ab0LUU2O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Dec 2010 15:28:14 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:46890 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006Ab0LUU2N convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Dec 2010 15:28:13 -0500
Received: by qwa26 with SMTP id 26so4394387qwa.19
        for <git@vger.kernel.org>; Tue, 21 Dec 2010 12:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ysVUnRf4VIj09a00RIK4T72qFI+Y0zlJ8tOqvrg5aNY=;
        b=EXH7ZG7uf1o2ySQCqqpWFq7qpBQD46D/kBhjxnqHY2aTi1ajK6/4DoshkBFhDAS0U9
         1fCf2tvST0OjthPna5UdhXXTCOLdvFuj6ZU2XQ8TZjydHQ9VGsWUmxNp/axBFiP7dS4K
         V3KEvBqY6k1/wKmq2P0IDTnHdB4FtSe6XJZyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=HQ2sO3S1mq//WCJ8PIZgY/+Q78OuVg1e+20oFPDCEoBpiXymFRWWVsdpvc+2wKYSfg
         8VtNo4zosT49DHI1TK7+MdVf50NqQwTQWdAwhusSuxXMZb3H58pFS/R1y+Ia0SqtKbnN
         wBTSCAiH/qryQoCevJlox9rij0HLLEvv5bdA0=
Received: by 10.224.67.208 with SMTP id s16mr3092166qai.322.1292963292881;
 Tue, 21 Dec 2010 12:28:12 -0800 (PST)
Received: by 10.220.203.2 with HTTP; Tue, 21 Dec 2010 12:27:52 -0800 (PST)
In-Reply-To: <20101221180459.GA25812@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164053>

On Tue, Dec 21, 2010 at 1:04 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Maybe it would be worth adding a plumbing example under the EXAMPLES
> for each porcelain?

Since porcelain went to C, one thing I often do is checkout really old
versions of git to see exactly what the shell version of a particular
command did .

That way, I get a much better understanding of how a certain action is
done at the plumbing level; complement that with the documentation for
reference, and I'm 99% done.

Maybe that helps someone .

cheers,



m
--=20
=A0martin.langhoff@gmail.com
=A0martin@laptop.org -- School Server Architect
=A0- ask interesting questions
=A0- don't get distracted with shiny stuff=A0 - working code first
=A0- http://wiki.laptop.org/go/User:Martinlanghoff
