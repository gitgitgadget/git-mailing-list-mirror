From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] submodules: always use a relative path to gitdir
Date: Thu, 09 Feb 2012 11:52:46 -0800
Message-ID: <7v8vkbwzqp.fsf@alter.siamese.dyndns.org>
References: <4F32F252.7050105@web.de> <4F32F2F6.6040006@web.de>
 <4F33814E.7050404@web.de> <7vd39nx0br.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Antony Male <antony.male@gmail.com>,
	Phil Hord <phil.hord@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 09 20:52:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rva33-0002yj-Sl
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 20:52:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758503Ab2BITwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 14:52:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61747 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757903Ab2BITws (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 14:52:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 37F6E6606;
	Thu,  9 Feb 2012 14:52:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZXGt0C1UpThah0xyTtoxNLYO664=; b=BsWFLE
	Av3ZY2YkcZRYRizEGCfpzEEFxaOWAy+vjJEAhHT4xdOkHuJG9zw+jDObZ3I6Mkdl
	9HK9/+XbZhTwCf1Vtbhjm6bD4B/j9nCnBa5okhRXkW3QHgOjrZaWhlTK81o0pQ18
	3NojjODDDrAqERQe2K1+i/wV9PHJ+wVLo0hEM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t0vvh5YdsQZDx2f4ODi+iip6BoDKmhKf
	jgXLl3PPYxwH7+YDGsj+OHQOyYAC07WpVX3Z0LicIqm1dqXjzcqXOGeTGF2Wq1sW
	8NHO320vjLrtTlemY2YtTUr26VYy8upJw4lQ0SC6Gffqz/W+7JRK2wveOIe+yoxL
	dJnMtVVgCmc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F6786604;
	Thu,  9 Feb 2012 14:52:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B50D06603; Thu,  9 Feb 2012
 14:52:47 -0500 (EST)
In-Reply-To: <7vd39nx0br.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 09 Feb 2012 11:40:08 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A40F3D54-5357-11E1-ACF5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190314>

Junio C Hamano <gitster@pobox.com> writes:

> When applied to v1.7.8.x maintenance track, this failed the first step in
> t5526, but with the earlier jl/submodule-re-add topic everything seems to
> pass just fine.

What I meant to say is that "this and the other topic need to be merged to
that maintenance track together"; I didn't mean to say there is any
breakage in this patch.

Sorry for a potentially confusing statement.
