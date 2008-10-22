From: "Weiwei Shu" <shuww1980@gmail.com>
Subject: Re: how to configure Git to treat certain type of ascii files as binary files
Date: Wed, 22 Oct 2008 17:35:21 -0500
Message-ID: <65d12cb10810221535l235490b9ifc39738c0cde5f4d@mail.gmail.com>
References: <65d12cb10810221458j14ef0009u679cdb0f73299d7f@mail.gmail.com>
	 <alpine.DEB.1.10.0810221511590.24463@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Thu Oct 23 00:36:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsmJf-0004NL-H4
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 00:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbYJVWfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 18:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751963AbYJVWfW
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 18:35:22 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:26039 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbYJVWfV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 18:35:21 -0400
Received: by wa-out-1112.google.com with SMTP id v27so14814wah.21
        for <git@vger.kernel.org>; Wed, 22 Oct 2008 15:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=4RV4f0XkAqYnNNJYBJGZYkykKpzK5dW8FuTgW+0U+OM=;
        b=i8vyzWc1GL2sFzrqJQjHTWnReIdEsbQYmbONIB5JdCrD/jKAmbzjgzDJra7xnmRsHj
         HBhJfqfqAVDkH19hSIJ2/wjSvAbwnzU8BCL3RPWc8tSg0dRn6MQ40jcF1y2qVY4VMGVq
         Abiku6rc42KLyjKDcaT+pwlfVp3DwfTmATtqI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=wac/UakL1w8EdSAb1dn365KAn0Cn1wmxONKCGvZloRT8uJY3oKP1n1g+fvDX1EoDVf
         UHIninuBCN4ih37qoQkP58RivJdIQzzp8xlqCfJEF5QznppkbGq9TuknpO0z25mXdn4d
         +C9WkYoG5YhWrThEw9u1kIdetyXsNfaDWZ5kk=
Received: by 10.115.32.1 with SMTP id k1mr8091661waj.124.1224714921046;
        Wed, 22 Oct 2008 15:35:21 -0700 (PDT)
Received: by 10.114.160.3 with HTTP; Wed, 22 Oct 2008 15:35:21 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.10.0810221511590.24463@asgard.lang.hm>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98922>

Thanks David.

Well, for binary files, SCM tools (like subversion) usually work as
"lock-modify-unlock" mode in which merging is not supported since the
files are not human-readable. The schematics are ascii files, but I do
not want them to be merged if I run "merge" command. Instead I'd like
Git ask me to "look-and-replace". I know Git is not meant to do this
kind of jobs. Just curious if it is able to be configured to work in
that way.



On Wed, Oct 22, 2008 at 5:13 PM,  <david@lang.hm> wrote:
> On Wed, 22 Oct 2008, Weiwei Shu wrote:
>
>> Hello everyone,
>>
>> My first post in this mailing list. Could some one direct me to some
>> document/manual pages to setup Git to treat ascii files as binary
>> files? I'm using Git to do circuit schematics (SPICE files)
>> versioning. I will not do any merging or editing stuff with external
>> editors. The only way to change it is to use schematic capture GUIs
>> (Cadence, ADS, etc). So I'd like to treat them as binary files to
>> reduce the possibilities of messing them up.
>>
>> I know it seems a little bit stupid to use Git to do such an easy job.
>> But hey, it's the most eye-catching SCM software, isn't it?
>
> unless you enable cr/lf handling git won't change ascii files.
>
> what is it that you think needs to be done differently for these files than
> for any other files?
>
> David Lang
>



-- 
Weiwei
--Hope Springs Eternal.
