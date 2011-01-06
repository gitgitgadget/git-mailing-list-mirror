From: Junio C Hamano <gitster@pobox.com>
Subject: Re: --find-copies-harder finds fewer copies/renames than -C does
Date: Thu, 06 Jan 2011 12:42:02 -0800
Message-ID: <7vhbdlahnp.fsf@alter.siamese.dyndns.org>
References: <1juopju.rh4v4z97i9hmM%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: lists@haller-berlin.de (Stefan Haller)
X-From: git-owner@vger.kernel.org Thu Jan 06 21:42:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pawf3-0001MW-SI
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 21:42:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617Ab1AFUmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 15:42:12 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35446 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752407Ab1AFUmL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 15:42:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7D6312923;
	Thu,  6 Jan 2011 15:42:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XvfQ/3Sz+Kqe+u9Ke8n1/Z5HJrc=; b=c7ZB/R
	wRWI3+H5i0EwgezBmGXf2kOjQiMyv8ejPLCt8kcsSqbw4i9oPisCNisx7gdf0Tcb
	al+sqEVP92TDb21uoLprZ1B/EogUadrSclk3Jl1V4bozWriZ7kujIaKqvdi533UE
	biUlLmYB7MG8w/9pyIkbO/BWOPjlfBU4eCNqs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xNeu72AM2CxnyTqocFc+84s9jC3CC+5E
	7tXKQyrTvMToA3uWdtlNNRxfNsexXc5mXPF+A8SQUjtolRjWOaHGpVul1vNWCRGQ
	G7RA1KCkgs+8/Bjg7gLy60SkHAhlj8emIcfhqhNenOeDLuRMBo2PqvDbQyEFOuDW
	386X7W3pMLs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5AA812914;
	Thu,  6 Jan 2011 15:42:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 75D7A290B; Thu,  6 Jan 2011
 15:42:41 -0500 (EST)
In-Reply-To: <1juopju.rh4v4z97i9hmM%lists@haller-berlin.de> (Stefan Haller's
 message of "Thu\, 6 Jan 2011 17\:54\:06 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8356A050-19D5-11E0-AE53-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164669>

lists@haller-berlin.de (Stefan Haller) writes:

> But what about the suggestion of falling back to -C if
> --find-copies-harder exceeds the rename limit, but -C does not?
> Wouldn't that be the desired behaviour?

Maybe.  Patches welcome ;-)
