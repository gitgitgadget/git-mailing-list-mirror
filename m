From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/8] archive: add a failure test wrt .gitattributes  
 misreading
Date: Fri, 17 Apr 2009 18:33:50 -0700
Message-ID: <7vocuuzqwx.fsf@gitster.siamese.dyndns.org>
References: <1239185133-4181-1-git-send-email-pclouds@gmail.com>
 <1239185133-4181-2-git-send-email-pclouds@gmail.com>
 <1239185133-4181-3-git-send-email-pclouds@gmail.com>
 <1239185133-4181-4-git-send-email-pclouds@gmail.com>
 <7vab6rkl5f.fsf@gitster.siamese.dyndns.org> <49E3448B.8010602@lsrfire.ath.cx>
 <7v4owpm2il.fsf@gitster.siamese.dyndns.org> <49E8E368.2010703@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Apr 18 03:35:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuzTE-0002Wx-Sk
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 03:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753723AbZDRBd6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Apr 2009 21:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755010AbZDRBd6
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 21:33:58 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38087 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754134AbZDRBd5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Apr 2009 21:33:57 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 25728F76B;
	Fri, 17 Apr 2009 21:33:56 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 728B5F76A; Fri,
 17 Apr 2009 21:33:52 -0400 (EDT)
In-Reply-To: <49E8E368.2010703@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of "Fri, 17 Apr 2009 22:15:36 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FB848996-2BB8-11DE-8FB8-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116809>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> I think the fixing, tweaking or even breaking will be done by the use=
r,
> when editing the attribute files in the work tree.  git then only
> applies or evaluates these attributes, creating the archive using a
> different source of meta data.  "--worktree-attributes" captures this
> nicely.

Yeah, that sounds like a sane idea.  I see you already made it so with
your v2 4/5.

Thanks.
