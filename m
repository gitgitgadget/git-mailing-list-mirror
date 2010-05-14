From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: [RFC/PATCH v3 4/5] Rename "crlf" attribute as "eolconv"
Date: Fri, 14 May 2010 23:32:03 +0200
Message-ID: <13750F09-B5F9-421E-9479-4C50CC0E59A1@gmail.com>
References: <cover.1273700831.git.eyvind.bernhardsen@gmail.com> <6dd7bef7811283b03b8b9dac93c9a264d007bcb0.1273700831.git.eyvind.bernhardsen@gmail.com> <alpine.LFD.2.00.1005121824260.3711@i5.linux-foundation.org> <961B7250-F65E-4C67-8C5C-6701F68C2FC0@gmail.com> <alpine.LFD.2.00.1005131438330.3711@i5.linux-foundation.org> <AANLkTil1i_vFAvT1CotYdK47LnufVKc17-1168rOVcMX@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Robert Buck <buck.robert.j@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 14 23:32:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OD2Ud-0006EH-Cr
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 23:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757784Ab0ENVcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 17:32:11 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:42095 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752861Ab0ENVcJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 May 2010 17:32:09 -0400
Received: by ewy8 with SMTP id 8so1024013ewy.28
        for <git@vger.kernel.org>; Fri, 14 May 2010 14:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=GIEcqhrvSv3I4Rjm5BF31wtGcseqb8ZjPkfPv0HBY8s=;
        b=A/FVEzus+ELKoLhapZgQChW4ZLcq5sjY9/mCnjs9RfIWs2yKOPDBRovQcRs5+To7I1
         CD2n2n5Yj+v6IpCxiyW9BeV3A22YVW4GR+rTZUds0frSUYCf6oU8RuPnsSQHai1h7Xhy
         XvVOhMogDjNR3K0DIdG0PpF6zfRMEldv68abY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=sS2CJVDXT+F2ZXIvmypMRSFtOaZAcq+z20kzuKkeAEhTFEceIR75hCoIi//LHfL0MK
         9ShsBpl462+TDROCZSfNCfXU5EpAgWBYoabs+7vF/fSL9OvJg+EGjyq4qgkLT6cKmBbf
         vrggnQRvnDPAk9GjT/SlritEVyTjSVjukAQ6A=
Received: by 10.213.52.199 with SMTP id j7mr637330ebg.79.1273872727945;
        Fri, 14 May 2010 14:32:07 -0700 (PDT)
Received: from vredefort.d.eyvind.bernhardsens.net (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 16sm1493904ewy.3.2010.05.14.14.32.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 May 2010 14:32:07 -0700 (PDT)
In-Reply-To: <AANLkTil1i_vFAvT1CotYdK47LnufVKc17-1168rOVcMX@mail.gmail.com>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147121>

On 14. mai 2010, at 04.34, Robert Buck wrote:

> Probably a newbie question, lots to read, lots already read, but I
> really want to verify if I have this correct. So in a nutshell, in the
> gitattributes file
> 
> *   text

I missed this when I replied to Jonathan, but you probably want "* text=auto" here.  "* text" would force git to treat all files as text files.

Also, as Jonathan said, if you want CRLF line endings you currently have to have core.autocrlf set to "true" (which is the default on Windows).
-- 
Eyvind
