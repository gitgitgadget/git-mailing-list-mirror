From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [regression?] "git status -a" reports modified for empty submodule directory
Date: Tue, 22 Apr 2008 19:04:05 +0800
Message-ID: <46dff0320804220404u40dd3351tefacf775d4da19ef@mail.gmail.com>
References: <46dff0320804220401h26d2f2ebg1748a4a310acc0f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 22 13:04:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoGIx-0007cu-Ii
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 13:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759657AbYDVLEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 07:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758915AbYDVLEI
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 07:04:08 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:24971 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756683AbYDVLEH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 07:04:07 -0400
Received: by an-out-0708.google.com with SMTP id d31so587193and.103
        for <git@vger.kernel.org>; Tue, 22 Apr 2008 04:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=2naMo9nCwZ6QA831vuz9dvbhSbfQ4rI0EOfRamOePnw=;
        b=LEmKS+Zr4gMJqTS9a4pGFI3p3XuQORygQTtzsWSZnobwljp3dsf/qHp7Xjv9fGXXKHNUBVTkbpX/5BvPAqSMSO0L+/kTbWabZFsO/EM2svKk0tTYLaSNF2fh5OxwWmL1FXBn6xpAbJrhbEaAGsCs4AGQxxumvQQ7KBWflUYVmV8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J3NNkO5ksosQiBBMHD1NQUwJXlCSynqGwugAQYqzxoqgq81iKL7U3f7saAsPnYTk1aDcxBCVdSLmXrV7aM+LBV1xeJaHDj2ATgMhx2F/r3sAMsiSRthxzSiO86T2G8ANxUEUb0Exhrjh6HaHuRKdpCPZe9q/a8YVZ8kBzIslc4Q=
Received: by 10.100.91.17 with SMTP id o17mr87642anb.90.1208862246321;
        Tue, 22 Apr 2008 04:04:06 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Tue, 22 Apr 2008 04:04:05 -0700 (PDT)
In-Reply-To: <46dff0320804220401h26d2f2ebg1748a4a310acc0f5@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80101>

On Tue, Apr 22, 2008 at 7:01 PM, Ping Yin <pkufranky@gmail.com> wrote:
> # create a super project super
>  $ mkdir super && cd super && git init
>  $ touch foo && git add foo && git commit -m "add foo"
>
>  # create a sub project sub
>  $ mkdir sub && cd sub && git init
>  $ touch bar && git add bar && git commit -m "add bar"
>
>  # add sub project to super project
>  $ cd ..
>  $ git add sub && git commit -m 'add sub'
>
>  # remote contents of subproject

s/remote/remove/

>  --
>  Ping Yin
>



-- 
Ping Yin
