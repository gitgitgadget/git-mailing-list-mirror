From: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
Subject: Re: [PATCH] Teach/Fix pull/fetch -q/-v options
Date: Sat, 15 Nov 2008 18:28:24 +0100
Message-ID: <4ac8254d0811150928o27cb309ard62cc7bb240522bb@mail.gmail.com>
References: <1226708064-19432-1-git-send-email-tuncer.ayaz@gmail.com>
	 <7v7i7594cx.fsf@gitster.siamese.dyndns.org>
	 <4ac8254d0811141753y18567966h934a5701e168a7bd@mail.gmail.com>
	 <7v3aht8z17.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 15 18:29:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1Oxq-0001Vs-N8
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 18:29:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbYKOR20 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 12:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751781AbYKOR20
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 12:28:26 -0500
Received: from mail-gx0-f11.google.com ([209.85.217.11]:45278 "EHLO
	mail-gx0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613AbYKOR2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 12:28:25 -0500
Received: by gxk4 with SMTP id 4so1058180gxk.13
        for <git@vger.kernel.org>; Sat, 15 Nov 2008 09:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=d1XE95MV7acFSQlWF5eNUGbdm75aJ5rLTPc86srB+9g=;
        b=ODpn70PN8JuBN1sm1/hSAscBTC0PUCtarxU2sMHxFhwVNrQEC46c1/5Ltnix9e3iHS
         4tFrgD8CoL73/A9Kv1wUl4QGaSL1aFPOYAoi6OYEXexzqZl9+aBikj5cz/nQV60s66Dn
         u+5Y1FTz20RuItklpMYSsJgYhoxO9JNnsS2ZI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=N0si43wsi1vNf/xcR1LEWjpYCmczj91w0y8LjEgLekD6yOzsqY1KFVz4gZ/aDbsA5N
         RABte0UJlWdTUN4i8dTUke62SzvIc8+h+2GNFMxZrREgEWbQmp6/Kwgov96M5qFbyeyu
         Sq1u4qUut0KhwRincgIJ8MziqA14cCd55Iows=
Received: by 10.64.208.8 with SMTP id f8mr2169284qbg.44.1226770104385;
        Sat, 15 Nov 2008 09:28:24 -0800 (PST)
Received: by 10.65.231.17 with HTTP; Sat, 15 Nov 2008 09:28:24 -0800 (PST)
In-Reply-To: <7v3aht8z17.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101080>

On Sat, Nov 15, 2008 at 4:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Tuncer Ayaz" <tuncer.ayaz@gmail.com> writes:
>
>>> The approach with enum { Q, N, V } cannot express this, unfortunately.
>>>
>>> So let's do something like the attached patch, instead.
>>
>> That's ok. We should not break anything.
>>
>> Do you want me to resubmit a new patch with the changes?
>
> As long as you are happy with the suggested change, there is no need to.
> You'd need to sign-off the patch, though...
>

I forgot to add -s to my commit call this time around.
I will apply your changes and repost it with the signoff.
