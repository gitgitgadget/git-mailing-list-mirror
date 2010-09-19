From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Subject: Make format-patch produce UTF-8 `From:' header (was Re: git am should recognize >From)
Date: Sun, 19 Sep 2010 20:38:50 +0200
Message-ID: <87y6axshmt.fsf_-_@gmail.com>
References: <AANLkTin_5qzDkMU_1stYZcJpfW-W7K0kxy=0K2dA7SwO@mail.gmail.com>
	<AANLkTinOa+s-28PYXHhtKr_POu2D33ibfgKDKk4Wqi=9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Russ Allbery <rra@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	"Stefan-W. Hahn" <stefan.hahn@s-hahn.de>,
	Lukas =?utf-8?Q?Sandstr=C3=B6?= =?utf-8?Q?m?= 
	<luksan@gmail.com>, Jeff King <peff@peff.net>,
	Christian Himpel <chressie@googlemail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 19 20:39:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxOnf-0005p4-Kf
	for gcvg-git-2@lo.gmane.org; Sun, 19 Sep 2010 20:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755245Ab0ISSji convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Sep 2010 14:39:38 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57459 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754817Ab0ISSji convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Sep 2010 14:39:38 -0400
Received: by bwz11 with SMTP id 11so3836801bwz.19
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 11:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject
         :in-reply-to:references:user-agent:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=lE5zswa08lOTolLVCLoauHTwoWc6HYbzICHJuaxospM=;
        b=C4lGsw+GF5+FM18D57AzMVbYalLdpIYS3h5EYcObS1lT2KzPAV93hX6KVAIL48yCL0
         ghDDaYi7eCWgx0XJ3cMSe5CqOxsB0F+ir0jX/oKfDELPIGZo0X2NbGHCwuP4JwItkRVI
         A2yvmJpM9v0RVznyl6eRkl150KnZ7WNmNPUZo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type:content-transfer-encoding;
        b=Mm+kRj6eRLTOUkbvHGgLepMWzNT2IwmOGazD8WbDFYKlaQk7f6vFuWIPXGHMEG9ZNO
         IJSdv84XgwWp7eYOUOSpfMfivDiltlm2w/Nka5RwvhzGNF7hfD3jGTIxRtlKVYlC+NqU
         mULPKTGqWr2WsbDy9aZ+eGdHT3KpZ3kucCb7o=
Received: by 10.204.74.195 with SMTP id v3mr6136433bkj.35.1284921576813;
        Sun, 19 Sep 2010 11:39:36 -0700 (PDT)
Received: from localhost ([88.103.132.186])
        by mx.google.com with ESMTPS id g12sm5755058bkb.14.2010.09.19.11.39.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Sep 2010 11:39:35 -0700 (PDT)
In-Reply-To: <AANLkTinOa+s-28PYXHhtKr_POu2D33ibfgKDKk4Wqi=9@mail.gmail.com>
	(Jonathan Nieder's message of "Sun, 19 Sep 2010 17:32:11 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156508>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Maybe format-patch could provide another mode to produce patches that
> do not include unnecessary headers (in particular, leaving out the
> difficult "From " line and using UTF-8 instead of quoted-printable fo=
r
> the "From: " line).

=46WIW, the quoted-printable `From:' encoding has always annoyed me -- =
I
replace it manually with my name & address in UTF-8 every time I send
out a patch. What is the reason format-patch does that (and if there is
a reason not to change the default, could an option to disable it be
provided)?

=C5=A0t=C4=9Bp=C3=A1n
