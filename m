From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: [PATCH v2 2/3] pretty: make %H/%h dependent on --abbrev[-commit]
Date: Mon, 26 Apr 2010 11:23:01 +0100
Message-ID: <4BD56985.2030506@gmail.com>
References: <1272232579-18895-1-git-send-email-wmpalmer@gmail.com> <1272232579-18895-2-git-send-email-wmpalmer@gmail.com> <1272232579-18895-3-git-send-email-wmpalmer@gmail.com> <20100426031012.GA29953@progeny.tock> <u2i5b9751661004260047n168ad87bx6083fc201bfb21d9@mail.gmail.com> <20100426095206.GA31483@progeny.tock> <p2w5b9751661004260313kd1b809earb8d9fd8c4d09adef@mail.gmail.com> <20100426101911.GA8841@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Thomas Rast <trast@student.ethz.ch>,
	=?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 12:23:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6LTK-0002vR-61
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 12:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754184Ab0DZKXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 06:23:13 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53810 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753974Ab0DZKXM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 06:23:12 -0400
Received: by wyg36 with SMTP id 36so1109853wyg.19
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 03:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=WtfAG5TDKv7clmUdr/3lKZ8kv5Q0eDDqz12UTANWNXM=;
        b=WAtm3jt55ImyvZkfbT2fnYwCJ6aPHvc7qLCGRoo4qlzyFovh6kN+oSlX7wf4KICZiL
         +XfAPR5xrDxfcUcgcoA+yF/BkWTFUuE7ZphK/oYfNU0yHqOkuMUOQtVtYa3FGMergPGH
         Ckj4e522XKBxu1shFzV52XRTnqaeuLWUW6iWA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=JTNQWVDFdGrebeD12QXfkHwqp5E693Lge0IWEoAly0vkaIH0Ued5KUhdsHzBkBSofK
         3cDjuaKB1K3+BSQP34eka7oYfy5G+aPFWhtsYmwlpKCDJQrvq7SvQvJ5XQWV/iXtzy3R
         DDcGVpYSlsFZOIH4fU0gZZxTLXPr7DfzupiBM=
Received: by 10.216.176.143 with SMTP id b15mr4865659wem.155.1272277390120;
        Mon, 26 Apr 2010 03:23:10 -0700 (PDT)
Received: from [192.168.2.64] ([193.164.118.24])
        by mx.google.com with ESMTPS id r29sm528141wbv.21.2010.04.26.03.23.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Apr 2010 03:23:09 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
In-Reply-To: <20100426101911.GA8841@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145809>

Jonathan Nieder wrote:
> I sent it as a reply, but the patches are against master.  The last of
> the four patches is from your series with a few small changes and its
> in-message From: line is set accordingly.  Sorry for the confusion.
>
> Jonathan
>   

I think the documentation / test changes are needed, but my
own patch will probably go through several more revisions
before it is ready to be included, which is why I suggested
submitting your series separately.
