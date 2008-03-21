From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] help: use man viewer path from "man.<tool>.path"
 config var
Date: Fri, 21 Mar 2008 01:56:33 -0700
Message-ID: <7vd4poqwu6.fsf@gitster.siamese.dyndns.org>
References: <20080318062236.7b5e515f.chriscool@tuxfamily.org>
 <200803200849.14664.chriscool@tuxfamily.org>
 <7vtzj1wd7u.fsf@gitster.siamese.dyndns.org>
 <200803210823.47899.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pascal Obry <pascal@obry.net>, Xavier Maillard <xma@gnu.org>,
	=?iso-2022-jp?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@bluebottle.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Mar 21 09:57:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jcd4K-0002oc-AI
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 09:57:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753133AbYCUI4v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Mar 2008 04:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752631AbYCUI4v
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 04:56:51 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37774 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127AbYCUI4u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Mar 2008 04:56:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A34F62473;
	Fri, 21 Mar 2008 04:56:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id AC3482472; Fri, 21 Mar 2008 04:56:41 -0400 (EDT)
In-Reply-To: <200803210823.47899.chriscool@tuxfamily.org> (Christian Couder's
 message of "Fri, 21 Mar 2008 08:23:47 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77729>

Christian Couder <chriscool@tuxfamily.org> writes:

> Le jeudi 20 mars 2008, Junio C Hamano a =C3=A9crit :
> ...
>> If that inconsistency bothers you, you probably should rename the
>> built-in konqueror support to "kfmclient", which is more honest appr=
oach,
>> I would think.
>
> It's perhaps more honest, but kfmclient is not as well known as konqu=
eror.
>
> Isn't a documentation patch like this enough:

I dunno.  I am not a KDE use to begin with.

But I am somewhat uncomfortable with this kind of magic, and very much
more so with basing the magic on the name of a binary.

=46or example, if a distro offers two versions of konq to co-exist on t=
he
same system as konqueror-3 and konqueror-4 (with the usual symlink tric=
ks
/etc/alternatives/konqueror -> konqueror-3 and /usr/bin/konqueror ->
/etc/alternatives/konqueror to make one version the systemwide default)=
,
people who want a particular version may say /usr/bin/konqueror-4 and
would get frustrated to see kfmclient magic would not kick in.  By taki=
ng
honest route without magic, you would not have to worry about such
potential confusion.
