From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH maint 0/3] do not write files outside of work-dir
Date: Fri, 27 May 2011 10:57:37 -0700
Message-ID: <7vr57krppq.fsf@alter.siamese.dyndns.org>
References: <1306512040-1468-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de,
	j.sixt@viscovery.net, Theo Niessink <theo@taletn.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 27 19:58:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQ1IM-00084x-3i
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 19:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997Ab1E0R5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 13:57:53 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39617 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777Ab1E0R5w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2011 13:57:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2C6B759B0;
	Fri, 27 May 2011 13:59:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=klcal19jrRq9qAMhOsMX4fODUEg=; b=w+TNpl
	m2N2+J0ftXdFj7F+taKXk7UNZIRGYNN5uw07TFnwqZOyICgXw3zu8tznDm9zonvv
	45P9ReS+4E/IHAbpgttUbYWv2iDA4h5eeDm8ZHfGck+6TdaLe50QfXYtHGaGug25
	8K2uTAn6pi5by79JAjU8TbwNmoMkbPnYq7Si0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qciYkHmdzxuVdN/pEltrfkJjdLOFgorL
	uRppYVSIt+BhwAH9aLxx246GRe0QtVJVyRUPXEwkBFZe11wo1oW964sV6PUpXTir
	qCo6pz4fzhQQyDdNS0jJjcY1yH7k6kMs8WKjHBzA+gxkdPq4ywFOR9l0p/m0c3mb
	IMRitP6Hk+U=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CA4CC59AD;
	Fri, 27 May 2011 13:59:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5ADB559AC; Fri, 27 May 2011
 13:59:46 -0400 (EDT)
In-Reply-To: <1306512040-1468-1-git-send-email-kusmabite@gmail.com> (Erik
 Faye-Lund's message of "Fri, 27 May 2011 18:00:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1F441352-888B-11E0-A021-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174633>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> Theo Niessink has uncovered a serious sercurity issue in Git for Windows,
> where cloning an evil repository can arbitrarily overwrite files outside
> the repository. Since many Windows users run as administrators, this can
> be used for very nasty purposes.

Which of my integration branches do msysGit/Git for Windows folks base
their releases these days? I could carry this through the regular "next to
master and then sometime later to maint" schedule, but if you are not
using maint and basing primarily on master then I'd rather skip the "and
then sometime later to maint" part.
