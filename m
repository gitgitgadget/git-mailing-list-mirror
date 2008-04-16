From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/12] merge summary and diffstat options cleanup
Date: Tue, 15 Apr 2008 21:23:05 -0700
Message-ID: <7vk5iyv36e.fsf@gitster.siamese.dyndns.org>
References: <7vzls7so8m.fsf@gitster.siamese.dyndns.org>
 <1208306351-20922-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Apr 16 06:28:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlzC1-0005TZ-Nm
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 06:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbYDPEXV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Apr 2008 00:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751525AbYDPEXU
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 00:23:20 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40779 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540AbYDPEXT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Apr 2008 00:23:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9C54C24B6;
	Wed, 16 Apr 2008 00:23:17 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E8BFD24B5; Wed, 16 Apr 2008 00:23:13 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79645>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> On Sat, Apr 05, 2008 at 07:36:57PM -0700, Junio C Hamano wrote:
>> ...this hunk removes the original options from OPTIONS_SPEC, I suspe=
ct you
>> would get "unknown option 'stat'" from underlying "git rev-parse --p=
arseopt".
>>=20
>> You probably haven't noticed the breakage because you replaced all
>> existing --summary with --stat in the tests, though.  Oops.
> It was not clear to me that this OPTIONS_SPEC is used for parsing,
> too.  This series fixes the problem.

The previous one already is on 'next'.  If you have anything new to add=
,
please improve upon them incrementally.
