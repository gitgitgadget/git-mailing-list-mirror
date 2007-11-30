From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Fri, 30 Nov 2007 07:40:27 +0700
Message-ID: <fcaeb9bf0711291640p52cb46fdo97e286e34c4e0527@mail.gmail.com>
References: <20071127160423.GA22807@laptop>
	 <fcaeb9bf0711280036p33583824ge59af93bbe3f0a78@mail.gmail.com>
	 <7vfxyq2c9b.fsf@gitster.siamese.dyndns.org>
	 <20071129150849.GA32296@coredump.intra.peff.net>
	 <fcaeb9bf0711291205h125dadbbp8e8ae392e9b5b751@mail.gmail.com>
	 <20071129211409.GA16625@sigill.intra.peff.net>
	 <Pine.LNX.4.64.0711292218240.27959@racer.site>
	 <20071129231444.GA9616@coredump.intra.peff.net>
	 <alpine.LFD.0.9999.0711291527090.8458@woody.linux-foundation.org>
	 <7veje8twt2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Jeff King" <peff@peff.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jan Hudec" <bulb@ucw.cz>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 01:40:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixtw7-0003yL-J3
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 01:40:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762104AbXK3Ake (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 19:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762013AbXK3Akc
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 19:40:32 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:52644 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761644AbXK3Akb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 19:40:31 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2061914nfb
        for <git@vger.kernel.org>; Thu, 29 Nov 2007 16:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=A1HxUI0GCRlE3mT1Rs8jRbis4d3xMm1Svk+IQcAYRWo=;
        b=DnbqYtWWZSwbVa7uCWchkXmQPelr5mClKNAMxf6k3cWr/lPncHYPppkZZuOSLrgt6s6tmuREt/YxwSbxusyKqKDZ1/a+0d+hnpaVeQWYv9comE+a/e74lvqroVMqNcn1fngN2XgdLU4EWUg5wM2AzUqF2IAhtsFpUvSERKTwt9k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SfUOE8YENE8s+F8tGvmtwUb3wnAduFW1gTx4+b2mNhlrBZhfo4Tcie+aTlXV99Yaw4zaeLSOqhKMHFZft4Z167STzN5y+T4fOqMgZe0qpArDYSG+pcuuQkvYv3dEcgsVFw844ZBGH1e1JEZHZPoxi/3U5vP+tvaDnSAzO1waDuQ=
Received: by 10.86.77.5 with SMTP id z5mr6674332fga.1196383227712;
        Thu, 29 Nov 2007 16:40:27 -0800 (PST)
Received: by 10.86.83.6 with HTTP; Thu, 29 Nov 2007 16:40:27 -0800 (PST)
In-Reply-To: <7veje8twt2.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66579>

On Nov 30, 2007 7:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
>  - Post v1.5.4, start cooking gitexecdir=$(libexecdir)/git-core, aiming
>    for inclusion in v1.5.5, perhaps in Feb-Mar 2008 timeframe.  This
>    will also affect the sample RPM spec and resulting RPM binary
>    packages I will place on k.org, and I'll ask Gerrit to do the same on
>    Debian side.  The official binary packaging of individual distros are
>    not under my control, but if there is a handy list of people I can
>    send this notice to for other distros, that would help this process.

You can find Gentoo maintainers here:

http://sources.gentoo.org/viewcvs.py/gentoo-x86/dev-util/git/metadata.xml?rev=1.6&view=markup

-- 
Duy
