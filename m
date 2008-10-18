From: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
Subject: Re: [Q] submitting patches from gmail
Date: Sat, 18 Oct 2008 14:16:43 +0200
Message-ID: <4ac8254d0810180516h56633ed3q8377ddbbbf316bab@mail.gmail.com>
References: <ee2a733e0810180508m466f3ea1i9c63b47177f6e12d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: SLONIK.AZ@gmail.com
X-From: git-owner@vger.kernel.org Sat Oct 18 14:19:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrAlo-0002qt-Up
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 14:19:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbYJRMQq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 08:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbYJRMQq
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 08:16:46 -0400
Received: from hs-out-0708.google.com ([64.233.178.243]:20559 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496AbYJRMQp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 08:16:45 -0400
Received: by hs-out-0708.google.com with SMTP id 4so374747hsl.5
        for <git@vger.kernel.org>; Sat, 18 Oct 2008 05:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Mti1BpI2Ph5Uc5XiRkC23IAhBX7qdjsiw/5YDiJ64PI=;
        b=sUCJ0yThysxqQjLXrZZ4WBI9KpCpnbCMau2YwiwKGfPz9doGRnyefYrdTXVodmowYv
         ykn1a9L3qkCVniMMlW4gOB15sQ0ackkV85jxgU26RVKhJx/4ZJwgJHvyaVjcGbE+NO5c
         uJqckYPhpeYOOZeuEHCBdujnRDpcWRourUo80=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=cicf1R8z4zBGfY7oxvb0ZoSBdmmEHUrM44c6+XFaUEf+i1WfzuEj76Rfc2xOXp1rTX
         suXXFRcUd4YOhKrU6pl0QXxY2fSMjQ+/Te80mNZ25QOkxX3/c9lSDnDZ06ulyXBp5C9e
         WIfPEbDdrK5Z+hJ+B3ZCSsvYGXwYby+hM8p3I=
Received: by 10.65.197.16 with SMTP id z16mr2345156qbp.97.1224332203977;
        Sat, 18 Oct 2008 05:16:43 -0700 (PDT)
Received: by 10.65.114.10 with HTTP; Sat, 18 Oct 2008 05:16:43 -0700 (PDT)
In-Reply-To: <ee2a733e0810180508m466f3ea1i9c63b47177f6e12d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98542>

On Sat, Oct 18, 2008 at 2:08 PM, Leo Razoumov <slonik.az@gmail.com> wrote:
> Hi Everyone,
> I wonder what is the preferred way to submit patches from a gmail account.
> Google mail auto wraps long lines and there is no way to change this setting.
> Safe way would be to use attachments. Are they allowed on git mailing list?

I do use git send-mail with msmtp as the SMTP client and smtp.gmail.com as
the host. If you are able to go that route it would solve your problem.
