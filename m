From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] Make old sha1 optional with git update-ref -d
Date: Tue, 03 Jun 2008 12:39:23 -0700
Message-ID: <7v3anu2tqs.fsf@gitster.siamese.dyndns.org>
References: <20080602233244.26087.51827.stgit@yoghurt>
 <20080602233453.26087.52259.stgit@yoghurt>
 <7vk5h73w2i.fsf@gitster.siamese.dyndns.org>
 <20080603064957.GA6701@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 21:40:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3cN4-0008SF-0v
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 21:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753974AbYFCTjp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Jun 2008 15:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753870AbYFCTjp
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 15:39:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56610 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151AbYFCTjo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jun 2008 15:39:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 38B1A470C;
	Tue,  3 Jun 2008 15:39:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D5D5A4702; Tue,  3 Jun 2008 15:39:36 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CFD49A84-31A4-11DD-891D-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83692>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> I need this from time to time when experimenting with StGit -- or,
> more precisely, when cleaning up afterwards in case it didn't go so
> well. Packed refs means I can't safely just edit/delete files under
> .git/refs anymore, so I use update-ref instead. And having to use the
> safety belt every time is just plain tedious. I'd say this is a
> perfect example of when using the plumbing by hand is really what you
> want.

Oh, I should have guessed, and I am relieved by your answer.

I was worried that in some workflow people may have to use "update-ref =
-d"
all the time because our Porcelain allows them to create some ref witho=
ut
giving a clean way to remove it (e.g. "branch" and "tag" allow creation
and deletion with -d/-D, so they are Ok, but I was worried there might =
be
something else I overlooked).

Manually cleaning up what an experimental version of Porcelain left beh=
ind
does not fall into category of "normal user has to do this all the time=
",
so I do not have to worry.

Thanks.
