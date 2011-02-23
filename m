From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cvsimport still not working with cvsnt
Date: Tue, 22 Feb 2011 16:42:19 -0800
Message-ID: <7vei6zbmz8.fsf@alter.siamese.dyndns.org>
References: <4D0ED5EC.9020402@burntmail.com>
 <20101220213654.GA24628@burratino> <4D112586.2060904@Freescale.com>
 <4D119015.6020207@burntmail.com> <4D2AB63D.7040803@burntmail.com>
 <AANLkTikreDJmUPfwNJ2ABivrafjvQNN6WrytNMAcse4A@mail.gmail.com>
 <4D2FEF49.8070205@burntmail.com> <20110114074449.GA11175@burratino>
 <7v8vynnokt.fsf@alter.siamese.dyndns.org> <4D450655.5090501@burntmail.com>
 <AANLkTik0Mp=Ww_+ZN_jw6t4gsFwLo1UTw5JOpho8bCd=@mail.gmail.com>
 <7vhbcb35xk.fsf@alter.siamese.dyndns.org> <4D5E1116.7040501@burntmail.com>
 <7voc69p4xu.fsf@alter.siamese.dyndns.org> <4D5F6E97.4000402@burntmail.com>
 <7vy65bkw72.fsf@alter.siamese.dyndns.org> <4D61EA4B.3020708@burntmail.com>
 <7vtyfxgdz2.fsf@alter.siamese.dyndns.org>
 <7vipwbbrcc.fsf@alter.siamese.dyndns.org>
 <AANLkTinUtUNGO3NK=JPTqnwcTtPMYjmLw82wJZ5nC-32@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Guy Rouillier <guyr@burntmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Emil Medve <Emilian.Medve@freescale.com>,
	git <git@vger.kernel.org>, Pascal Obry <pascal@obry.net>,
	Clemens Buchacher <drizzd@aon.at>
To: Martin Langhoff <martin@laptop.org>
X-From: git-owner@vger.kernel.org Wed Feb 23 01:42:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps2oX-0000qC-RK
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 01:42:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754238Ab1BWAml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 19:42:41 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56130 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752808Ab1BWAmk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 19:42:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B0C63487C;
	Tue, 22 Feb 2011 19:43:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yW2Vpy5orFo1DdHpKRxybSadJyA=; b=mb+hRN
	On+YmidGPKmJt5IYaE1NGvUSzNx6VI6TTeg+JkpZp2Up2Kr5Su3+iivihQHU8yZF
	EvafOSf15oV1ZNW14kvhSSY19n+4H7g37GyU4aeQ1436r7DlYXjV3fLRasGztPbL
	k+UjtmDWKhOqa1W87flwlnPl2X8N5cgfsrzfw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rR0MWpeeN7128LvA83KNztFwpwoGdBTM
	XpjMMsSuATnJVGBaJNk+Dbw/HKdcHDvPMR5vrRX5zyQnMu5w6t3l6M9G83iknIli
	vVdtAZ4VBvLXDHbAFZa0deZpdSQUGEcfGy7yDU6393QbhiIj6rwjrbWSzZ2eF7KJ
	BLGZhlb0AT8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3D7554879;
	Tue, 22 Feb 2011 19:43:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 122684870; Tue, 22 Feb 2011
 19:43:33 -0500 (EST)
In-Reply-To: <AANLkTinUtUNGO3NK=JPTqnwcTtPMYjmLw82wJZ5nC-32@mail.gmail.com>
 (Martin Langhoff's message of "Tue\, 22 Feb 2011 18\:50\:09 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F78332C4-3EE5-11E0-8605-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167667>

Martin Langhoff <martin@laptop.org> writes:

> On Tue, Feb 22, 2011 at 6:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Even though I don't deeply care about what CVSNT does...
> ...
>> Does anybody know why?  Only to make things incompatible, perhaps? ;-)
>
> A brief googling around shows that it also stores it in the Windows registry.

Yes, I saw that too.  I actually also got the impression that registry is
the primary location for cvsnt (hence I suspect .cvs/cvspass support might
be secondary and would not be surprised if it were sub-par).
