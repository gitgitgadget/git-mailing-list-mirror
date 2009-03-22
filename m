From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] check-ref-format --branch: give Porcelain a way to 
 grok branch shorthand
Date: Sun, 22 Mar 2009 14:58:42 -0700
Message-ID: <7v8wmxdxt9.fsf@gitster.siamese.dyndns.org>
References: <1237673619-12608-1-git-send-email-gitster@pobox.com>
 <1237673619-12608-2-git-send-email-gitster@pobox.com>
 <1237673619-12608-3-git-send-email-gitster@pobox.com>
 <1237673619-12608-4-git-send-email-gitster@pobox.com>
 <36ca99e90903220318g2cfb192fi9d4ef0da95e1a65b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 23:00:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlVif-0002AY-6b
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 23:00:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755911AbZCVV6u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Mar 2009 17:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755852AbZCVV6u
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 17:58:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39783 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755830AbZCVV6s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Mar 2009 17:58:48 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 11422A4629;
	Sun, 22 Mar 2009 17:58:47 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DA51CA4626; Sun,
 22 Mar 2009 17:58:43 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9E407D6C-172C-11DE-A3AA-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114178>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

>> =C2=A0int cmd_check_ref_format(int argc, const char **argv, const ch=
ar *prefix)
>> =C2=A0{
>> + =C2=A0 =C2=A0 =C2=A0 if (argc =3D=3D 3 && !strcmp(argv[1], "--bran=
ch")) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct strbuf sb =
=3D STRBUF_INIT;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_branchname=
(&sb, argv[2]);
>
> strbuf_branchname() will be introduced in the next patch!

Good eyes; thanks.
