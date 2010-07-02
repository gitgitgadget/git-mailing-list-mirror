From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH/RFC] Teach fast-import to import subtrees named by tree id
Date: Fri, 2 Jul 2010 05:20:01 +0200
Message-ID: <AANLkTinSvg6fqu0Y-EHpMoQDZcYBIRP3qRprsHQQwjZE@mail.gmail.com>
References: <20100701031819.GA12524@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 05:20:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUWnk-0002k3-2P
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 05:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756048Ab0GBDUW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 23:20:22 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41382 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518Ab0GBDUW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jul 2010 23:20:22 -0400
Received: by gye5 with SMTP id 5so218832gye.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 20:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=aZTSCN0VFdjfooBQoJ9k6K4G0hskivl7lfMd8H2wk38=;
        b=v/bTzMsba7hhMTzRDVSPJiSKFHW8tRcH8HaWUjWNJL/yWZOPIHq2VC4SO/aBtSyJ8z
         cltEarHBPMs+EFzpAPgG68athd1kyYzSKmNVeDIQCJNTRRGVDuQxg5SUVxJHS4pvrUNY
         sITlQ5ryftAvbkEzq0YM7sS4/MKlcffIXdQag=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Xbsu4Y1/znqUaZpUcfCX+MFYi7l1e55WCX5yR6roa6mGknzXUQFLBnHw5c/ePsngN3
         206vQ6dzm2enSLqDfTl/u5zbgRwrmTMbfk4Vc3OD7XFg98gRLx9bZHE3U6rwzzdOxfd9
         rgicpKRvnMwLxHnX1usJRA7BMU3FIut39iKNQ=
Received: by 10.101.10.22 with SMTP id n22mr5184ani.224.1278040821193; Thu, 01 
	Jul 2010 20:20:21 -0700 (PDT)
Received: by 10.150.184.8 with HTTP; Thu, 1 Jul 2010 20:20:01 -0700 (PDT)
In-Reply-To: <20100701031819.GA12524@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150102>

Heya,

On Thu, Jul 1, 2010 at 05:18, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> I was not sure whether to add a "feature" specification for
> this, so I=E2=80=99ll try that as a separate patch.

Yes, that'd be a good idea. That should be as easy as adding an option =
though?

--=20
Cheers,

Sverre Rabbelier
