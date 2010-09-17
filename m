From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 6/7] gitweb: group styling
Date: Fri, 17 Sep 2010 18:49:08 +0200
Message-ID: <AANLkTi=8x4JuK99W5BOfUBVUza1sUXE3e_mDOq9-wF_z@mail.gmail.com>
References: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1284629465-14798-7-git-send-email-giuseppe.bilotta@gmail.com> <201009171826.15454.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 17 18:49:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Owe8K-0006nM-AE
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 18:49:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755523Ab0IQQta convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Sep 2010 12:49:30 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:49850 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755465Ab0IQQt3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Sep 2010 12:49:29 -0400
Received: by gwj17 with SMTP id 17so790303gwj.19
        for <git@vger.kernel.org>; Fri, 17 Sep 2010 09:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=HBvzEDchyzv/uEwMi33lLd4Yk1g1gs2seY+7oO+HE1Y=;
        b=WKhAwSshuX5+zfj0urAg+gC9nz80UJ3ZUee0KSTENQrOb3MbJKw0LGN/2R6GP66CCN
         0VRT2lgihs4Zjt6x00bb4yJTqdLRUcXdq8Rb0zZyI7pQ8wHukf05CQzc5Et25FcDZiL3
         48pAj09OBRqQC9L7GVPNtQB14uXcaSNEzgR/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=G7dEwJw6qpaAXkWvEmLLs5SyE9cFNFLajtD8VyHqav74aau28/D1mioILlZ8G/06IZ
         6KmtYfCZ6v91s5a1PfAoQVWCduG3fdRGHirVHv750qIr0d9p8yuDYBvSYZ9+LDvh9xN4
         DUSfE4HTC9D1D3Xe0nPfMnTIVjxzHyttTreKY=
Received: by 10.150.54.13 with SMTP id c13mr5982442yba.235.1284742168380; Fri,
 17 Sep 2010 09:49:28 -0700 (PDT)
Received: by 10.231.150.202 with HTTP; Fri, 17 Sep 2010 09:49:08 -0700 (PDT)
In-Reply-To: <201009171826.15454.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156398>

2010/9/17 Jakub Narebski <jnareb@gmail.com>:
> On Thu, 16 Sep 2010, Giuseppe Bilotta wrote:
>
>> +div.group {
>> + =A0 =A0 margin: .5em;
>> + =A0 =A0 border: 1px solid #d9d8d1;
>> + =A0 =A0 display: inline-block;
>
> Is this 'display: inline-block;' really necessary? =A0I think we can =
do
> without it (and I've heard that there are problems with it, but those
> might not matter in layout used by gitweb).
>
> Otherwise nice.
>
>> +}

I'm not aware of problems with inline-block (I can check
quirksmode.org though if necessary), but without it the divs will be
as large as the _containing_ block, meaning that each div will be
ultimately as large as the page. By using inline-block, instead, they
become as large as the _contained_ stuff, thus fitting the inner
table.

--=20
Giuseppe "Oblomov" Bilotta
