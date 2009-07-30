From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 5/5] unpack_trees(): add support for sparse checkout
Date: Thu, 30 Jul 2009 02:42:09 +0200
Message-ID: <200907300242.09950.jnareb@gmail.com>
References: <1248850154-5469-1-git-send-email-pclouds@gmail.com> <m3zlan1zhv.fsf@localhost.localdomain> <fcaeb9bf0907291632n418508ccke6ad274211690e59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 02:42:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWJis-00046y-IP
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 02:42:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754749AbZG3AmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 20:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754198AbZG3AmK
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 20:42:10 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:34209 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbZG3AmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 20:42:09 -0400
Received: by bwz19 with SMTP id 19so303668bwz.37
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 17:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=PsXcods44jnnaaqVFkswNh12+a3cSFppVrWIGaiLVHg=;
        b=OclwjIkn6fbXYZd23HsmNWjAqHqfhZpT5QrT3saOMGvjCyfXoS9tx56kzbEHlg+r2k
         +vbIlQdVt+36+SquGvOaXX4vI8Ds3Hv2zQgy9hFY+qLi3HaZlODCitb5J/g8hMbsg8TN
         gO/Q6+ROyMVSmrbe9kzc/DZEsbj/YfIz5yBWA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ma1qCqXiqt3LZL48RUvw85oPevBAN1a1lObotjJKs8/LffN1JhNCIzs7Xgnlug4nWx
         I1wFJDxCg7VwnZ6IeBCmVBDeW916OwRUf56zSJnVDVyz8F9TI0taEdo3N3lvDYNSrZAa
         WaBTK/0tCC9i5FAw0PM72ub4eIpEje5ubeb50=
Received: by 10.103.52.11 with SMTP id e11mr281430muk.19.1248914528547;
        Wed, 29 Jul 2009 17:42:08 -0700 (PDT)
Received: from ?192.168.1.13? (abvq124.neoplus.adsl.tpnet.pl [83.8.214.124])
        by mx.google.com with ESMTPS id w5sm1692880mue.34.2009.07.29.17.42.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Jul 2009 17:42:07 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <fcaeb9bf0907291632n418508ccke6ad274211690e59@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124425>

On Thu, 30 July 2009, Nguyen Thai Ngoc Duy wrote:
> 2009/7/29 Jakub Narebski <jnareb@gmail.com>:

> > Signoff (also in some other patches in this series)?
> 
> This series is mainly for taking input on how git-shape-workdir should
> behave, what format is good... That's why I did not sign off. Anyway
> the series is not really well tested (and obvious lacks tests)

In that case it would be IMHO a good idea to mark those patches also
by using "[PATCH/RFC m/n] ..." or "[RFC/PATCH m/n] ..." in subject.

-- 
Jakub Narebski
Poland
