From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] [WIP] Allow running git init on a remote repository
 specification.
Date: Tue, 16 Nov 2010 09:58:20 -0800
Message-ID: <7vbp5pi20z.fsf@alter.siamese.dyndns.org>
References: <cover.1289561504.git.peter@softwolves.pp.se>
 <ba28273f7efb0fa3e403a8a9d7b923b61bb62ce3.1289561504.git.peter@softwolves.pp.se> <AANLkTimqLeyDW9sJVR8NPOXQ1Xdz+kRmu9-8fPn1yj_j@mail.gmail.com> <alpine.DEB.2.00.1011160632280.20293@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Scott Chacon <schacon@gmail.com>, Jeff King <peff@peff.net>,
	Git <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Nov 16 18:58:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIPnl-0005ev-Ta
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 18:58:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756174Ab0KPR6g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 12:58:36 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43071 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696Ab0KPR6g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 12:58:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 563373F33;
	Tue, 16 Nov 2010 12:58:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oIcdYeNB07T8s9M1tMjqp9YDILE=; b=w5DRUK
	edRZrw5kVfY8f0riYU7A48Q6lZSX/vIIebMdhoFkCYabYqVzIXz1P5iL6owiCONl
	4fqajjyGlXzD/kLiDtVMHyZHU2erxtl2I49Q+3QqCSfzQ6bVLsxVo9Mr+U6jUQbg
	GjKMNc2/LdvykHlG4HmiX/BmyxrMbCPiTpT8M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XY/OPMSJcbBzE631MDkke4BLg50xJG+R
	65VN27LZooQSd0ZDg1HhMlT9A7TAm+irGu2eMjdcJykvnO4huCS5eZzIR8IJrV+a
	gm9TFJ5uf15wr1pZr2bNML+7ZgLWxUspaC59KqxzMKfLCpp+PhMI0FL0JlpvEjaf
	3zHT4LYVJpc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 52F713F31;
	Tue, 16 Nov 2010 12:58:39 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 808813F30; Tue, 16 Nov 2010
 12:58:32 -0500 (EST)
In-Reply-To: <alpine.DEB.2.00.1011160632280.20293@ds9.cixit.se> (Peter
 Krefting's message of "Tue\, 16 Nov 2010 06\:33\:50 +0100 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 242B9DC6-F1AB-11DF-A6C0-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161571>

Peter Krefting <peter@softwolves.pp.se> writes:

> Any objections to the first part of the patch (that detects attempts
> at remote init and rejects them)?

Yes.

Didn't we discuss this long time ago and decided, if anything is to be
done, it would be something like "the first push creates"?
