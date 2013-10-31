From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] "error: cache entry has null sha1"
Date: Thu, 31 Oct 2013 11:07:53 -0700
Message-ID: <xmqq8ux98gau.fsf@gitster.dls.corp.google.com>
References: <20131031063451.GA5513@sigill.intra.peff.net>
	<20131031063626.GB5812@sigill.intra.peff.net>
	<xmqqeh719xgq.fsf_-_@gitster.dls.corp.google.com>
	<20131031171539.GA19142@sigill.intra.peff.net>
	<20131031172116.GA19428@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 31 19:08:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbwfA-0003WL-QD
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 19:08:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754503Ab3JaSIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 14:08:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34852 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755204Ab3JaSIC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 14:08:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 779B44E2D0;
	Thu, 31 Oct 2013 14:07:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/EsfMOjgPy/1zAXdVBJpkvODYNM=; b=aexa5k
	DBKtlkk/829uyEbkZK/aRcbePwvLaPhA+ouiNwFqCO71VyhUiOU36rMo72Udlzq8
	kUcVx+XgbmkS3D1zGlBK8iYZxG4VSZIBDea4WeimRUnD6rYbe5fd+P2Ayv3Ig9pB
	gZ37Jmk/Q+a4pcxigo9WCU8N9ApZo27/khJVI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HGHoy/7o5JVAqc6goDo9O/KMP96M7Brl
	dX9G4s0rFNe15RY6peQ8OkZeocqkyV/LV6GDKARm0k4+fE8+JN5LtipFcAGBc/tM
	MmEXCcEG5mGS/BLKM1r8E583H+p2m8caD1Oy7hh1osZzkDiUScGdBscZUyZf9ir3
	YhpDU6+4MJE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 692054E2CF;
	Thu, 31 Oct 2013 14:07:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 910564E2CB;
	Thu, 31 Oct 2013 14:07:55 -0400 (EDT)
In-Reply-To: <20131031172116.GA19428@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 31 Oct 2013 13:21:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5DE39DF2-4257-11E3-B026-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237138>

Thanks for the pointers.
