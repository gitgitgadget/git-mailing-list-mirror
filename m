From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Storing notes refs outside of refs/
Date: Thu, 26 Aug 2010 10:05:03 -0700
Message-ID: <7vy6btl2yo.fsf@alter.siamese.dyndns.org>
References: <4C7681F1.3070205@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 19:05:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ooft5-00055C-T7
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 19:05:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986Ab0HZRFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 13:05:11 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57756 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536Ab0HZRFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 13:05:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6259DD06B3;
	Thu, 26 Aug 2010 13:05:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2kd5/xKaG7DBD5QUp9mrEPG5bbE=; b=nv4/9t
	tDY8AU2tZjUvcpxce0/FyZzqcqaOlQ1+0KuZi1aOtbrZ4OWmTjumUZdqJGa4x8/1
	ChVcuwk3AHN6eWLmgMWgbJ5LuYqsRGYE2nCuRiWR12np8SaI1JZMSZcb7B6eBjQc
	m9h1E5NTXKmz0gfaHVlMnQ8DXDHP2fmA/3SZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZkmWHRJfZtkNlGoGNIcj+kr1+J5lTP/S
	/j35Ud+MvlI0RazP1x3kgX516ReG6D0314lNWcxShWk7Hh7f4xWUJtoX325Yiozk
	urK1CV3/lKNQG6mzQcjTIJaMiGaQ4IwJBrVjS0G0KYr2eaqqjS6gvV4FfDaZOdhe
	GINJW6s3hmc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DC22D06B2;
	Thu, 26 Aug 2010 13:05:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9E182D06B1; Thu, 26 Aug
 2010 13:05:04 -0400 (EDT)
In-Reply-To: <4C7681F1.3070205@workspacewhiz.com> (Joshua Jensen's message of
 "Thu\, 26 Aug 2010 09\:02\:09 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 13C0F9F2-B134-11DF-B15B-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154546>

Joshua Jensen <jjensen@workspacewhiz.com> writes:

> I tried manually moving .git/refs/notes/p4notes to .git/p4/p4notes.

Bad idea.  Your notes no longer are protected from fsck and prune.

Don't do it.
