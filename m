From: Junio C Hamano <gitster@pobox.com>
Subject: Re: More support on branch description?
Date: Thu, 19 Jan 2012 14:22:45 -0800
Message-ID: <7v4nvrib7u.fsf@alter.siamese.dyndns.org>
References: <CACsJy8D0_EB6jN7KxpzLtnPnj0HjdU6sNHJRyqXJf-2-ZNatFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 19 23:22:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ro0Ng-0007mF-QA
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 23:22:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756011Ab2ASWWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jan 2012 17:22:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37265 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753927Ab2ASWWr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2012 17:22:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 316A76E52;
	Thu, 19 Jan 2012 17:22:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UTipbkbrz6q0abo5VxwXwPwy8ms=; b=J1Vr6o
	CQKpuqduhNi8pdTyEWQRPSpW+94uUHZxogu1ASLE34MJdKuQldRZWRH/Q9NAVk+v
	3YdqHsd969RDSynhIn10BjSL4zcWNU/7xdx46Eb3+qV852KXj6YVxCA6ItYwmZeW
	lVigg19LW6PA5llZGrsKnsxMSJn+MVgsj0QaU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xT34m1QOf0I6PNiSrAlt0ODSVTf2Wz9W
	nLNEnpjYoAyBOa6zG5/VxngX3txM1tellut8/6df0i2E0HmrAG1d/ip10LsO7ZDb
	ULDkUTjmyyYMpGJ5tvQHacca+zvGGOUP3PmX/6iV1XRALmyIefir9eZEAmVypX1C
	hE9KXx2Z5Lo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28D8F6E51;
	Thu, 19 Jan 2012 17:22:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B3AAF6E50; Thu, 19 Jan 2012
 17:22:46 -0500 (EST)
In-Reply-To: <CACsJy8D0_EB6jN7KxpzLtnPnj0HjdU6sNHJRyqXJf-2-ZNatFA@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Thu, 19 Jan 2012 21:14:55 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1D33AAB6-42EC-11E1-95FE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188843>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> The coming v1.7.9 will introduce branch description, mainly used in
> integration process. I think we could make it useful for users who
> don't extensively use request-pull/format-patch. Showing a short
> summary along with branch name in "git branch" would be nice.

I agree that it would be nice to give users access to the information even
if the branch ends up being merged to the master branch by you and never
leaves your repository by itself.

You however are misguided to say "Showing a short summary along...".

The branch description support is to give users a place to record detailed
explanation about a branch, similar in size to what you would normally
place in a log message of a commit or a cover letter of a series.  There
wasn't any convenient place to do so for a branch that is (1) inherently a
moving target while it is being developed and (2) is not a good match for
tags and notes.

There already is a good place for a brief summary and it is called "branch
name". Name your branches just like you name your functions.
