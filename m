From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v2 4/4] read-tree: add --no-sparse to turn off sparse
  hook
Date: Mon, 10 Aug 2009 22:13:03 -0700
Message-ID: <7vhbwforvk.fsf@alter.siamese.dyndns.org>
References: <1249917562-5931-1-git-send-email-pclouds@gmail.com>
 <1249917562-5931-2-git-send-email-pclouds@gmail.com>
 <1249917562-5931-3-git-send-email-pclouds@gmail.com>
 <1249917562-5931-4-git-send-email-pclouds@gmail.com>
 <1249917562-5931-5-git-send-email-pclouds@gmail.com>
 <alpine.DEB.1.00.0908101842530.8324@intel-tinevez-2-302>
 <fcaeb9bf0908101838k37751fclac5c572eb042138e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 14:15:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaqGS-0000RC-M6
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 14:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752776AbZHKMGe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Aug 2009 08:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753176AbZHKMGc
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 08:06:32 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43841 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118AbZHKMG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 08:06:28 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D095B6FF1;
	Tue, 11 Aug 2009 01:13:08 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 235A36FF0; Tue, 11 Aug
 2009 01:13:04 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A8A3BD00-8635-11DE-AFC1-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125525>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

>> Hmm. =C2=A0I understand that the assumption is that memset(&opts, 0,
>> sizeof(opts)); should give you a sensible default, but I cannot avoi=
d
>> noticing that "no_sparse_hook =3D 0" is a double negation, something=
 to be
>> avoided...
>
> skip_sparse_hook then? :-)

Why not making the hook to be skipped by default, and pass an explicit
option to trigger the hook?

I like Dscho's other suggestion to use patterns like .gitignore instead=
 of
using hook scripts that needs to be ported across platforms, by the way=
=2E
