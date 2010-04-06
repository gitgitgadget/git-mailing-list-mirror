From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v3] Documentation/urls: Rewrite to accomodate 
	<transport>::<address>
Date: Tue, 6 Apr 2010 14:14:03 +0530
Message-ID: <h2yf3271551004060144uc7ae9662s2148c11f697a2dd0@mail.gmail.com>
References: <n2rf3271551004050656vdd7d242dpeebacb25d4082f75@mail.gmail.com> 
	<7vhbnpmteu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 10:44:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz4Ob-0005PP-D9
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 10:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288Ab0DFIoZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Apr 2010 04:44:25 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53248 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092Ab0DFIoY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Apr 2010 04:44:24 -0400
Received: by gyg13 with SMTP id 13so2503880gyg.19
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 01:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=eSzX2FOEqRwpAkl5qSI1tmGNnEtgqEDgIDBTpwpLtXM=;
        b=SGggyeZnNSKnhreTWOlCK/D4/h2lPuDr53n7FXHI9W9rva4V59h2IFnhJRPu2Td0gT
         a+li/Hzv5zHIp12VPWVw5ZwXSiMvRz9HSCk76ZpAU0aoXwP4+RgfHAMvBP6B5STzb7Kn
         WPdyEB+vXArZ/vQSr5T+N0RioN692k26vS6PM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=lA3sKnVmv8P02DMHkfnF2I8IOSwQrnRZSEqtD5iGbpDNAFDUjlJ0gJ1V9YHqeG914l
         zQ5nzOljFEKyWQjwiFcrsEiqArPjF7voWlZAIVLXGGmsWkUBOc06WPub5mdE7gF5vZQu
         9q/BINSoFIupH3XkNGul5vFdv2Xd8HHlQeaF8=
Received: by 10.90.69.14 with HTTP; Tue, 6 Apr 2010 01:44:03 -0700 (PDT)
In-Reply-To: <7vhbnpmteu.fsf@alter.siamese.dyndns.org>
Received: by 10.90.5.24 with SMTP id 24mr2074949age.47.1270543463198; Tue, 06 
	Apr 2010 01:44:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144117>

Hi,

On Tue, Apr 6, 2010 at 3:52 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> I don't see why we want to single out ssh:// being the default at all=
; in
> fact I do not think it is the default in any way. =A0To "git clone" o=
r "git
> remote add" you always specify what URL to use.

Junio: Thanks for this! I was wondering about the same thing, and
waiting for someone to comment. I've addressed this, and all your
other concerns in v4.

-- Ram
