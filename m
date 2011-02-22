From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cvsimport still not working with cvsnt
Date: Tue, 22 Feb 2011 15:08:03 -0800
Message-ID: <7vipwbbrcc.fsf@alter.siamese.dyndns.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin@laptop.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Emil Medve <Emilian.Medve@freescale.com>,
	git <git@vger.kernel.org>, Pascal Obry <pascal@obry.net>,
	Clemens Buchacher <drizzd@aon.at>
To: Guy Rouillier <guyr@burntmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 23 00:08:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1LI-0008V3-Ny
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:08:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207Ab1BVXIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 18:08:24 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60307 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375Ab1BVXIW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:08:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0CDDC4E15;
	Tue, 22 Feb 2011 18:09:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GqDZsBlA7sugPjJL+aORuEZl3bU=; b=RWAIaq
	7XRDkv5chRfMLEgLhx2Dorio5ki51nAN1DjpDcBZaLu2CqGMNGWnT0it0inheYZ/
	/I8pcda6lERlE+n3dSHa8ddAsrQ8rzG41mJOx4qh6yLD5kGXDea0PjTB1LNqx0UF
	2An0vegDKqJLACoW4J4m9bcKO1pjNxoAEVP2U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DtW+moxGunoAukMGsk8JcdfIoF+lWjdj
	1nL+Do4wEuhAEjd4B79/cMmvebmSFghUrKOgnbA7Dunsu0sN6CKygMVyT0hTd4tv
	TerFtxf3+B2VeTPAH0nU7YnyuOZAXMLSsFjEDwh7KiJlcyGLotARshHVjbzE9eCw
	nIagFgWFWgI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 91DA64E10;
	Tue, 22 Feb 2011 18:09:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9A5CE4DFF; Tue, 22 Feb 2011
 18:09:17 -0500 (EST)
In-Reply-To: <7vtyfxgdz2.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 21 Feb 2011 15\:33\:21 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CB49C45A-3ED8-11E0-A4A5-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167589>

Junio C Hamano <gitster@pobox.com> writes:

> It is probably unlikely to see a SP in the pathname, but I do not think it
> is reasonable to introduce a regression to forbid '=' in the pathname to
> the repository, which we have been supporting since August 2009, when we
> know the patch as-is will regress the use case, and especially when we
> already know a way to code not to regress is not too complex.

Even though I don't deeply care about what CVSNT does, but I am somewhat
curious why this "change SP to =" was done when CVSNT writes out its
$HOME/.cvs/cvspass file.

Does anybody know why?  Only to make things incompatible, perhaps? ;-)

  http://www.selenic.com/pipermail/mercurial/2009-April/025095.html

seems to indicate that somebody next door had a similar experience on
exactly the same issue.
