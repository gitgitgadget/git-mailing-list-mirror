From: "Sean Davis" <sdavis2@mail.nih.gov>
Subject: Re: Problems with git over http
Date: Sat, 20 Sep 2008 18:27:04 -0400
Message-ID: <264855a00809201527l1b5d99bdr85d96771d8a9efd4@mail.gmail.com>
References: <264855a00809201013h6003abbfr9bbdd20c92e9201d@mail.gmail.com>
	 <m3wsh6lck1.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 21 00:28:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhAw5-0005NK-7N
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 00:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbYITW1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Sep 2008 18:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751707AbYITW1I
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 18:27:08 -0400
Received: from hs-out-0708.google.com ([64.233.178.248]:3921 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbYITW1H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2008 18:27:07 -0400
Received: by hs-out-0708.google.com with SMTP id 4so196505hsl.5
        for <git@vger.kernel.org>; Sat, 20 Sep 2008 15:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=CK0xLhQuQB0gIlh1X6I/5Q9H2UR7AdkWU72O61hxQY4=;
        b=xl6tD5hzKwfWltaPvN4YQpSuCZeWJgCkuSvgwSxCZEDxZDsVhaYcVNSMqAqFfEMkoS
         p72rw9PQARGnNiGk7Qn33sMEOsIje2efWcUxIxScyHacfDVMKLLpP/LJMoc0jJVAr3Me
         ub1XEGRsm+M0hbL50nmW0BEgQmyBcMWq7+STk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=DClQ+QxsHZHez5r75puM9SEECN6UBGplfIj8qtUby1u7egeRoI4NqBc7OP0QqRNclR
         VT2vXNO+S6FR7xLUvU2c7Xxhi1To3YSI/r+9B0sguXp0m/v2nToYeYQfSRicAx5sOQPx
         iwuNSWrouMYvx6DL4hmcCQOkFlHfAPjcsADFA=
Received: by 10.100.173.9 with SMTP id v9mr1587921ane.82.1221949624073;
        Sat, 20 Sep 2008 15:27:04 -0700 (PDT)
Received: by 10.100.197.2 with HTTP; Sat, 20 Sep 2008 15:27:04 -0700 (PDT)
In-Reply-To: <m3wsh6lck1.fsf@localhost.localdomain>
Content-Disposition: inline
X-Google-Sender-Auth: f839515df4408a14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96374>

On Sat, Sep 20, 2008 at 5:42 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> "Sean Davis" <sdavis2@mail.nih.gov> writes:
>
>> I am new to git and trying to set up a remote repository over http.  I
>> have configured apache2 and the bare, empty repository.  Using curl, I
>> can get the file HEAD without a password (seems .netrc is correct?).
>> However, when I try to push to the repository, I get the following:
>>
>> sdavis@lestrade:/tmp/testing> git push
>> http://sdavis@watson.nci.nih.gov/git/sean_git.git/ master
>> fatal: exec http-push failed.
>> error: failed to push some refs to
>> 'http://sdavis@watson.nci.nih.gov/git/sean_git.git/'
>
> Errr... to _push_ via https you have to enable WebDAV.
> See Documentation/howto/setup-git-server-over-http.txt

WebDAV is enabled and authentication is working.

Sean
