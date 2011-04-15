From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2/RFC 10/11] gitweb.js: Add UI for selecting common timezone to display dates
Date: Fri, 15 Apr 2011 20:06:26 +0200
Message-ID: <201104152006.27211.jnareb@gmail.com>
References: <1302878645-458-1-git-send-email-jnareb@gmail.com> <1302878645-458-11-git-send-email-jnareb@gmail.com> <201104151943.11537.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 20:06:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAnPk-0002QV-OG
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 20:06:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756223Ab1DOSGg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Apr 2011 14:06:36 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48295 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755510Ab1DOSGf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 14:06:35 -0400
Received: by bwz15 with SMTP id 15so2385438bwz.19
        for <git@vger.kernel.org>; Fri, 15 Apr 2011 11:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=3n9/9zgGhkdzzR/kNfMO979cfrwC/zew1/zquv7nPOg=;
        b=xZ9TM4BolIBAfjctjDOVncItRFGpZEgjMfTVPGMOAAebjJmhmsdlJpuSSH5wf2ahgF
         ufV05CT9byTvVHfWrdhEBV5P2dpYpKs4wJIdRD4uqQqkicahFIK1TdojZNuB/NwYq6yI
         djL68ypj8thTcOQI5eR8vvMm2zyjX2wqNjLs0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=XyaDPII8nN4Rk9yqc2g7SeAxWIZsw3e5iEv0xGG9BOFEJpGCSMu+8ulHmfy2nbSrYw
         2u6B+47N5ZwJn33iKE8Ddcyq7rLCSX5FMg1KTqXzJ/O16cmzH1eDwTxyEaxi1NquMC7R
         gprhr2j1gNXxakE3RRLn9pHkzJSM35H9xa2ro=
Received: by 10.204.20.139 with SMTP id f11mr110043bkb.177.1302890794116;
        Fri, 15 Apr 2011 11:06:34 -0700 (PDT)
Received: from [192.168.1.13] (abvp82.neoplus.adsl.tpnet.pl [83.8.213.82])
        by mx.google.com with ESMTPS id y9sm1685823faj.2.2011.04.15.11.06.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Apr 2011 11:06:33 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201104151943.11537.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171627>

Jakub Narebski wrote:
> On Fri, 15 Apr 2011, Jakub Narebski wrote:
>=20
> > KNOWN BUGS:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > * Timezone selection doesn't work in Chromium 6.0.472.62 (59676) an=
d
> > =A0 Google Chrome 10.0.648.204:
> >=20
> > =A0 Uncaught Error: NOT_FOUND_ERR: DOM Exception 8
> > =A0 =A0 removeChangeTZForm
> > =A0 =A0 /gitweb-static/gitweb.js:785
> > =A0 onTZFormChange
> >=20
> > =A0 line 785: var removed =3D container.removeChild(popup);
> >=20
> > =A0 It works in Mozilla 1.17.2, Konqueror 3.5.3, Firefox 3.6.15, 3.=
6.16
> > =A0 and 4.0, Internet Explorer 8.0, Opera 10.63.

> [...] I'd check if not setting 'onblur' event handler (which doesn't
> work as expected anyway) would help.=20

It helps -- Google Chrome works correctly now.

--=20
Jakub Narebski
Poland
