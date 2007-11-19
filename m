From: Brian Swetland <swetland@google.com>
Subject: Re: [BUG] encoding problem with format-patch + send-email
Date: Mon, 19 Nov 2007 02:58:32 -0800
Organization: Google, Inc.
Message-ID: <20071119105832.GA10177@bulgaria>
References: <20071115105726.GA18555@bre-cln-ukleine.digi.com> <20071116104907.GA13087@sigill.intra.peff.net> <7vlk8xwvbu.fsf@gitster.siamese.dyndns.org> <20071119104950.GB8645@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Russell King - ARM Linu
X-From: git-owner@vger.kernel.org Mon Nov 19 12:01:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu4N8-0005PH-Mn
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 12:00:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbXKSLAg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Nov 2007 06:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751930AbXKSLAg
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 06:00:36 -0500
Received: from smtp-out.google.com ([216.239.33.17]:12006 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbXKSLAf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 06:00:35 -0500
Received: from zps75.corp.google.com (zps75.corp.google.com [172.25.146.75])
	by smtp-out.google.com with ESMTP id lAJAxjWb026522;
	Mon, 19 Nov 2007 10:59:46 GMT
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:to:subject:message-id:references:
	mime-version:content-type:content-disposition:
	content-transfer-encoding:in-reply-to:organization:user-agent;
	b=xrbcc8a+KrZv0urYtGwI0pgk6305DaTdwIZqkbZ1UELzIEmKG/X3DVwnDlAm7DDel
	LrD/6lJ6wBNDXUjfmCiow==
Received: from bulgaria (bulgaria.corp.google.com [172.18.102.38])
	by zps75.corp.google.com with ESMTP id lAJAxecM022622;
	Mon, 19 Nov 2007 02:59:40 -0800
Received: by bulgaria (Postfix, from userid 1000)
	id 6F9058F44C; Mon, 19 Nov 2007 02:58:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20071119104950.GB8645@informatik.uni-freiburg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65426>


[Uwe Kleine-K=F6nig <ukleinek@informatik.uni-freiburg.de>]
> Hello Jeff
>=20
> Brian sent another mail to the linux-arm-kernel mailing list, now
> spotting:
>=20
> 	Content-Type: text/plain; charset=3DUTF-8
>=20
> but no Content-Transfer-Encoding:.  This yield a 7bit mail with 8bit
> characters.

I actually tacked the Content-Type on by hand on that one.

I haven't had a chance to try the updated send-email, so it may well
do the right thing.

Brian
