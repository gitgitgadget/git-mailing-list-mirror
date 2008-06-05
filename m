From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT PATCH 2/5] Rename Repository.head to Repository.head_ref
Date: Thu, 5 Jun 2008 12:49:15 +0100
Message-ID: <b0943d9e0806050449s4b55d06cu1b7701a562c7a6ba@mail.gmail.com>
References: <20080604210655.32531.82580.stgit@localhost.localdomain>
	 <20080604211325.32531.84968.stgit@localhost.localdomain>
	 <20080605064633.GB23209@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 13:50:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4Dyt-0001FS-Gj
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 13:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755574AbYFELtT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jun 2008 07:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755560AbYFELtT
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 07:49:19 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:33139 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755359AbYFELtS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jun 2008 07:49:18 -0400
Received: by rv-out-0506.google.com with SMTP id l9so676191rvb.1
        for <git@vger.kernel.org>; Thu, 05 Jun 2008 04:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=XcQsxa9wdIsYgonoxKvVheqA5iKi830W0Dj+HI3dv4g=;
        b=jQenfYeWqlVNnZW+xdmIQ15jk/WDBFlOUwuBE7tcuOpyv824U1CgoCpVHPGgYhGzfh
         Hc9miVUnCSbb2cnGhpG1jVGL6CJ23ke+EZFMbiFgkFOpWQQ3x2XjKPs1hBnOmaUNhg+c
         hAYebWK5awdeyMfCuT/kAOgDkPoX2ivHQ/8wU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=QfJOBWr3aIHOaJWDS4nz7TJhy7YRjcUjX0i7M8vUE5vbAT4XOa2/37+c48rHwQ5LB0
         hDOEoIFzZY6EHfB8X7IuE/fJTfHABfQRPgrcx263WOjmDbbEqCB+jAtr3WCpFCcEa/KR
         9Et3E6kv/CMn3N9BBK4Pj/HjGjlia792kTzvU=
Received: by 10.114.89.1 with SMTP id m1mr1303544wab.146.1212666555827;
        Thu, 05 Jun 2008 04:49:15 -0700 (PDT)
Received: by 10.114.171.16 with HTTP; Thu, 5 Jun 2008 04:49:15 -0700 (PDT)
In-Reply-To: <20080605064633.GB23209@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83908>

2008/6/5 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-06-04 22:13:25 +0100, Catalin Marinas wrote:
>
>> This is to avoid confusion with the Stack.head function which
>> returns a commit object rather than a file name.
>
> A much better name. But you don't fix any callers -- aren't there any=
?

There was actually another caller but missed it since I worked on a
bigger initially. The stack.Repository.current_branch uses it but this
was later moved to git.Repository.current_branch_name. I'll add in
case we ever need to bisect.

--=20
Catalin
