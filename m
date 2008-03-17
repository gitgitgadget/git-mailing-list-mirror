From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH 2/3] gitweb: Support caching projects list
Date: Mon, 17 Mar 2008 19:52:13 +0100
Message-ID: <200803171952.15186.jnareb@gmail.com>
References: <1205766570-13550-1-git-send-email-jnareb@gmail.com> <1205766570-13550-3-git-send-email-jnareb@gmail.com> <20080317165405.GD18624@mail-vs.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	"J.H." <warthog19@eaglescrag.net>
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Mon Mar 17 19:53:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbKSQ-0004fs-IG
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 19:53:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbYCQSwf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Mar 2008 14:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751941AbYCQSwf
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 14:52:35 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:14688 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbYCQSwe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 14:52:34 -0400
Received: by ug-out-1314.google.com with SMTP id z38so690967ugc.16
        for <git@vger.kernel.org>; Mon, 17 Mar 2008 11:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=pxWyWJrgGVTOav/2UrZbDk4BmvuHiLkPyHY0vK7ak/Y=;
        b=D75JD1LiFQGNjx5zIF/vng+HpDEl/eHzzTL2JA6pZoQU51Cw6miDDRIf3oFZ0t3vmH0D55z70nGw3y6wEnEZcwjvIdeS7UKvkSjk37DqXPShatn7W3d2AsmNHKIwyqNUglTTqtMqwQRr7h/+woGmTvO90/PXtgYDItljdrHFmj0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=a4GK9aV8pgzQJqT80n6s/behI9mjxrTgyttOr+6Lieq0knw5/sNHcHlf7HNTBTF5afpa6LDg2Z1r61GMfSjSX1m5NN1gZVmlNty+tcCYtECb6xoEHhKXvW4QPHs5cE3BYvoujrGQwX3OTWh9H1eFtVGJ/N9zgjgUfh41pRbbv4Y=
Received: by 10.78.189.5 with SMTP id m5mr1621523huf.74.1205779938456;
        Mon, 17 Mar 2008 11:52:18 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.232.138])
        by mx.google.com with ESMTPS id e9sm714227muf.0.2008.03.17.11.52.15
        (version=SSLv3 cipher=OTHER);
        Mon, 17 Mar 2008 11:52:17 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080317165405.GD18624@mail-vs.djpig.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77453>

Dnia poniedzia=B3ek 17. marca 2008 17:54, Frank Lichtenheld napisa=B3:

>At the very least you should:
[...]
> =A0- Check if the file is owned by the uid gitweb is running under an=
d
> =A0 =A0not word-writable.

UID ($>) or PID ($$) should be equal to cache owner: stat($file)->uid?

--=20
Jakub Narebski
Poland
