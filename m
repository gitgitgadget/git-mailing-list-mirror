From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 3/4] Documentation: branch.*.merge can also afect 
 'git-push'
Date: Wed, 01 Apr 2009 23:08:27 -0700
Message-ID: <7v3acrk2p0.fsf@gitster.siamese.dyndns.org>
References: <1238407903-28020-1-git-send-email-santi@agolina.net>
 <1238407903-28020-4-git-send-email-santi@agolina.net>
 <7vd4bzdkkq.fsf@gitster.siamese.dyndns.org>
 <adf1fd3d0903301506r65bd9b9bv6bf76c652a051400@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Thu Apr 02 08:10:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpG7q-00027k-GK
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 08:10:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012AbZDBGIg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Apr 2009 02:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751612AbZDBGIf
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 02:08:35 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60090 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467AbZDBGIf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Apr 2009 02:08:35 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id DFBA8B899;
	Thu,  2 Apr 2009 02:08:32 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 324DCB896; Thu, 
 2 Apr 2009 02:08:30 -0400 (EDT)
In-Reply-To: <adf1fd3d0903301506r65bd9b9bv6bf76c652a051400@mail.gmail.com>
 (Santi =?utf-8?Q?B=C3=A9jar's?= message of "Tue, 31 Mar 2009 00:06:30 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B1CEEF1C-1F4C-11DE-B87E-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115445>

Santi B=C3=A9jar <santi@agolina.net> writes:

> 2009/3/30 Junio C Hamano <gitster@pobox.com>:
> ...
> Maybe the push.default description needs some enhancements, but this
> [3/4] is true.
>
>> I think the author meant to say if your local branch frotz by defaul=
t
>> merges changes made to the branch nitfol of the remote repository, "=
frotz
>> tracks nitfol", but the use of the word "track" for that meaning app=
ears
>> nowhere in Documentation/glossary-content.txt
>
> So we can define:
>
> push.default =3D "tracking" =3D "push the current branch to its upstr=
eam branch"
>
> The "upstream branch" is defined in branch.name.merge and could also
> be added to glossary-content.

Sounds like a good plan.  Please make it so.
