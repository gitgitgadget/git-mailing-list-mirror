From: "=?ISO-8859-1?Q?Steve_Fr=E9cinaux?=" <nudrema@gmail.com>
Subject: Re: linking libgit.a in C++ projects
Date: Mon, 4 Aug 2008 16:52:07 +0200
Message-ID: <f35478f50808040752j52a8ac0dn56d15d2151dc5308@mail.gmail.com>
References: <ac9f0f090807310253v1d97e2a1n4ddf34aa4fdc79f0@mail.gmail.com>
	 <20080731105727.GF7008@dpotapov.dyndns.org>
	 <ac9f0f090807310410u461f5584ved74769d8452c539@mail.gmail.com>
	 <bd6139dc0807311127j57d9ab5ckd6acf16d17621614@mail.gmail.com>
	 <ac9f0f090807311444lb2f02e6ud76463b359184fbd@mail.gmail.com>
	 <bd6139dc0807311451t763aa07bsf9474fce4073babd@mail.gmail.com>
	 <20080731215818.GD24631@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: sverre@rabbelier.nl, cte <cestreich@gmail.com>,
	"Dmitry Potapov" <dpotapov@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Aug 04 16:53:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQ1Qv-0007tI-Hj
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 16:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754056AbYHDOwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 10:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754276AbYHDOwL
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 10:52:11 -0400
Received: from hs-out-0708.google.com ([64.233.178.245]:48382 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753700AbYHDOwK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 10:52:10 -0400
Received: by hs-out-0708.google.com with SMTP id 4so72787hsl.5
        for <git@vger.kernel.org>; Mon, 04 Aug 2008 07:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=obXnBxVX88l9CSxFREBKld7p7u9ifZWMHyUQey4Key0=;
        b=P07zOmoQWMETj7MVYhRUI48k2Jt7GO6oBnQcsMkL7X4H0BLY+4lZ4UarphHOMp41t0
         eeImjs0ZsoEWTPcgXLSWDHJ6nGf5l+Ru9QmoVa9k8U//y6z8qJscorHZbksH6+v17xwf
         PPsObCzMVcw/RRcEF8jXGbcX3nzq1lF4XRsig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=XERTludhjhTfA92OUu8qPjggzVV6qB2crwl5X8SY4fS0dys9G8KzZ/uit2sWEAAdrq
         /I8HbVKt5HM6NZD+/LzrQFyNFU8s3Tf9BNN57/63FE6Kanj3NufSh5PRmdcEcK+geePZ
         oJCimQnhZBuTQkiCWoAkax0WdMV2Kg8eBZxXU=
Received: by 10.100.240.17 with SMTP id n17mr19738673anh.49.1217861527808;
        Mon, 04 Aug 2008 07:52:07 -0700 (PDT)
Received: by 10.100.12.17 with HTTP; Mon, 4 Aug 2008 07:52:07 -0700 (PDT)
In-Reply-To: <20080731215818.GD24631@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91365>

On Thu, Jul 31, 2008 at 11:58 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
>> Especially since that'd mean that integrating it into other languages
>> (by means of wrappers), such as Python or Ruby, becomes a lot easier.
>
> I'm going to be shot for saying this, but both Python and Ruby
> have implementations that run on the JVM.  So does Git.  Want
> to use Git and Python?  Use JGit and Jython.  :)

There is also the "stores" branch from pygit [1] that implements pack
and object reading natively in python. Anyway implementing more than
that (ie, packing and such things) natively is clearly harder and
takes more work for less efficiency than making bindings around a
libified git...

[1] http://code.istique.net/?p=pygit.git;a=shortlog;h=refs/heads/stores
Don't mind the 50X error, just refresh... broken server.
