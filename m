From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: git update index question
Date: Wed, 17 Oct 2007 15:30:21 +0200
Message-ID: <8c5c35580710170630y6ab3a6aehcbbcf9b7feb1bb6d@mail.gmail.com>
References: <4715E2AB.4030900@filmaura.com>
	 <8c5c35580710170549n25c8b692w2466091ea56d641e@mail.gmail.com>
	 <47160706.2000706@filmaura.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Gonzalo Garramuno" <gga@filmaura.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 15:30:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii8yp-0000rE-J9
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 15:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756767AbXJQNaY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 09:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756274AbXJQNaY
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 09:30:24 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:10384 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756049AbXJQNaX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 09:30:23 -0400
Received: by wr-out-0506.google.com with SMTP id 36so1310135wra
        for <git@vger.kernel.org>; Wed, 17 Oct 2007 06:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=h/K+SLXUBO7REnV2R+u1zJfrUzx+SApgOn5sMau1H7g=;
        b=VMBzHQkqh2tpYNPEYH5hqSHkQ3tto85wjQ0bdBRZvIRl6cDpAf6iT72SW+e7n509Gj4xSi0umAB8IuCnqzsgH0JJUNGcgnnn3NpWa9OO3t/e4jUlneEGV1CFe0cCpg28+n+RAobhUPogpMwv1VH96yZyOrtxaAQuWOZ8R1+IZho=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VAvTiNUpGb7icVEK7nlVm6AAO7OCvF2oEwwCbzE9wqHVWxUFQiOnjoqu+HVeNsy0fK1wkYIkvAVVhceneKGAP5TB7uamtJ4BsCvpAltpSpMfCciruR5QYkZa0JMIl0PbScWTw7xl2GQP4gZLKCQE+bDSgxIct94uChOCNigvWUA=
Received: by 10.114.60.19 with SMTP id i19mr616960waa.1192627821598;
        Wed, 17 Oct 2007 06:30:21 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Wed, 17 Oct 2007 06:30:21 -0700 (PDT)
In-Reply-To: <47160706.2000706@filmaura.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61376>

On 10/17/07, Gonzalo Garramuno <gga@filmaura.com> wrote:
> I had incorrectly done a chmod a+x on the pre-commit hook when all my
> previous commits had not been using it, so I think the pre-commit was
> actually catching not my new fix but what was already in the repository.

That sounds wrong: the (default) pre-commit hook only verifies the
_new_ content, not the content in HEAD.  Is there any chance your
.git/hooks/pre-commit script has been tampered with?

--
larsh
