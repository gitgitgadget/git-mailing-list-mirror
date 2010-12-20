From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/3] gitweb: decorate a bit more remotes
Date: Tue, 21 Dec 2010 00:06:11 +0100
Message-ID: <201012210006.13042.jnareb@gmail.com>
References: <1292871681-4818-1-git-send-email-sylvain@abstraction.fr> <1292871681-4818-3-git-send-email-sylvain@abstraction.fr> <20101220200203.GA24163@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sylvain Rabot <sylvain@abstraction.fr>, git@vger.kernel.org,
	John 'Warthog9' Hawley <warthog9@kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 21 00:06:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUooF-0003uw-GQ
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 00:06:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933043Ab0LTXGW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Dec 2010 18:06:22 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:60837 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758062Ab0LTXGV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Dec 2010 18:06:21 -0500
Received: by bwz16 with SMTP id 16so3911128bwz.4
        for <git@vger.kernel.org>; Mon, 20 Dec 2010 15:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=2te1Xp1xQpQYR3qT7IhFlh2FaKaji8ocN/fDaVMeOrc=;
        b=KNIN6+MwPb8qwzCf9iGLDNHJ770tTN/gd+LzMyZyKFKpcYbMIRv5DsxCYaSrJMenxJ
         NgMINZNd2cWFk/DyCs7e1xrVpwFIZwOo95TfbHJNV3XK3BUtbe6AjelaJa5EZRKKXR+e
         Amnp5stdyy2ObQ6QRMg/IuRz+vANTm9tADbeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=vqYQHMCROMnWmiowfHT7w2JbIQOsgj+/X996p7OL/ozNVVAAf07j1asmOqvQZKe7hd
         Ih7gqd1PsUC5VFiHdfpf8KFWMJgT8oXd3zl3yIqw4XVVXYe1Zx4iarbLJr/F11RiisHP
         2MIvwLQsFzZKNbacTXP6MMj9NK8aPowQMRlTo=
Received: by 10.204.123.7 with SMTP id n7mr4106642bkr.33.1292886378867;
        Mon, 20 Dec 2010 15:06:18 -0800 (PST)
Received: from [192.168.1.13] (aehn132.neoplus.adsl.tpnet.pl [79.186.195.132])
        by mx.google.com with ESMTPS id j11sm3868138bka.0.2010.12.20.15.06.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Dec 2010 15:06:16 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20101220200203.GA24163@burratino>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164016>

On Mon, 20 Dec 2010, Jonathan Nieder wrote:

> diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
> index 79d7eeb..feb09e5 100644
> --- a/gitweb/static/gitweb.css
> +++ b/gitweb/static/gitweb.css
> @@ -579,6 +579,19 @@ div.remote {
> =A0=A0=A0=A0=A0=A0=A0=A0display: inline-block;
> =A0}
> =A0
> +/*
> + * <b>URL:</b>=A0http://www.example.com/
> + * <b>Fetch URL:</b>=A0=A0=A0http://www.example.com/
> + * <b>Push URL:</b>=A0=A0=A0=A0http://www.example.com/
> + */
> +table.remote_urls tr.metadata_url td.metadata_tag:after {
> +=A0=A0=A0=A0=A0=A0=A0content: ":"
> +}

I'd rather not use 'content' (pseudo-)property, as not all web
browsers implement it,... unless of course not having it doesn't
make view worse.

--=20
Jakub Narebski
Poland
