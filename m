From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 02/11] Makefile: fold MISC_H into LIB_H
Date: Wed, 20 Jun 2012 13:01:58 -0700
Message-ID: <7vsjdpu4zt.fsf@alter.siamese.dyndns.org>
References: <20120620182855.GA26948@sigill.intra.peff.net>
 <20120620183055.GB30995@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 20 22:02:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShR6N-0001KE-7z
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 22:02:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219Ab2FTUCC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 16:02:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42878 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757693Ab2FTUCB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 16:02:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A1DE38118;
	Wed, 20 Jun 2012 16:02:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VLL7+19fE5f+FRfTKz6eD2eQRgo=; b=VL7A5q
	7WJcbz31NSCBbhFMhlALqfBCuwWfga2YB2uPLQTwqkWuJgcttE3H+5iclpWvsxR0
	xVgpgMRVT7K4U48gkt/MX+32cZaEVC6KrPiOiTNX+i9nVq+EjYstHg16Ntxz2l4X
	qoxa6SiA0S6S5sat1QC1GR8LR8u1SpUU9EQDE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xgowQiA0wrt/x9swSNK4lUGLfY3Oewkm
	B+6G98cV+y5wONr3Tvc1h0RpxSR2f2uI9FqMGNn1+dDqJbYWqxryksDFw9qOILat
	RajqtN57l74h8t/CLfcvYb6ung/YVxLS1E/I+o83AurtbaeIsC4Nw2GgPmywo5xr
	VtWfg+8NQOs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 98A848117;
	Wed, 20 Jun 2012 16:02:00 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 145618116; Wed, 20 Jun 2012
 16:01:59 -0400 (EDT)
In-Reply-To: <20120620183055.GB30995@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 20 Jun 2012 14:30:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CBCEA42E-BB12-11E1-8986-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200353>

Jeff King <peff@peff.net> writes:

> Let's just fold MISC_H into LIB_H and get rid of these
> manual rules. The worst case is some extra compilation, but
> even that is unlikely to matter due to the reasons above.

Yay.  Thanks.
