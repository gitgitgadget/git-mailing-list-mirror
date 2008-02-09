From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [Janitors] value could be NULL in config parser
Date: Sat, 9 Feb 2008 11:18:10 +0100
Message-ID: <200802091118.11174.chriscool@tuxfamily.org>
References: <7v63x0lzhw.fsf@gitster.siamese.dyndns.org> <5d46db230802081720x122a807do6c63b6b3e435b4c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Govind Salinas" <govind@sophiasuchtig.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 11:12:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNmhT-0007VZ-7U
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 11:12:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754078AbYBIKMO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Feb 2008 05:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751879AbYBIKMN
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 05:12:13 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:54175 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751845AbYBIKMN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Feb 2008 05:12:13 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id A414D1AB315;
	Sat,  9 Feb 2008 11:12:11 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 71C9E1AB2E2;
	Sat,  9 Feb 2008 11:12:11 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <5d46db230802081720x122a807do6c63b6b3e435b4c5@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73206>

Le samedi 9 f=E9vrier 2008, Govind Salinas a =E9crit :
> I think I got all the erroneous ones.  I did
>
> find . -name "*.c" | xargs grep git_config\( | awk '{ idx =3D index($=
2,
> ")"); p =3D substr($2, 12, idx - 12); print  p }' | sort | uniq -u

It seems the "uniq -u" should be only "uniq".
This way, you will also get the following ones to check:

git_default_config
git_diff_basic_config
git_log_config
git_pack_config

Thanks in advance,
Christian.
