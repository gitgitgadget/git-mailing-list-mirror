From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Newbie question
Date: Mon, 20 Sep 2010 10:39:58 +0200
Message-ID: <AANLkTikFSEbK+ho5mvaOfmv7a5SB7Sp2_5H-5dhbfaky@mail.gmail.com>
References: <1284940287810-5548737.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: kinley <arjuncode@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 10:40:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oxbv9-0002aY-Rx
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755665Ab0ITIkA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Sep 2010 04:40:00 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:33647 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755559Ab0ITIj7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Sep 2010 04:39:59 -0400
Received: by gwj17 with SMTP id 17so1231169gwj.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XeJNGc/8tXxQjg1zif1y4oAkwyw1CZynrDFVjqQp9m0=;
        b=mQViBW/Bx9dWOTdDX8xlZDFFoShLIxCQW2k8agSyqiXvN35rKZdqfPhnH+VTmudp2w
         3IOlTvfI4qX/fmOU64hYc9Mf+ymjO+285by/mPg2bXy3RAKlfwsmSYwCGsfaueLNI+hT
         UjXptgeNTKGm7jp9lrEyyX703MgShOn36XdoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JNJQDQzNMRxWYK4nyRK5e8exHBwCG0OeUdnareYyD4goGlra5fMct8lHVbtW3oJ5MM
         37n5hShp4I8AaPm1wY3uZhiNQHOx3DaLfrsmOJOXn+NvhyoTuyp815RYt4hnv2vYKvsL
         vGtBBywnO3SDgydfmuqI0z6ol32VbT58XYK34=
Received: by 10.90.247.32 with SMTP id u32mr5602010agh.17.1284971998334; Mon,
 20 Sep 2010 01:39:58 -0700 (PDT)
Received: by 10.90.226.11 with HTTP; Mon, 20 Sep 2010 01:39:58 -0700 (PDT)
In-Reply-To: <1284940287810-5548737.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156599>

On Mon, Sep 20, 2010 at 01:51, kinley <arjuncode@gmail.com> wrote:
>
> Hi,
> I am new to question. Please help me with this.
> I copied an already existing project from a remote server using scp t=
o my
> local directory.
> The contents of this directory are
> =C2=A0 branches
> =C2=A0 config
> =C2=A0 description
> =C2=A0 HEAD
> =C2=A0 hooks
> =C2=A0 info
> =C2=A0 objects
> =C2=A0 ref
>
> I checked all the directories and sub-directories but could not find =
a
> single source code file (in C language).
> All I can see at the leaf level appear to be MD5 hash code.

It is SHA-1

> Is there any command to retrieve the source files ?

try this:

  git clone . ../Histogram

But others are right, and you should have used git clone, instead of sc=
p.
