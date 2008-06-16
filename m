From: "Alf Clement" <alf.clement@gmail.com>
Subject: Re: current repository hash
Date: Mon, 16 Jun 2008 20:30:16 +0200
Message-ID: <556d90580806161130g62269318i46f00e5c7f79b7d9@mail.gmail.com>
References: <556d90580806160451g36daefb6o48b93b92589211bf@mail.gmail.com>
	 <8aa486160806160515p751b2af4j2b0db6db7a9ad482@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:31:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8JU5-0006M0-0f
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 20:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971AbYFPSaT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Jun 2008 14:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbYFPSaT
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 14:30:19 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:49930 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbYFPSaS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jun 2008 14:30:18 -0400
Received: by fg-out-1718.google.com with SMTP id 19so3333209fgg.17
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 11:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=+VkPdy//7YACFF+oU9v8Q37xIa+R515QcSsno/TUtMM=;
        b=M9te9rNzaltD3++5AP5iLzmeDP3QJA89/3KFq/JNXIvMJ8URJhAljjZAUYEYhAvyPX
         2FK79RzJKH6NpTTNa96YwBEhp/hb30FlQ7mdi87A5Eej2Fe8voIOg9f18fpnlTnzKqDp
         LY8fNv1ad3vOxuqB4d3McKs96hYOeMnoe5vCM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=b/GxNBwaz7wMC82CZdKDW26im9scvDZz6DcJVtY95DBIQ7/FoNN6WKF1m0RBbBxod+
         mIeyS7tq5C2OtXCgigD9U9KwqaUyb/Nz+fjnslZ/dkTeRkzaT0eJH0CFGQ77eB11g10S
         EAAAbBLDluDRnudesDJToo8bYldt5Qqd+JScg=
Received: by 10.86.82.6 with SMTP id f6mr8057193fgb.73.1213641016314;
        Mon, 16 Jun 2008 11:30:16 -0700 (PDT)
Received: by 10.86.96.14 with HTTP; Mon, 16 Jun 2008 11:30:16 -0700 (PDT)
In-Reply-To: <8aa486160806160515p751b2af4j2b0db6db7a9ad482@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85213>

Hi all,

thanks for the tips.

When I run describe I get an error:
$ git describe --debug HEAD
fatal: cannot describe '792815de6e3c2403f1e2ed5f2264ca88a0ae7000'

Any hints why? I have a tag v1.3 attached to HEAD and all commited.

CU,
Alf

On Mon, Jun 16, 2008 at 2:15 PM, Santi B=E9jar <sbejar@gmail.com> wrote=
:
> On Mon, Jun 16, 2008 at 13:51, Alf Clement <alf.clement@gmail.com> wr=
ote:
>> Hi all,
>>
>> I want to compile the current repository hash id into my program, to
>> be able to checkout later this
>> id an see the exact files for the compile. It should flag if there a=
re
>> currently modified files in the
>> directory tree.
>
> You can look at how git does it:
>
> http://git.kernel.org/?p=3Dgit/git.git;a=3Dblob;f=3DGIT-VERSION-GEN;h=
b=3DHEAD
>
>>
>> What would be the best command to get a unique identifier?
>
> "git rev-parse HEAD" for a unique identifier,
> but "git describe" is more convenient/useful.
>
>> Do I need the 40 digit hash id?
>
> Normally 7 or 8 are sufficient.
>
>> How can I make sure that a shorter hash id will be unique?
>
> You can't. Even the 40 digit hash is "only" cryptographically unique.
> But within a project 7 or 8 digits are unique enough for practical
> use.
>
> Santi
>
