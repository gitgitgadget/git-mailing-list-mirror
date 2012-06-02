From: Junio C Hamano <gitster@pobox.com>
Subject: Re: More use of levenshtein?
Date: Sat, 02 Jun 2012 15:55:50 -0700
Message-ID: <7vvcj9z5l5.fsf@alter.siamese.dyndns.org>
References: <7vzk8m26sf.fsf@alter.siamese.dyndns.org>
 <CACsJy8DuDzxrcb8kbWhH9N=1APQeEOUZzUvSaKCJ7LJ9rc9tKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 03 00:56:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaxEx-00034a-D7
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jun 2012 00:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758396Ab2FBWz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jun 2012 18:55:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49010 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756051Ab2FBWzz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2012 18:55:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D9F28CDD;
	Sat,  2 Jun 2012 18:55:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Tp0T2340zfr/fzFy+3gdFgUNUcU=; b=TEY+PT
	MZhZVL44k2xi8PaosAW1sP18km2/rM/c2yGtx53vslIU0kjXhaFympT5w/OVSNzo
	mycUXyuHKVya/+M7nKzRZT/g1F2/rOpKMHLwByVIK92b26L2bB50B3K9BNVSmc0Y
	dovuLXMyvyJSLO0Z5NCWy2ENukZHwo/qwkJJI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G+rMwSchBXHnJCPGR0yQmZsqaLn6xgCI
	zKGnXcxhO9spmrmP0f5LF/aAeIH2Vi003OZ30HaFElUzIJV/uroPyShNTkwbt96C
	uS31vfae19FL/ErXsdikPKoss3D0u+lrHxDrN1VGnycowSE3afDFRn2DqjSkIyRp
	EW92dnFu6wk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34BED8CDC;
	Sat,  2 Jun 2012 18:55:52 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1E308CDB; Sat,  2 Jun 2012
 18:55:51 -0400 (EDT)
In-Reply-To: <CACsJy8DuDzxrcb8kbWhH9N=1APQeEOUZzUvSaKCJ7LJ9rc9tKg@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Sat, 2 Jun 2012 17:26:57 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1A27A8C0-AD06-11E1-8ED0-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199061>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Yes, please. Also to correct misspelled option names.
>
> In case there are more than one candidate, we should print extra info
> (for commands or options, it's one line description; for refs,
> probably commit subject line)

I do not think either is a good idea.  We are talking about "typo",
the user knew what he wanted, just didn't spell it correctly.
