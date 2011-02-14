From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Consistent terminology: cached/staged/index
Date: Sun, 13 Feb 2011 21:57:19 -0800
Message-ID: <7vr5bbupj4.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
 <20110213193738.GA26868@elie> <7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
 <87k4h34bhj.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Mon Feb 14 06:57:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PorRL-0004Ba-1N
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 06:57:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079Ab1BNF5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 00:57:34 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47428 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911Ab1BNF5c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 00:57:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E9A3A3E96;
	Mon, 14 Feb 2011 00:58:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rSROTAJhp9MXMdJa+A1EKrb+PC0=; b=NsTZrw
	3uG4PMHQwOCVnhSa5TPDN0ae4jCTBLQwuNsixrpY2j2J+Ji4ZEvV3xHCW6PXQdk2
	c17Sq21bGKvhEBZzXDJsG64EvlZuVpkTm+Ww9aZID46y3sKYNC6TOz7NgnA+c+Dc
	g8BJr2xfVXbhPq+tP9X4fzr7TfWQTnllTvTII=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DNdvb5Fvylb920/a+YZ0U2Z0eCoDHrKx
	Tj1BO8o483C42vVNC/F4Szd8f4mQ/BkDcQMkkxjxsoDme0QELa78CDE7E6MOFOt0
	cJ43NSig8b0RVtux23d7Gxfa8RcSWOyt37/Ak+dvD1HFdWSoFKUJpzdhF/xOAgo1
	qlpiTLFZAyU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A90C53E95;
	Mon, 14 Feb 2011 00:58:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6C49F3E94; Mon, 14 Feb 2011
 00:58:25 -0500 (EST)
In-Reply-To: <87k4h34bhj.fsf@catnip.gol.com> (Miles Bader's message of "Mon\,
 14 Feb 2011 11\:05\:12 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 72FD4F40-37FF-11E0-B353-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166689>

Miles Bader <miles@gnu.org> writes:

> Is there a reason a short version of --cached couldn't be added to
> git-diff...?  E.g. "git diff -c"?

I'd suspect that we would like to keep the door open for "diff -c" to do
what the users naturally expect, namely, to produce a patch in the copied
context format.

I don't immediately plan to do so myself, though.
