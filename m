From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cvsimport still not working with cvsnt
Date: Tue, 22 Feb 2011 16:45:25 -0800
Message-ID: <7vaahnbmu2.fsf@alter.siamese.dyndns.org>
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
 <4D644FEE.5030004@burntmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin@laptop.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Emil Medve <Emilian.Medve@freescale.com>,
	git <git@vger.kernel.org>, Pascal Obry <pascal@obry.net>,
	Clemens Buchacher <drizzd@aon.at>
To: Guy Rouillier <guyr@burntmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 23 01:45:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps2rV-0001zp-Tv
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 01:45:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754717Ab1BWApp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 19:45:45 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58382 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753461Ab1BWApo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 19:45:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A026748C6;
	Tue, 22 Feb 2011 19:46:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=68gosf26gqZn+3M1sk8Xg7Ru58w=; b=eleYzh
	pnCHwFksCL9tP/3TIb58/R0Ez4nMLOs8/G+HZ5ozn3zJMhZMJDJzGkMT3a8RjQj9
	vg9OYQZ9NG7FPyPgCOJawg4LgFRvp14GfuE5KrD8/YlPF5ynZBhcOVypRoxpfj7w
	JkQvi04K3iMIQCE0olQ4KsLdN08VZogSHvNAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i7MzjSlPkX8JI9vX8lVkJS8UVSb1Uk5t
	uN1ec0G2RF4jSUIAeIsZ5HUfPPPBvI3a+kamwt4yfmxBin5DTqHPHBGi4hF1PABG
	dw4bq4SE5ejfkI2SH4gst7pTXDCrL/3YTiNJ+Vw71U33WYkbY1B799vyCFPqy4oz
	VZlhHaaW7w0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3244048C4;
	Tue, 22 Feb 2011 19:46:49 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0E78748C3; Tue, 22 Feb 2011
 19:46:39 -0500 (EST)
In-Reply-To: <4D644FEE.5030004@burntmail.com> (Guy Rouillier's message of
 "Tue\, 22 Feb 2011 19\:08\:14 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 65C125CA-3EE6-11E0-B8CE-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167668>

Guy Rouillier <guyr@burntmail.com> writes:

> To answer Junio's question, I'm looking at the CVSNT code now
> (GlobalSettings.cpp, if anyone is interested.)  The password is stored
> in a general fashion like any other user-specified value.  So, the
> authors elected to use a properties file format of key=value.  That is
> as valid a format as any other.

As you dug that far, could you find out what happens when cvsroot contains
an equal-sign character in its path component?

I am starting to suspect that we do need two separate codepaths, and we
would need to split out the logic to find matching password entry given a
cvsroot value into a separate function to keep our sanity after all.
