From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] get_sha1: support ref^{/regex} syntax
Date: Sun, 12 Dec 2010 11:38:50 -0600
Message-ID: <20101212173850.GB19293@burratino>
References: <1292151419-30678-1-git-send-email-pclouds@gmail.com>
 <1292151419-30678-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 12 18:39:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRpt4-0007p9-Cf
	for gcvg-git-2@lo.gmane.org; Sun, 12 Dec 2010 18:39:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752963Ab0LLRjA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Dec 2010 12:39:00 -0500
Received: from mail-yx0-f194.google.com ([209.85.213.194]:37153 "EHLO
	mail-yx0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861Ab0LLRjA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Dec 2010 12:39:00 -0500
Received: by yxd5 with SMTP id 5so1842345yxd.1
        for <git@vger.kernel.org>; Sun, 12 Dec 2010 09:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=+oU8phROk0hQ0Mj/tq/a0OZ/p+QcxLSDt2PlbBEp//M=;
        b=FVTU9vS3SrOtC/0shOpMO8rVjFnEQfKIpG7nZ8lck/LMKyo67T2/gK7ZD/++hyitwz
         xHHccEYrc8hV+73h5Dxe7FES2c08nOLCOLK9f+S8CzpC1P9SNYJ4yXcgxV4EjpZvv6r4
         +Nk9sSpUBjOQWuNauobyof96FlA3Jx+rQ7sKE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Yn+jjnJhoqvwDPp3n8buEcrEkSZ2IZ4/Gnr630tNfciWLze/mHzEXMchzodzgecpSp
         cHU//F8TFpu767LECaOlTqCOden3cqyEPGbYNij/IxK9IuZlEntTzdVD52w7M5GSr+ew
         XQMQKZTBWEMSkEa6UEju3cWZbs3zYW+w4GmL0=
Received: by 10.100.13.11 with SMTP id 11mr2049926anm.20.1292175539502;
        Sun, 12 Dec 2010 09:38:59 -0800 (PST)
Received: from burratino (adsl-69-209-48-248.dsl.chcgil.sbcglobal.net [69.209.48.248])
        by mx.google.com with ESMTPS id t1sm6236431ano.3.2010.12.12.09.38.57
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 12 Dec 2010 09:38:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1292151419-30678-2-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163488>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> This works like :/ syntax, but only limited to one ref.

Limited to the ancestors of one commit, not one ref, right?

> --- /dev/null
> +++ b/t/t1511-rev-parse-caret.sh
> @@ -0,0 +1,73 @@

Nice.
