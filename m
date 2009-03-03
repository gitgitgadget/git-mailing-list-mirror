From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-clone: Add option --branch to override initial
 branch
Date: Tue, 03 Mar 2009 08:51:25 -0800
Message-ID: <7vr61eblde.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0903030047130.10279@pacific.mpi-cbg.de>
 <49AD5F0D.8000700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Tor Arne =?utf-8?Q?Vestb=C3=B8?= <torarnv@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 17:53:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeXrb-0007Nu-BX
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 17:53:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752980AbZCCQvf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 11:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751809AbZCCQvf
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 11:51:35 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35676 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbZCCQve convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 11:51:34 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 10CA99EB82;
	Tue,  3 Mar 2009 11:51:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D62399EB7F; Tue,
  3 Mar 2009 11:51:27 -0500 (EST)
In-Reply-To: <49AD5F0D.8000700@gmail.com> (Tor Arne =?utf-8?Q?Vestb=C3=B8'?=
 =?utf-8?Q?s?= message of "Tue, 3 Mar 2009 17:47:09 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8C640776-0813-11DE-9C9A-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112117>

Tor Arne Vestb=C3=B8 <torarnv@gmail.com> writes:

> If you would like to contribute to the stable 1.6 branch, do:
>   $ git clone -n git://git.foo.com/project.git
>   $ cd project
>   $ git checkout -t origin/1.6
>   $ git branch -D master
> Which is not so nice and inviting.

If you are working on 1.6 maintenance track, why discard 'master'?  If =
the
upstream project calls it 1.6, you can call your fork 1.6 and keep that
checked out.

IOW, _you_ are make it not nice.
