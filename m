From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] format-patch does not wrap From-field after author name
Date: Thu, 14 Apr 2011 10:12:44 -0700
Message-ID: <7v39lkiwoj.fsf@alter.siamese.dyndns.org>
References: <BANLkTimruwojkq_HNMZeCDBV6K8_aFc_XQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@github.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 19:13:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAQ6M-0004gU-50
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 19:13:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181Ab1DNRNA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 13:13:00 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62750 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266Ab1DNRM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 13:12:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C55835695;
	Thu, 14 Apr 2011 13:14:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WIOd7s78fcWMutO4l8KhSy6uzwQ=; b=ARDKDk
	kvWSnIHC/aIAMHzewyW4PzSiPLpgF0FzcdTW9ZeOd8FdYfqKv8/VorcjRd0YwkON
	06hXzGvqqxfjvmjQHmKZpIOoK6+QJk7s/0qNwKB9F09AwcLIiH3muJLs7VIqOkrx
	KfYT5ZfdmmNxbmAHb/83Y72f6FPogdAREChas=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jE6If7Jm2yI3h2F02aiSvFbrDYmmAbQx
	H2kaE6XkPLuJGdvOlbvCvJelxlVaqMeoghDXjrhec2uYHy0cO88gZ6+vTA6z9Kov
	E2MgwYKmWyApaCWR424o2kKvPwR79ECuR5jSWcJPXvFU5ZG03tJcOSYLNpPHM9us
	m+bU4pxovHY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8F0015694;
	Thu, 14 Apr 2011 13:14:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7E00C5693; Thu, 14 Apr 2011
 13:14:45 -0400 (EDT)
In-Reply-To: <BANLkTimruwojkq_HNMZeCDBV6K8_aFc_XQ@mail.gmail.com> (Erik
 Faye-Lund's message of "Thu, 14 Apr 2011 19:01:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B43ED020-66BA-11E0-AA07-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171526>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> With certain combinations of author name and email lengths, git
> format-patch does not correctly wrap the From line to be below 78
> characters, violating rfc2047.

Didn't we have this fixed quite a while ago with the series that ends at
c22e7de (format-patch: rfc2047-encode newlines in headers, 2011-02-23)?

What version of git do you use?
