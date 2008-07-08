From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: GiT and CentOS 5.2
Date: Tue, 8 Jul 2008 14:51:17 -0400
Message-ID: <76718490807081151w7c06bfb5kd0ddfe8e2729dbb5@mail.gmail.com>
References: <49523.216.185.71.22.1215539200.squirrel@webmail.harte-lyne.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "James B. Byrne" <byrnejb@harte-lyne.ca>
X-From: git-owner@vger.kernel.org Tue Jul 08 20:52:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGIIX-0006kQ-7u
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 20:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756233AbYGHSvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 14:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756252AbYGHSvV
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 14:51:21 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:16849 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756174AbYGHSvT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 14:51:19 -0400
Received: by yx-out-2324.google.com with SMTP id 8so663815yxm.1
        for <git@vger.kernel.org>; Tue, 08 Jul 2008 11:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=c9yQE+H+PxkoL89/ClzLUo0DjikuwWO3hDBMSfpss8c=;
        b=LF9Dvi+XGK9XWGk6M8bHE4kjGyxRnQbBl/UEgcEelVL6L6w3d2vjIX+gWe7knzN+Kf
         w0JvDDlw0mw4qpGBRuZAjQAB/mx05LOOqyDhnQb6+tfQH8hboTNEYBaQQXuTPY7Tn4vO
         6vpRjdNYMb+6foZdaoM0ScUJoAc0NmOyiZJMw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=aFIKjVJPLrSRJUcnYH7ko+SKeNR4yE5gdwAhTe4u0Uvrd0/bXIq/yC/dD7Fxjh62mD
         Fpz2aRNBADfyd6bY0TqBBAVlnNQSC2kqFlD70Nn3DG2uHCcCijlZ4L25P/MejoT2Axbv
         IBbnfz6wJjAJz9rQrnQOBXnpJAkSDGHmfHSd0=
Received: by 10.114.183.20 with SMTP id g20mr8314008waf.77.1215543077644;
        Tue, 08 Jul 2008 11:51:17 -0700 (PDT)
Received: by 10.114.14.19 with HTTP; Tue, 8 Jul 2008 11:51:17 -0700 (PDT)
In-Reply-To: <49523.216.185.71.22.1215539200.squirrel@webmail.harte-lyne.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87783>

On Tue, Jul 8, 2008 at 1:46 PM, James B. Byrne <byrnejb@harte-lyne.ca> wrote:
> OS = CentOS-5.2
> perl = 5.8.8
>
> I get git from the yum repository at kernel.org.  Up until the most recent
> update I had no problems.  Now I am getting these dependency errors:
>
> Error: Missing Dependency: libcurl.so.4 is needed by package git
> Error: Missing Dependency: perl(:MODULE_COMPAT_5.10.0) is needed by
> package perl-Git
> Error: Missing Dependency: libc.so.6(GLIBC_2.7) is needed by package git
> Error: Missing Dependency: libexpat.so.1 is needed by package git
> Error: Missing Dependency: libcrypto.so.7 is needed by package git
>
>
> Are these dependencies actually meaningful?  By that I mean, are there
> features used in the latest release of GiT that depend upon features of
> GLIBC 2.7 that are not part of glibc-2.5?  Similarly, are there features
> of curl used in the latest git that are not present or work differently in
> curl 7.15.2?  Ditto for OpenSSL and libxpat.
>
> I would like to stay current with git but I cannot if these dependencies
> are actually required.

Junio switched to FC9 for building the git RPMs on kernel.org recently.

Probably the best thing to do if you want a CentOS 5.x RPM is to grab
the source tgz and build the RPM yourself. :-(

There are quite a few build-time dependencies, but those are easy to
take care of with yum.

j.
