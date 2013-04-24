From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] git-diff.txt: strip the leading "--" from options template
Date: Wed, 24 Apr 2013 11:15:52 -0700
Message-ID: <7vy5c7dcbr.fsf@alter.siamese.dyndns.org>
References: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
	<1366821216-20868-3-git-send-email-artagnon@gmail.com>
	<20130424164300.GD4119@elie.Belkin>
	<CALkWK0=YNcavQAEiS8-huZ98hp+FTwtU7gqQ7yaoCWA61uWo_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 20:16:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV4EZ-0001Rq-67
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 20:15:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756190Ab3DXSPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 14:15:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42147 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756069Ab3DXSPy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 14:15:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F1A315C26;
	Wed, 24 Apr 2013 18:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ff5zab3wGQ6iGGclO9WL0296+GI=; b=NFnIZG
	kVAPXX+MBsdrWhsnUVCPJUwyVSsC3wy2yOhA21ji2jSJqtRgp5CfJwIkj85zLrHv
	8UYo3HjtCbvW70N+tWFrvHiNXTyJGpyUFDXk1DsDtu4aMT5hDjBsaGZIUTtMkxOe
	Xb27fcofiLAJzHMCqQ25Q4tvDKdAo9mPAhGto=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H6nbBI8dz04Du5X7vcV9/tAE6BK11y1w
	SY9s5wRt1omleZOnDEtEg3g6hezYIWHYZFodgY1gWLVGKdSWKhYMsfAHhEyjkJez
	eQE+uBgMXM85GtCSHFqWmxDqI9Nv8GN1HZI5hbN7YQGlYGq6eDk3mZLZxZQ2Jppk
	kDmsCXdmhoA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22C7015C25;
	Wed, 24 Apr 2013 18:15:54 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC36815C22;
	Wed, 24 Apr 2013 18:15:53 +0000 (UTC)
In-Reply-To: <CALkWK0=YNcavQAEiS8-huZ98hp+FTwtU7gqQ7yaoCWA61uWo_w@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Wed, 24 Apr 2013 22:14:08 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0060DA14-AD0B-11E2-9FC7-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222284>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Jonathan Nieder wrote:
>> Why is it imperative?
>
> Sorry about the thinko; s/imperative/idiomatic/

Yeah, I think this step looks reasonable.
