From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Documentation/Notes: Remove 'footnote:' warning
Date: Mon, 18 Jul 2011 00:51:08 -0500
Message-ID: <20110718055108.GA4254@elie.gateway.2wire.net>
References: <1310855420-21183-1-git-send-email-pavan.sss1991@gmail.com>
 <1310908271.21563.17.camel@drew-northup.unet.maine.edu>
 <20110717215858.GA9906@elie>
 <CAK9CXBVSq_j7naHzVLMj=bW8WMKq_WfkDQP4zspkK_QizC26=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Drew Northup <drew.northup@maine.edu>, git@vger.kernel.org
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 18 07:52:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QigkW-0003W3-Qt
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 07:52:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991Ab1GRFvQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jul 2011 01:51:16 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:50927 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698Ab1GRFvP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jul 2011 01:51:15 -0400
Received: by yia27 with SMTP id 27so1171902yia.19
        for <git@vger.kernel.org>; Sun, 17 Jul 2011 22:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6tB3YDVsDKI0HNjunEwPU5+0+PPSG26RhUiT52gaPrA=;
        b=mJ4gfQRnfocMfnWJb0NrURiRnLbsEZsnTu9/QahlfRnl7SBQUr5xUMUL3BEAfyl8fA
         7DLSLHSbEsmLpgb3YsuLd7ouIwtEGzGJLIEQ2MyTLinsC6E6SRfJ8y++oqgtBEAYXiWp
         heSTc1sdNAfydwhvB/BcD5Qb4mC4yvQTc317A=
Received: by 10.236.115.170 with SMTP id e30mr7145777yhh.252.1310968275197;
        Sun, 17 Jul 2011 22:51:15 -0700 (PDT)
Received: from elie.gateway.2wire.net ([69.209.74.225])
        by mx.google.com with ESMTPS id z28sm2875653yhn.35.2011.07.17.22.51.13
        (version=SSLv3 cipher=OTHER);
        Sun, 17 Jul 2011 22:51:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAK9CXBVSq_j7naHzVLMj=bW8WMKq_WfkDQP4zspkK_QizC26=g@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177339>

Pavan Kumar Sunkara wrote:
> On Mon, Jul 18, 2011 at 3:28 AM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:

>> Good call. =C2=A0This was fixed by Docbook XSL 1.76.0:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Norman Walsh: block.xsl; endnotes.xsl
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Fix bug where=
 simpara in footnote didn't work.
>>
>> The symptoms are a warning and a little extra vertical space after t=
he
>> numberal "1." in the output. =C2=A0I don't know if it is worth worki=
ng
>> around or not.
>
> So, using newest version will not give us a warning?

Yes, when I run "make -C Documentation git-notes.1" I don't get the
warning or spurious blank line.  Sorry for the lack of clarity.
(That's no reason to not to adopt a workaround if it is pleasant, of
course.)
