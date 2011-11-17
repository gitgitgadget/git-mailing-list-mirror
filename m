From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] i18n: add infrastructure for translating Git with gettext
Date: Thu, 17 Nov 2011 05:09:44 -0600
Message-ID: <20111117110856.GA5586@elie.hsd1.il.comcast.net>
References: <1321191835-24062-1-git-send-email-avarab@gmail.com>
 <7vlirhx14x.fsf@alter.siamese.dyndns.org>
 <CACBZZX4nypBW1agNw6NrC-7LBWbjZ1ycgpn-zvBsg0x4EDBD0g@mail.gmail.com>
 <20111116103319.GB30753@elie.hsd1.il.comcast.net>
 <CACBZZX6AMRra1wf_WOvxuZs8kbOD29kFDU2GwA9aOV2svnDctQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Jeff Epler <jepler@unpythonic.net>,
	Johannes Sixt <j6t@kdbg.org>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Peter Krefting <peter@softwolves.pp.se>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 17 12:10:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQzr0-0003XZ-IZ
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 12:10:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756689Ab1KQLJ5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Nov 2011 06:09:57 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:32920 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753007Ab1KQLJ5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2011 06:09:57 -0500
Received: by iage36 with SMTP id e36so1937293iag.19
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 03:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=u/205E5Ba1vgXyxt/PwWGTzrqmL+wJ9vEGzPAt9sF8o=;
        b=mJUQKaZcOVem3REQBznVtEwvKidiakodzKRtqOZznuz2kY2FFT1q+zUJQWICfhnsSC
         wsIZEohAQ/te1XWxmXg4AxttbB6i5nzyu2Ao3rIO8HOUL9fIzzshoexAaxD8e2qgJPbp
         sp5ZsDmiEUKIxnZ9W8ZSPyuZ7LrGjlwRKqNok=
Received: by 10.42.72.135 with SMTP id o7mr41702295icj.45.1321528196535;
        Thu, 17 Nov 2011 03:09:56 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id el2sm56690679ibb.10.2011.11.17.03.09.54
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Nov 2011 03:09:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACBZZX6AMRra1wf_WOvxuZs8kbOD29kFDU2GwA9aOV2svnDctQ@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185596>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Yes I'm an idiot. I confused the installation part with stuff we
> actually make in the git compilation directory.
>
> The i18n code is indeed the onle thing that uses "share" in the
> compilation directory.

Most of your message didn't seem idiotic.  In particular, putting the
message catalogs somewhere less confusingly named than
$(srcdir)/share, like $(srcdir)/po/generated or
$(srcdir)/textdomaindir.built, makes a lot of sense to me.
