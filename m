From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/1] perl/Makefile.PL: warn about duplicate module list
 in perl/Makefile
Date: Fri, 15 Jun 2012 13:23:12 -0700
Message-ID: <7vehpg9vf3.fsf@alter.siamese.dyndns.org>
References: <1339781427-10568-1-git-send-email-adam@roben.org>
 <20120615180505.GH10752@burratino> <20120615181446.GI10752@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Roben <adam@roben.org>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 22:23:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sfd3A-0000Bj-De
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 22:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757752Ab2FOUXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 16:23:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43938 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757568Ab2FOUXP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 16:23:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A662F8606;
	Fri, 15 Jun 2012 16:23:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cuGdepqpCwmhgN92ngj9xgsDVQU=; b=Mm6Emb
	Y49sats6sw6dT34wLLh/tubpUXSIYpWdEcFmqSdsUwxQoihCagpxsq7v2/Mmar+E
	dPYrPYCbhshCzderw5VXQAEpRS1Jmb/vRQqrpwtLcu54nQgWzW3H3lk5OYiRgiaU
	kgzU029Il/rzwinaHWHpBqX866pz2Q8wpkTWg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U1jyir6ZUh+oxQNwykKop6Vi54/M9jYn
	eNUwkSnxPy/lqsQe0gIHgJYb0UYKUAosBjG+vdVY+etnTuteuiRy1AwC5wW2jcjn
	5dM9iTXim5CwHWrJkTkzQOBlYoYZ6K0NioFMxyuil0pyDWp7LMm5Xr93SXIXLwog
	Gs+aB3Hprws=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BD298604;
	Fri, 15 Jun 2012 16:23:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 341938602; Fri, 15 Jun 2012
 16:23:14 -0400 (EDT)
In-Reply-To: <20120615181446.GI10752@burratino> (Jonathan Nieder's message of
 "Fri, 15 Jun 2012 13:14:46 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EF2EE116-B727-11E1-9CB4-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200092>

Thanks for a last minute fix.  Will apply both directly to 'master'.
