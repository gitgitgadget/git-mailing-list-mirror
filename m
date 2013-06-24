From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH] documentation: add git transport security notice
Date: Tue, 25 Jun 2013 00:47:08 +0200
Message-ID: <20130624224708.GB32270@paksenarrion.iveqy.com>
References: <1372069414-12601-1-git-send-email-frase@frase.id.au>
 <7vppvbbhoi.fsf@alter.siamese.dyndns.org>
 <20130624215733.GU2457@bacardi.hollandpark.frase.id.au>
 <20130624222703.GA32270@paksenarrion.iveqy.com>
 <7vtxkn5e8o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>,
	Fraser Tweedale <frase@frase.id.au>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 25 00:47:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrFXe-0001cu-5K
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 00:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631Ab3FXWrR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Jun 2013 18:47:17 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:62543 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858Ab3FXWrR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 18:47:17 -0400
Received: by mail-la0-f54.google.com with SMTP id ec20so10956935lab.41
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 15:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BrNxvNRwmLcIMTaaO7ZuAL39Q359psNCW/7+SzE0WKk=;
        b=c7Wodszm7BVrefzoPrcYKewYlVxBvVjw3oHsP2mCN14exfmguceY3O3tvK9Um4GRZp
         w5ZKLE6J/oLY4QXWx+aOYfflMz/Am3xKu4+123kSIcaPJwfuktkFGaveKYpwmjpHvaUt
         KT0RjJJFy5vpyaqjWAu/6NXhPmuzi3dRJi+Bq56Tc726B+Zkju6P6aqT5rKhEAAy3d83
         tA4ECNXAeUj+RMrIxqBjt56SvZdbEjwnhSLfECceDgiHAmo58+YN+V/a2iD1wgX0ly/b
         +QP/NboWGnG8UgrsbZpTk+m6IWftSxA71UrsfKanaq3/INOVke94+AMcdj+xlyaOaK64
         gXIA==
X-Received: by 10.152.8.72 with SMTP id p8mr12633914laa.70.1372114035566;
        Mon, 24 Jun 2013 15:47:15 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id v18sm7303853lbd.5.2013.06.24.15.47.14
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 24 Jun 2013 15:47:14 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UrFXQ-00005K-1c; Tue, 25 Jun 2013 00:47:08 +0200
Content-Disposition: inline
In-Reply-To: <7vtxkn5e8o.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228916>

On Mon, Jun 24, 2013 at 03:35:19PM -0700, Junio C Hamano wrote:
> > I don't understand this. How is git:// insecure?
>=20
> If your DNS is poisoned, or your router is compromised to allow your
> traffic diverted, you may be fetching from somewhere you did not
> intend to.  As I explained in a separate message, that does not
> necessarily result in your repository corrupting, but the result,
> even though it may be "git fsck" clean at the bit level, needs
> additional validation measure, such as signed tags, to be safely
> used to base your further work on top.

Thanks for the explanation. Of course you need to verify your latest
commit sha1 against a trustworthy source. That would be enough to
prevent this scenario, yes?

If we add warnings for git:// should we also add warnings for
http://? Or do we consider that common knowledge?

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
