From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] setup: always honor GIT_WORK_TREE and core.worktree
Date: Fri, 21 Jan 2011 15:01:56 -0800
Message-ID: <7vpqrpoo7v.fsf@alter.siamese.dyndns.org>
References: <1290785563-15339-40-git-send-email-pclouds@gmail.com>
 <20110118074400.GA4185@burratino> <7v1v4aknij.fsf@alter.siamese.dyndns.org>
 <20110119123732.GA23222@burratino> <20110119124230.GD23222@burratino>
 <AANLkTinE5gNZM_HDJq31qs5ARJn-DrO9HW66cszTayPa@mail.gmail.com>
 <20110119193116.GB30618@burratino> <7vpqrssl5d.fsf@alter.siamese.dyndns.org>
 <7v39omotxg.fsf@alter.siamese.dyndns.org>
 <7vtyh1oqy8.fsf@alter.siamese.dyndns.org> <20110121220532.GA23695@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Maaartin <grajcar1@seznam.cz>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 22 00:02:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgPzn-0002iL-VW
	for gcvg-git-2@lo.gmane.org; Sat, 22 Jan 2011 00:02:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753463Ab1AUXCL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jan 2011 18:02:11 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54662 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903Ab1AUXCK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jan 2011 18:02:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1A3903566;
	Fri, 21 Jan 2011 18:02:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Bemo6wIuQEFMcDHaPWSwQLK3nwY=; b=OYloij
	FsKIoidcmelLoFmR4z5faQ0RV4fu3HXwmEQc5K/amWL2UEs37q/MT6V+Zi7AU6PJ
	pp/CXaU7j0SPri3FDnlpvJ2SLWcGzx2vIMIG3GcBTu1B0ty+c628N8yivzn17svM
	8ZhgJakLyCISObj3b65O7Vr6PvKWaYjNFYkss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eDSnqlkSm1YHbHBlN0vxs5csYzhkTZm3
	9LrTbYUu4lN9GHHPlOm0FaSxJFDdI/ddkYHcRFQXClApfKJvF2/qFMl+ik35NTFO
	VJnQUPy9CCnNiprqvj0QajUczc9t2RDF5m79oYNc2iMukjXt2IspjIAPezr52ckU
	vmU7Fg+HKOM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 773A93565;
	Fri, 21 Jan 2011 18:02:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D65323561; Fri, 21 Jan 2011
 18:02:44 -0500 (EST)
In-Reply-To: <20110121220532.GA23695@burratino> (Jonathan Nieder's message of
 "Fri\, 21 Jan 2011 16\:05\:33 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 92832394-25B2-11E0-B74A-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165400>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>> Perhaps squash this into, or apply on top of, your 3/3?
>
> Looks good to me.  I'd suggest squashing and using your commit
> message for the combined commit.

Thanks, will do.
