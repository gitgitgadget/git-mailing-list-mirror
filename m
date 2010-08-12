From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Where do I stick development documentation?
Date: Thu, 12 Aug 2010 15:29:16 -0500
Message-ID: <20100812202916.GD2029@burratino>
References: <AANLkTi=dS1DYJ3MB-Du34sVPy8Qw8VNck=Lx54DtSfO0@mail.gmail.com>
 <20100812023922.GB19174@burratino>
 <AANLkTinPUqSywAscEG=VsYdFPwS=x0izM1cw-J1EBDGT@mail.gmail.com>
 <AANLkTikTX5_qchqDuxiz=dGeTG0gB7_iRt=mpR9vJH5J@mail.gmail.com>
 <AANLkTinT9ev0MWNP_Z4vnFGoMN6jSSPPPK4KiZzyLQhS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Witten <mfwitten@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 22:31:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjeQS-00043J-Tp
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 22:30:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760530Ab0HLUaw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 16:30:52 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:49165 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755097Ab0HLUav convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 16:30:51 -0400
Received: by ewy23 with SMTP id 23so933971ewy.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 13:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=lC9AQ0tZUF1UpR0nHFR7S0u4CXAC7wrV5YMCVPVMjMw=;
        b=rzjnmvTcAnwm5xE5binciPdf0+h75/KyW0xEt/Vo0ms9OQtVyN7UMJRzHRkZJj/xO1
         FFPDT90J1KdfK0Tip+s8oOdA627zaAXFx160vlSYxS4+lDVPk3Em0uizIydyzyMEQl7B
         hID7RvW+ABaXnOQx2kiNJJhuqKraZhsOtoK1E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ky3ml26Txxe3vD+NYDVJJ6CuUjSs1cFZAxxPlpgBcJQwWWj3Xl7RwigLWfO+c2bbOg
         hDGx97dlvQaNlQyqo5jEo9Oq9Umis6L9dpwGNq8xxdJ0jM4T9oTw68wY/HmpfAiT9S44
         6r0cCmv5IXjh+nGhEWPhXlYlSsgNToVRPJf2E=
Received: by 10.213.29.65 with SMTP id p1mr780560ebc.36.1281645049560;
        Thu, 12 Aug 2010 13:30:49 -0700 (PDT)
Received: from burratino ([66.99.3.154])
        by mx.google.com with ESMTPS id z55sm2799872eeh.3.2010.08.12.13.30.46
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 12 Aug 2010 13:30:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinT9ev0MWNP_Z4vnFGoMN6jSSPPPK4KiZzyLQhS@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153411>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> However ASCIIDOC is also fine for my purposes, which is just that
> these docs will be compiled as part of the manpage compilation, so
> they'll be there with man(1), info(1) and on the web with the HTML
> export.

=46WIW Documentation/technical is compiled to HTML (though not info,
for some reason).
