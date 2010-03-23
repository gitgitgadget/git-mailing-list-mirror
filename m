From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] send-email: lazily assign editor variable
Date: Mon, 22 Mar 2010 19:58:06 -0500
Message-ID: <20100323005806.GA9335@progeny.tock>
References: <20100322145947.GA1709@pengutronix.de>
 <eb0d92cf28820eb9783e789a8c4c62c3af4dd0d0.1269274203.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 23 01:58:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtsRo-0001ix-OQ
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 01:58:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756167Ab0CWA6O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Mar 2010 20:58:14 -0400
Received: from mail-yx0-f182.google.com ([209.85.210.182]:64567 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755165Ab0CWA6M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 20:58:12 -0400
Received: by yxe12 with SMTP id 12so2067144yxe.33
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 17:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=/b98Yaf7/s9W+nu6PE8EGqH2C1o2bqsLWoZ/eScoCIA=;
        b=Iqfg0LaBxMbdDm4sPYQ2Bq3e9jmjbZBXGl0wlgd71P+QRBA8I66lkjsDG8SuVx2qMj
         zZrVGlXrV5Mj+h3Z5V96zUsKVox57yguZflpBnYblbczcz2CypsRVmTSgI3Q4g104qO6
         ++LOz84vl0Q0molXKz4Rt0r+RSLjomi2UfG3U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=TPpfcl2YPBEBbdbQw8Zh/G12irVLrYl2daPGzSc5grPF1qDDMRm0VKOOrAly/MCwuP
         VqRwmG8+CnyOlGcpmHSxKCWU6k7t1fxZ97UNyzp6yD1I5ERA5bMh0T4XfhkF0jAAE3ew
         MsTo7Wz7Biqdftc/f7/YMA5purIbLd68tXhbM=
Received: by 10.101.103.8 with SMTP id f8mr4791375anm.95.1269305891758;
        Mon, 22 Mar 2010 17:58:11 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm3554673iwn.9.2010.03.22.17.58.09
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 22 Mar 2010 17:58:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <eb0d92cf28820eb9783e789a8c4c62c3af4dd0d0.1269274203.git.git@drmicha.warpmail.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142981>

Michael J Gruber wrote:

> b4479f0 (add -i, send-email, svn, p4, etc: use "git var GIT_EDITOR",
> 2009-10-30) introduced the use of git var GIT_EDITOR which may lead t=
o
> problems when send-mail is used without a tty.
>=20
> Therefore, use git var GIT_EDITOR only when we actually edit somethin=
g.
>=20
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> Reported-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

=46WIW:

  Acked-by: Jonathan Nieder <jrnieder@gmail.com>

Next time, please CC me.

Thanks,
Jonathan
