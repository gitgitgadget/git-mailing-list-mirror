From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] help: use man viewer path from "man.<tool>.path"
 config var
Date: Mon, 24 Mar 2008 23:45:04 -0700
Message-ID: <7vzlsnpaj3.fsf@gitster.siamese.dyndns.org>
References: <20080318062236.7b5e515f.chriscool@tuxfamily.org>
 <200803210823.47899.chriscool@tuxfamily.org>
 <7vd4poqwu6.fsf@gitster.siamese.dyndns.org>
 <200803250719.02044.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pascal Obry <pascal@obry.net>, Xavier Maillard <xma@gnu.org>,
	=?iso-2022-jp?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@bluebottle.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Mar 25 07:46:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Je2v6-00008K-9M
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 07:46:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbYCYGpW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2008 02:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbYCYGpW
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 02:45:22 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56772 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbYCYGpW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Mar 2008 02:45:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B7B862D88;
	Tue, 25 Mar 2008 02:45:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C39222D81; Tue, 25 Mar 2008 02:45:13 -0400 (EDT)
In-Reply-To: <200803250719.02044.chriscool@tuxfamily.org> (Christian Couder's
 message of "Tue, 25 Mar 2008 07:19:01 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78151>

Christian Couder <chriscool@tuxfamily.org> writes:

> Le vendredi 21 mars 2008, Junio C Hamano a =C3=A9crit :
> ...
>> For example, if a distro offers two versions of konq to co-exist on =
the
>> same system as konqueror-3 and konqueror-4 (with the usual symlink t=
ricks
>> /etc/alternatives/konqueror -> konqueror-3 and /usr/bin/konqueror ->
>> /etc/alternatives/konqueror to make one version the systemwide defau=
lt),
>> people who want a particular version may say /usr/bin/konqueror-4 an=
d
>> would get frustrated to see kfmclient magic would not kick in.  By t=
aking
>> honest route without magic, you would not have to worry about such
>> potential confusion.
>
> In my experience KDE people have never changed the binary names like =
that.=20
> They just use (or advice users to use) different directory names and =
change=20
> environment variables (QTDIR, KDEDIR and maybe others) to point to th=
e new=20
> dirs.

I was more worried about what distro people do, not "KDE people".  For
example, Contents-i386.gz file from an unnamed distribution lists a
handful /usr/bin/k*[0-9] files with their counterparts without the
trailing digit.
