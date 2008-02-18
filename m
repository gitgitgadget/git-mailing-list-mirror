From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Rename git-core rpm to just git and rename the
 meta-pacakge to git-all.
Date: Mon, 18 Feb 2008 10:36:27 -0800
Message-ID: <7v7ih2p0wk.fsf@gitster.siamese.dyndns.org>
References: <1203100163-17509-1-git-send-email-krh@redhat.com>
 <7vskzs2exj.fsf@gitster.siamese.dyndns.org>
 <76718490802180651h2ad61c4cg50bae97000957397@mail.gmail.com>
 <1203350676.4082.0.camel@gaara.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 19:37:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRAs7-00048o-Dt
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 19:37:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707AbYBRShL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Feb 2008 13:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbYBRShL
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 13:37:11 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36405 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484AbYBRShK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Feb 2008 13:37:10 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8708848C0;
	Mon, 18 Feb 2008 13:37:04 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 9D7E8471C; Mon, 18 Feb 2008 13:36:50 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74326>

Kristian H=C3=B8gsberg <krh@redhat.com> writes:

> On Mon, 2008-02-18 at 09:51 -0500, Jay Soffian wrote:
>> On Feb 17, 2008 2:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>=20
>> > "yum install git" and "yum install git-core" do not give such an
>> > error but the latter gives quite a bunch of errors ("yum install
>> > git" goes alright).  This is problem #2.
>>=20
>> You probably want "yum upgrade git-core".
>>=20
>> The "problem" is that yum by default doesn't process RPM renames (ob=
soletes)
>> unless you either have obsoletes=3D1 in your yum.conf, use "yum --ob=
soletes
>> update" or use "yum upgrade".
>
> Ah, that's what it is.  Thanks, I wasn't aware of this issue.

Does that mean that the test I did and the problem I saw were
end-user errors and that there is no proble with your patch and
I can use it as-is to cut 1.5.4.3 and future ones?

That's a great news.

But perhaps we would need some description/warning to help end
users as clueless as I am with respect to yum in the release
notes and/or announcements?

Could you resend the patch with a commit log message that I can
later reuse parts from for such a purpose, with a sign-off
please?
