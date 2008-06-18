From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH 1/2 v2] t/test-lib.sh: add test_external and test_external_without_stderr
Date: Wed, 18 Jun 2008 22:24:07 +0200
Message-ID: <48596EE7.90202@free.fr>
References: <d94c2a62edfdec22c32ef5d9649078430b30ecfd.1213685306.git.LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 22:24:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K94DD-0000ML-8L
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 22:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753868AbYFRUYD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Jun 2008 16:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753620AbYFRUYD
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 16:24:03 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:50873 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752285AbYFRUYB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 16:24:01 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id DD79812B776;
	Wed, 18 Jun 2008 22:23:59 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id B395012B715;
	Wed, 18 Jun 2008 22:23:59 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <d94c2a62edfdec22c32ef5d9649078430b30ecfd.1213685306.git.LeWiemann@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85409>

Hi,

Lea Wiemann a =E9crit :
> +# Like test_external, but in addition tests that the command generat=
ed
> +# no output on stderr.
> +test_external_without_stderr () {
> +	# The temporary file has no (and must have no) security
> +	# implications.
> +	tmp=3D"$TMPDIR"; if [ -z "$tmp" ]; then tmp=3D/tmp; fi
> +	stderr=3D"$tmp/git-external-stderr.$$.tmp"
> +	test_external "$@" 4> "$stderr"
> +	[ -f "$stderr" ] || eror "Internal error: $stderr disappeared."

Just a typo here: s/eror/error/

Olivier.
