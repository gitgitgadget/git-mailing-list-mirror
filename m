From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH] documentation: add git transport security notice
Date: Tue, 25 Jun 2013 00:27:03 +0200
Message-ID: <20130624222703.GA32270@paksenarrion.iveqy.com>
References: <1372069414-12601-1-git-send-email-frase@frase.id.au>
 <7vppvbbhoi.fsf@alter.siamese.dyndns.org>
 <20130624215733.GU2457@bacardi.hollandpark.frase.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Fraser Tweedale <frase@frase.id.au>
X-From: git-owner@vger.kernel.org Tue Jun 25 00:27:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrFEH-0002FO-7p
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 00:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044Ab3FXW1R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Jun 2013 18:27:17 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:37486 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824Ab3FXW1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 18:27:16 -0400
Received: by mail-la0-f48.google.com with SMTP id lx15so10939270lab.21
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 15:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GAqLCkTrm5sJarCncKLhDqN6c7VkFfCnpDUNI5t/D4Y=;
        b=SuvmnRVp3omqkN8zlGMG5lCeokYaV9HtDpmWlxvPmTVV8xFDS6HWV2lbQZmpeo0lv4
         NpPB+Ptt5b2kg3CTVlJKyBsE/5ddpe6AE16iIPITyXbe6PAGAqfdHeeN5e8RLn8MPY0z
         EC3jlCBfdIGiVsOPCzNTAVX4DRkhxW4H8hJI+jukn+UywiVonz5Io9fcI0o/EwqoD3qx
         xT5O2QCVHVCzO8ZabyhI2DRnwSHQRI+kYgW3yyuWizrj4BLndXaFpsBdh4bE+PjYbu+b
         zIl169Y6UyLJ49WRQ1wjQOAXl2EcrmehWnsvLJB2Mf91NHlRGZHhhBPoYvGsbbfooQnh
         ssJQ==
X-Received: by 10.152.170.197 with SMTP id ao5mr12553454lac.35.1372112830361;
        Mon, 24 Jun 2013 15:27:10 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id ea14sm7427228lbb.11.2013.06.24.15.27.09
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 24 Jun 2013 15:27:09 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UrFDz-0008Uo-2L; Tue, 25 Jun 2013 00:27:03 +0200
Content-Disposition: inline
In-Reply-To: <20130624215733.GU2457@bacardi.hollandpark.frase.id.au>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228913>

On Tue, Jun 25, 2013 at 07:57:35AM +1000, Fraser Tweedale wrote:
>  The git transport is insecure and should be used with caution on
>  unsecured networks.

I don't understand this. How is git:// insecure?

It's protocol with no authentication, because it's a protocol used for
public sharing.

The only point of encrypt git:// would be to verify that the recieved
data has not been altered along the way. However you can always trust
that the end result is an valid copy of the remote.

To me that means that it's as secure as a non-authentication protocoll
needs to be.

How would an "evil network" be able to do any harm to a git transport
over git://?

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
