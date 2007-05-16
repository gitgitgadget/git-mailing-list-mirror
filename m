From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: Losing branches (whee, data loss)
Date: Wed, 16 May 2007 07:48:07 +0200
Message-ID: <8c5c35580705152248w254e4201w65da1e1ad229f6ee@mail.gmail.com>
References: <464A940C.3080906@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jeff Garzik" <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Wed May 16 07:48:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoCNW-0003Kt-65
	for gcvg-git@gmane.org; Wed, 16 May 2007 07:48:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761165AbXEPFsK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 01:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762292AbXEPFsJ
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 01:48:09 -0400
Received: from nz-out-0506.google.com ([64.233.162.231]:24043 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761165AbXEPFsI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 01:48:08 -0400
Received: by nz-out-0506.google.com with SMTP id r28so443974nza
        for <git@vger.kernel.org>; Tue, 15 May 2007 22:48:08 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kFiR+n7oE/louEuTM2JYnRVr9ywbUQSJIUzNKuYfip8QkS9Apw2LoTKCQDpXd+dZL4mKFYH1JXxol/J0ZCh0ngr9dnM1AEpFAFFtrykX5SI8ia5UZ6Ax4lYmVtOXbBr4i7hM9sq095QsTtcyMLG8xsM+7qoZAX5B3DvA0MawOpU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=My8px0uzKQMb3BEaUK6CaiXerKN9U73arfs/p/KGrgFIs7YipLbuPdVnAj26T5oEjauwojn6w+6OAYfC2Gyif9564RosOrabFourty6nwVn3mNDLO0H8qZdkpIMrjrKOQJSDL6uQv0Z0R+lVbQHLpeZW+ci+UoRSvOimft14t5E=
Received: by 10.114.89.1 with SMTP id m1mr1984499wab.1179294487638;
        Tue, 15 May 2007 22:48:07 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Tue, 15 May 2007 22:48:07 -0700 (PDT)
In-Reply-To: <464A940C.3080906@garzik.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47411>

On 5/16/07, Jeff Garzik <jeff@garzik.org> wrote:
> [jgarzik@pretzel libata-dev]$ git branch -m upstream-fixes tmp
> error: Could not open config file!
> fatal: Branch rename failed

This should have been fixed in v1.5.1.1, what version do you run?


> [jgarzik@pretzel libata-dev]$ git-branch -m upstream-fixes tmp
> fatal: A branch named 'tmp' already exists.
>
> [jgarzik@pretzel libata-dev]$ git branch -D tmp
> Deleted branch tmp.

Could you try to run "git log -g" and see if it finds your lost branch?


-- 
larsh
