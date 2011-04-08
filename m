From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: Add a svn-remote.<name>.pushurl config key
Date: Fri, 08 Apr 2011 13:13:47 -0700
Message-ID: <7vmxk033ic.fsf@alter.siamese.dyndns.org>
References: <1302102336-8800-1-git-send-email-asedeno@mit.edu>
 <1302274674-4231-1-git-send-email-asedeno@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: =?utf-8?Q?Alejandro_R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
X-From: git-owner@vger.kernel.org Fri Apr 08 22:14:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8I4U-0003H0-6l
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 22:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757890Ab1DHUOF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Apr 2011 16:14:05 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56733 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757799Ab1DHUOB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Apr 2011 16:14:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B93DD50A5;
	Fri,  8 Apr 2011 16:15:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=h7z8IPucru+K
	l+Bpdqfaw23mt2g=; b=xNd8pvkK52owEuc+LSFi7i5Fwh9Jues1va8p6MfwW24+
	BW9f4zpnoQTg3aljv3CnVexLw6xAK3i1K/4aByukrGuJ9H9J/JK0SGJ/GZzjQ6X4
	GWTeS0FYJUBGOyr10LYcKyYn/WE+RYQ48Sz5Rw20Im0DUiYB6OE7xzi2g+3Fmao=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=u3dE2y
	6dMMOjYDivbULNK0lpmT2Uk19XReMf5eVmYCftm9MEGQYDvADrkDZEzNe/tyWYON
	TkXvJXnX1X3MBIAGj1S1m702mYJJ9ho2O6/IZJIiffM00JnzYa7SHTIX69ZeY9CB
	wQr/lm06UGjgIRo9O2eiGna1mTj/if35jy2u4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 76C7250A4;
	Fri,  8 Apr 2011 16:15:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 17909509F; Fri,  8 Apr 2011
 16:15:44 -0400 (EDT)
In-Reply-To: <1302274674-4231-1-git-send-email-asedeno@mit.edu> ("Alejandro
 R. =?utf-8?Q?Sede=C3=B1o=22's?= message of "Fri, 8 Apr 2011 10:57:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FF5DEB2E-621C-11E0-9C97-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171156>

A Tangent.

>> X-Mailer: git-send-email 1.7.4.2.1.gd6f1f
>> In-Reply-To: <1302102336-8800-1-git-send-email-asedeno@mit.edu>

This is not about this particular patch, but the From: address
git-send-email generates for you does not seem to quote the human reada=
ble
part, even though the name has a "." in it.

Your mails seem to reach the recipients fine, but I saw my reply to you
bounce, because "To:" or "Cc:" in my reply end up having the "R." part =
not
quoted, like this:

  (wrong)  To: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>
 (correct) To: "Alejandro R. Sede=C3=B1o" <asedeno@mit.edu>

I wonder if we should do something about it in git-send-email.  Every t=
ime
I grab Shawn's address using my "git who" alias, I manually quote his n=
ame
to avoid my message thrown into dustbin by vger.

    [alias]
    who =3D "!sh -c 'git log -1 --format=3D\"%an <%ae>\" --author=3D\"$=
1\"' -"

I suspect Michael is not "Michael J. Gruber" for the same reason...
