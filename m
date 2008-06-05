From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT PATCH 2/5] Rename Repository.head to Repository.head_ref
Date: Thu, 5 Jun 2008 13:06:39 +0100
Message-ID: <b0943d9e0806050506u25c0441cy86caaec708ba838f@mail.gmail.com>
References: <20080604210655.32531.82580.stgit@localhost.localdomain>
	 <20080604211325.32531.84968.stgit@localhost.localdomain>
	 <20080605064633.GB23209@diana.vm.bytemark.co.uk>
	 <b0943d9e0806050449s4b55d06cu1b7701a562c7a6ba@mail.gmail.com>
	 <20080605115820.GA27430@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 14:07:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4EFh-0007fj-KS
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 14:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756231AbYFEMGl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jun 2008 08:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756157AbYFEMGk
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 08:06:40 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:2433 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755677AbYFEMGk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jun 2008 08:06:40 -0400
Received: by py-out-1112.google.com with SMTP id p76so449199pyb.10
        for <git@vger.kernel.org>; Thu, 05 Jun 2008 05:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=DBNv1/qti7RVdqqG6jY1hPiZjbBcBSqz5ysm4NUqEJ0=;
        b=u2eERP4honA/yAY7MyCPH24KRYaPIObQspLGpSC/cK6AwHNwQnyPj7n6CFHryeAsNy
         nn04U1zNdS9T5xB/d8tiSrivIZeUpHsCFB89b+uSF+LimyioFuRdGHVtXqI6cfqIzzhi
         0h2aCz2pLtAEf71S3rHn93Px1K51UQnAjXPww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=q+NfO5zXCWI5t0tmT1CW3KuuqSc+J9iGsXBq51kvPmEeptavjGhFHHHTBr9VGjb7MB
         f5SvkVlJ0Nx7/L8jeMMsRK4Apd9g7U+HkbMDYWFlQ+ogHjOmM2YQWS5+Q/GVvnqifCt8
         taWslvQx4v+y4ZAoxNkXGRGr5C1yJFfwQ6LFo=
Received: by 10.115.14.1 with SMTP id r1mr1294627wai.206.1212667599165;
        Thu, 05 Jun 2008 05:06:39 -0700 (PDT)
Received: by 10.114.171.16 with HTTP; Thu, 5 Jun 2008 05:06:39 -0700 (PDT)
In-Reply-To: <20080605115820.GA27430@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83912>

2008/6/5 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-06-05 12:49:15 +0100, Catalin Marinas wrote:
> ( Did you run the test suite on your patches? I always do something
>  like this (untested -- I have this command in my bash history on
>  another computer)
>
>    $ stg pop -a
>    $ while make test; do stg push || break; done
>
>  before sending out patches. It takes a few minutes per patch, but
>  it's fully automatic. )

Not really. It would be good to have a Makefile target for this,
something like "test_patches". I'll add it.

--=20
Catalin
