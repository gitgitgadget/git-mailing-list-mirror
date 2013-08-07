From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH v4 5/5] rm: delete .gitmodules entry of submodules
 removed from the work tree
Date: Wed, 7 Aug 2013 20:28:09 +0200
Message-ID: <20130807182809.GA15123@paksenarrion.iveqy.com>
References: <51F8187F.7040603@web.de>
 <51F81957.1000709@web.de>
 <52014B4D.3090602@web.de>
 <7v8v0efrs3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Fredrik Gustafsson <iveqy@iveqy.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 07 20:25:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V78Pp-0001Li-EH
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 20:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932742Ab3HGSYx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Aug 2013 14:24:53 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:34347 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932194Ab3HGSYw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 14:24:52 -0400
Received: by mail-lb0-f172.google.com with SMTP id o7so1797410lbv.17
        for <git@vger.kernel.org>; Wed, 07 Aug 2013 11:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PDHp0uW9lZqKtTpCSLzBqh+0y5MnWVL70Lt0x0NGbVY=;
        b=eFnK/JreCav1/B3qHHIHVjSTPLrgDSNncc/4MeIQ9gl51mLLLIuISD55DV4dapTOLr
         4MAb/0tcpCrunBoLNnzqinadZf4hqSwaX45Ivucn3EfzKgAAItDCHTPoIu3h0CrcQSmX
         WHmbSLjbxAH/MlGRxSDJ71qq5y/UKS3ttTsxO1QbaSEcl1UXPe9x2cviu5mG7A3WX62w
         P1EiK+nM4lAuTFZTLg1e+M2zbyMaZO2n+fvKYbgyZLW/NlN/XCH/3iRGeEhHE9fZ89V9
         aZEk0q+HJlpjO/Q/mPwL+1oINf5nBGp9xu/C14gCq+mO7WcuY67xf5KA4ddBphnNtsmL
         2q0w==
X-Received: by 10.112.156.34 with SMTP id wb2mr250920lbb.79.1375899891359;
        Wed, 07 Aug 2013 11:24:51 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id l10sm3657939lbh.13.2013.08.07.11.24.50
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 07 Aug 2013 11:24:50 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1V78Sv-0005fd-MR; Wed, 07 Aug 2013 20:28:09 +0200
Content-Disposition: inline
In-Reply-To: <7v8v0efrs3.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231841>

On Tue, Aug 06, 2013 at 02:11:56PM -0700, Junio C Hamano wrote:
> Thanks, will replace the top two commits and queue.  Looks like we
> are getting ready for 'next'?

I'm a bit curious about if we should move towards a reentrent libgit
(which would for example make multithreading easier) or not.

If so, I suggest that this patch only use die() in builtin/. However I
know that there's a lot of die() all over libgit today, I'm curious
about what direction we're heading.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
