From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [WIP PATCH] Add skeleton remote helper for SVN
Date: Mon, 10 May 2010 07:59:53 -0500
Message-ID: <20100510125953.GA5642@progeny.tock>
References: <1273491574-31870-1-git-send-email-artagnon@gmail.com>
 <1273491574-31870-2-git-send-email-artagnon@gmail.com>
 <AANLkTilzn2GLbxz3vLD4SoNIrYDU9_YzFfPI5Wv_WFs2@mail.gmail.com>
 <AANLkTikFl25Hay7UEvsz5bsdg8fdT8485SxqgAZXCYqd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 15:00:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBSaX-0000g8-Mf
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 15:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753977Ab0EJM7z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 May 2010 08:59:55 -0400
Received: from mail-yw0-f198.google.com ([209.85.211.198]:44436 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753882Ab0EJM7y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 08:59:54 -0400
Received: by ywh36 with SMTP id 36so1879697ywh.4
        for <git@vger.kernel.org>; Mon, 10 May 2010 05:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ewe7eJOgVwRJbUYLRIzXBJTtkyMNFPutpz9CmsjRJDs=;
        b=UpyKiDhpI+fMdzCFnfBDUz5qBhYLAjSeD6PuCWbaHMqK+GPLbGa63xbsD8Xfc1w0TX
         7cIEMTezPiLg76ohdcyBewQ8SCDNCwPc0PPSHxJLCrD9P881MdPPpIXQswPqNRjyP4aO
         PYj3PWpVxCCwZGGvHaXvWuFexalNoLyHMQ1po=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=g/DOyhCD8y54Umc8pl5syoOgWECzTN9qwzd0qLAxTDxosZ74I5mvnjhBZzUE/TfAIA
         ZfUX+WOMVotbCvFMpOGVj9NSAuvm/CCfPWQAeQBjoYaRWYFpTWMsKPCnjXdPpC3dYyT7
         enQg0f9Qoa/nmDpavV6Q42vtGv+VNUMFoDa4Y=
Received: by 10.231.184.18 with SMTP id ci18mr185498ibb.62.1273496393793;
        Mon, 10 May 2010 05:59:53 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id k10sm528152ibu.13.2010.05.10.05.59.51
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 10 May 2010 05:59:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikFl25Hay7UEvsz5bsdg8fdT8485SxqgAZXCYqd@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146808>

Hi Ram,

Ramkumar Ramachandra wrote:

> It'll be good if Jonathan's patch makes it to `master` by
> then, but I don't think I should prematurely rebase on patches that
> aren't in `master` yet.

Since the conflict resolution is trivial, I agree.  When there is an
actual dependency between patches, I think there is nothing wrong
with basing one patch on another; as long as you make it clear
what your patch applies to, humans and Junio=E2=80=99s scripts can cope=
 with
the task of applying one series on top of the topic branch for
another.

Re your skeleton code, it looks reasonable to me.  I could nitpick the
names of the import_handler() and export_handler() functions and the
needless use of do ... while, but I will refrain. :)

Much more importantly, there is something to play with now.  On that
note, is David=E2=80=99s code out there somewhere for people to fool ar=
ound
with?  At this point, I am not interested in a stable interface or
permanent history, just a way to try out the code and start to get
used to it.

Thanks,
Jonathan

[1] git://repo.or.cz/svn-all-fast-export.git
