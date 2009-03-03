From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-clone: Add option --branch to override initial
 branch
Date: Tue, 03 Mar 2009 09:07:39 -0800
Message-ID: <7vmyc2bkmc.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0903030047130.10279@pacific.mpi-cbg.de>
 <49AD6305.8040909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Tor Arne =?utf-8?Q?Vestb=C3=B8?= <torarnv@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 18:09:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeY7K-00062Z-9R
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 18:09:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849AbZCCRHv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 12:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752695AbZCCRHu
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 12:07:50 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44922 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521AbZCCRHu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 12:07:50 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F0E5A9ED57;
	Tue,  3 Mar 2009 12:07:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C303D9ED54; Tue,
  3 Mar 2009 12:07:42 -0500 (EST)
In-Reply-To: <49AD6305.8040909@gmail.com> (Tor Arne =?utf-8?Q?Vestb=C3=B8'?=
 =?utf-8?Q?s?= message of "Tue, 3 Mar 2009 18:04:05 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D17C72B0-0815-11DE-BE71-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112121>

Tor Arne Vestb=C3=B8 <torarnv@gmail.com> writes:

> In that case you would either have to ff master all the time
> (requiring a checkout or rebase magic), or do an explicit "git push
> origin 1.6".

or do something like:

$ cat >>.git/config <<\EOF
[remote "there"]
    push =3D HEAD
EOF

just once.
