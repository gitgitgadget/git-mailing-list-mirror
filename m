From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [WIP PATCH] Add skeleton remote helper for SVN
Date: Mon, 10 May 2010 15:08:14 +0200
Message-ID: <AANLkTil8Ezw3rE-q6pQHr4o-aUNXr-HYbFwbX597VlT1@mail.gmail.com>
References: <1273491574-31870-1-git-send-email-artagnon@gmail.com> 
	<1273491574-31870-2-git-send-email-artagnon@gmail.com> <AANLkTilzn2GLbxz3vLD4SoNIrYDU9_YzFfPI5Wv_WFs2@mail.gmail.com> 
	<AANLkTikFl25Hay7UEvsz5bsdg8fdT8485SxqgAZXCYqd@mail.gmail.com> 
	<20100510125953.GA5642@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 15:08:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBSj1-0004ol-1H
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 15:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753882Ab0EJNIh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 May 2010 09:08:37 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:44373 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753487Ab0EJNIg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 May 2010 09:08:36 -0400
Received: by qyk13 with SMTP id 13so6098957qyk.1
        for <git@vger.kernel.org>; Mon, 10 May 2010 06:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ufJp4R8w3fovTmHe4e5k9L7fzlvIqDMDU0CpDR3I4oA=;
        b=exIjrJXJnozmakE1sP7fazjdkyCFjJFipfDdPI325Omo8mXLaetrQqY2OKkiNw5iIS
         rlUiq6mT33AFw0p0zctendVJ2eJLtd3BqWa6Lgvz9HjY+6RfBquT1ZBDFtxPN5W6pRcK
         uXyS6MeQoqDbRKiLmu4giOShbMMpxGJZ53Wxc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Yw0CRHuONZ+8IIZfKGeAm1P3H5ykzemn7tgKX5VSZWvkklDTeUFVBhSJ9neJf2KRSV
         DZ6GZr60ifm8Hg25tEuABb0wDopES8Fkf6CuaMCfuxYG9z4gaMvBgLH20H9OyPhav2EE
         QrEXFD5RjjX0otx3b5x/y1tt6qZFjyTtN4VFM=
Received: by 10.224.26.226 with SMTP id f34mr2609173qac.3.1273496914611; Mon, 
	10 May 2010 06:08:34 -0700 (PDT)
Received: by 10.229.182.85 with HTTP; Mon, 10 May 2010 06:08:14 -0700 (PDT)
In-Reply-To: <20100510125953.GA5642@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146810>

Hi Jonathan,

On Mon, May 10, 2010 at 2:59 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Since the conflict resolution is trivial, I agree. =C2=A0When there i=
s an
> actual dependency between patches, I think there is nothing wrong
> with basing one patch on another; as long as you make it clear
> what your patch applies to, humans and Junio=E2=80=99s scripts can co=
pe with
> the task of applying one series on top of the topic branch for
> another.

Okay, got it.

> Re your skeleton code, it looks reasonable to me. =C2=A0I could nitpi=
ck the
> names of the import_handler() and export_handler() functions and the
> needless use of do ... while, but I will refrain. :)

Yeah, I suppose that can wait for a couple of weeks- atleast until I
have something minimally working :)

> Much more importantly, there is something to play with now. =C2=A0On =
that
> note, is David=E2=80=99s code out there somewhere for people to fool =
around
> with? =C2=A0At this point, I am not interested in a stable interface =
or
> permanent history, just a way to try out the code and start to get
> used to it.

Yes. You can see it on David's GitHub [1] and my fork [2]. I send
patches to David by email, so both should be in sync.

-- Ram

[1] http://github.com/barrbrain/svn-dump-fast-export.git
[2] http://github.com/artagnon/svn-dump-fast-export.git
