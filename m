From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Common setting for interoperability repo across windows and unix?
Date: Wed, 4 Nov 2009 17:59:21 -0500
Message-ID: <32541b130911041459y7a2201a3r18601522187891f2@mail.gmail.com>
References: <c94f8e120911030709h29c5b8edr53df269632990e81@mail.gmail.com> 
	<32541b130911030733i734b9f6doc366934873bf7713@mail.gmail.com> 
	<S0ax5AE0Xf8KFwjv@thewolery.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Anthony W. Youngman" <wol@thewolery.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Nov 04 23:59:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5opP-00066o-Tr
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 23:59:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755517AbZKDW7h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Nov 2009 17:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755374AbZKDW7h
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 17:59:37 -0500
Received: from mail-yw0-f202.google.com ([209.85.211.202]:63364 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754954AbZKDW7g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Nov 2009 17:59:36 -0500
Received: by ywh40 with SMTP id 40so6790141ywh.33
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 14:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=LMUvgP/tTSvmRFBYt3CgX1gwsCGCfxBCFh5OKdzzxHI=;
        b=bJPwS+uw+zzlZOpU95D9GIEZsC5+r9W4cVIbUraAWcyT1R6bZ+C8hebskEP/KmyxAf
         /Rln39y0qWBYEKVeowzkt55td5FmOIOfRoL5Hms5nzmEWBLfHqpZ9fH+Jb9yE+92lzew
         zeqCS9api9f9Jw9Uj7TuDFNn2GoJg6bw1Wnek=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=KNyxqF48vQzloNKmViSMcEy7rglO3UaoiwBGPASAlkjDVlskJSKLTVrDiiyhTRivgQ
         0LaUmeRXhQngxGaAo+SqFLWxb/Yyr80138synaFtBu9tpLyEFxH1kdnWOFijf7iT5ZyD
         I4SZooVzYcbf/SJLlhndGZHnFSHla4pS9h7IY=
Received: by 10.150.244.4 with SMTP id r4mr3853231ybh.127.1257375581769; Wed, 
	04 Nov 2009 14:59:41 -0800 (PST)
In-Reply-To: <S0ax5AE0Xf8KFwjv@thewolery.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132166>

On Wed, Nov 4, 2009 at 4:45 PM, Anthony W. Youngman
<wol@thewolery.demon.co.uk> wrote:
> In message <32541b130911030733i734b9f6doc366934873bf7713@mail.gmail.c=
om>,
> Avery Pennarun <apenwarr@gmail.com> writes
>> You can pull from a Windows box by running git-daemon on that box fr=
om
>> the command line. =A0(It's easier than it sounds.)
>
> That presumes you're running Cygwin ...
>
> git-daemon doesn't (currently) work on msysgit. Currently I run git-d=
aemon
> on my linpus netbook and pull/push from windows.

I didn't know that.  Windows sockets are mercifully very nearly
compatible with Linux ones, so hopefully this wouldn't be too hard to
fix for someone that needs it.  (Not me; I prefer cygwin over msys in
all cases.)

Avery
