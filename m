From: Junio C Hamano <gitster@pobox.com>
Subject: One more 2.2-rc -- delaying the final
Date: Wed, 19 Nov 2014 13:31:13 -0800
Message-ID: <xmqqoas2ri72.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 19 22:31:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrCqS-0005EE-Rh
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 22:31:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933790AbaKSVbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 16:31:19 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54512 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932909AbaKSVbS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 16:31:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A4FB1EA69;
	Wed, 19 Nov 2014 16:31:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=a
	2Gj6sBsKmQaC9/ugBM1eEzyBW8=; b=tJcVOzgcK6uhySOt5TEvVSH0SZ5M1CeWe
	4832bHjPeocDNAimCUmldPM8+2PSIza+vQmxDpuiNLpcC795VT0hMcakciPWRSXl
	pC2yxbk0RVlKmrRWHa9QkrBoMAOTNWglOXM4A9/PvuOj1CnPxyNr0Xrn4MCWXZaK
	dMc/b1T9tU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Xab
	/jphLBAiJcQ7rg54cbeRPCNIJ+PkGTHJw86DuRuo3IV3VIxvfZh7wzwfMjQb2GJQ
	rQ4fFLxevM4nmAXxhh+Bl8RRZHyNiLDFZTYfasndihvfoxswVZ4k59IsQMXZ8ju/
	gTW/bSTgvPsBLnmmCTCKB1bCy+RoRUO8cIYv3tF0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 821B41EA68;
	Wed, 19 Nov 2014 16:31:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EDF131EA64;
	Wed, 19 Nov 2014 16:31:14 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 63E93404-7033-11E4-91D8-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we have "oops, what was already added to 'master' is not quite
right" fixes for a few topics, I'd feel uneasy to release 2.2 final
without a -rc3.  I was hoping that we can tag the final end of this
week, but let's make a -rc3 tomorrow or Friday and then do the final
one mid next week just before Turkey.

The ones I have in mind that I'd like to add for -rc3 are

 - Christian's trailers fixes (two patches)
 - David's "difftool --trust-exit-code" fix (one patch)
 - Torsten's fix to test t5705 (one patch)

and smaller documentation fixes (which are not regression fixes).

Other things in 'next', even though many of them feel solid, are new
features that can wait for another cycle, I think.

Thanks.
