From: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Subject: Re: [PATCH] date.c: print "1 second ago", not "1 seconds ago"
Date: Wed, 21 Apr 2010 08:28:47 +0200
Message-ID: <i2jc4c738cd1004202328hb58859f8ze9eb1858f5493c66@mail.gmail.com>
References: <1271827860-20947-1-git-send-email-sunny@sunbase.org>
	 <4BCE977D.9040700@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Apr 21 08:28:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4TQf-0001Pz-Cz
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 08:28:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881Ab0DUG2u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Apr 2010 02:28:50 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:62548 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557Ab0DUG2s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Apr 2010 02:28:48 -0400
Received: by qyk9 with SMTP id 9so8801828qyk.1
        for <git@vger.kernel.org>; Tue, 20 Apr 2010 23:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:received:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=5LBOCE72t9+qHN0YEKUtRlejqPrOBIm0JKXDk/QvTdM=;
        b=kv1sDrnR6NVcj6qAZZo4BxZ31L91QXEz9A3ZsRr6uyHzDT0hCCMJD+QqeJo+hZiLFC
         E3wDym2UVV2Q2lMmJFSESuAvaDl/y31RrFqrCTcvoPV/NTu6KXQ/9i22DxQEpzV+hGGZ
         c6VwDsQMG1VoxelvxCnk6JRzkLmWD2gkYIWhk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=sc5MUVdBK/coyNLwk87qaDPFin1xPAAOzLBIBNEKqjj/N2ilb+3bDNI/809KJaQMHL
         t8ac2dGPdFsabqp9FQ5CIe6yoPvfgjr/uqwrGGL7uPGE/1tqbUSUBfuWkiJ/oeH58R4c
         qhb6yUQUWjZY1pcUaMYrJig24UREYy+/90mYc=
Received: by 10.229.216.71 with HTTP; Tue, 20 Apr 2010 23:28:47 -0700 (PDT)
In-Reply-To: <4BCE977D.9040700@viscovery.net>
X-Google-Sender-Auth: 39bb92aab8e40565
Received: by 10.229.211.210 with SMTP id gp18mr3631415qcb.31.1271831327982; 
	Tue, 20 Apr 2010 23:28:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145408>

On 21 April 2010 08:13, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 4/21/2010 7:31, schrieb =C3=98yvind A. Holm:
>> When using --date=3Drelative, print "1 second ago" instead of "1 sec=
onds
>> ago".
>
> Why do you care only about about "1 seconds", but not "1 minutes", "1
> hours", etc? I mean, "1 seconds ago" is the most unlikely case of the=
m all
> that will happen in practice...

It will never show "1 minute", "1 hour", etc. Only

  - "89 minutes" =E2=86=92 "2 hours"
  - "35 hours" =E2=86=92 "2 days"
  - "13 days" =E2=86=92 "2 weeks"

and so on. Seconds is the only thing left to fix.

Cheers,
=C3=98yvind A. Holm
(sunny256)
