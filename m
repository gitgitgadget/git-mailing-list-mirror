From: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
Subject: Re: [PATCH v4 1/2] git-imap-send: Add CRAM-MD5 authenticate method
 support
Date: Fri, 19 Feb 2010 00:45:27 +0900
Message-ID: <4B7D6097.6010700@dcl.info.waseda.ac.jp>
References: <1265717345-2118-1-git-send-email-mitake@dcl.info.waseda.ac.jp> <1265974572-6282-1-git-send-email-mitake@dcl.info.waseda.ac.jp> <7vljeyp1rj.fsf@alter.siamese.dyndns.org> <4B764B67.1020402@dcl.info.waseda.ac.jp> <7vsk95sht6.fsf@alter.siamese.dyndns.org> <7v8watg04g.fsf@alter.siamese.dyndns.org> <4B7BB437.1060608@dcl.info.waseda.ac.jp> <7vocjnu32b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@googlemail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 16:45:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni8ZO-0005cw-L0
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 16:45:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758493Ab0BRPpc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Feb 2010 10:45:32 -0500
Received: from ns.dcl.info.waseda.ac.jp ([133.9.216.194]:55244 "EHLO
	ns.dcl.info.waseda.ac.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758454Ab0BRPpb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 10:45:31 -0500
Received: from localhost (localhost [127.0.0.1])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id 44128EE499C;
	Fri, 19 Feb 2010 00:45:29 +0900 (JST)
X-Virus-Scanned: amavisd-new at dcl.info.waseda.ac.jp
Received: from ns.dcl.info.waseda.ac.jp ([127.0.0.1])
	by localhost (ns.dcl.info.waseda.ac.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u7siKNv9iL-G; Fri, 19 Feb 2010 00:45:28 +0900 (JST)
Received: from [192.168.11.2] (FL1-122-130-141-251.tky.mesh.ad.jp [122.130.141.251])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id 92328EE4998;
	Fri, 19 Feb 2010 00:45:28 +0900 (JST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ja; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <7vocjnu32b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140347>

(2010=E5=B9=B402=E6=9C=8818=E6=97=A5 03:31), Junio C Hamano wrote:
> Hitoshi Mitake<mitake@dcl.info.waseda.ac.jp>  writes:
>
>>      response_64 =3D xmalloc(ENCODED_SIZE(resp_len));
>> should be,
>>      response_64 =3D xmalloc(ENCODED_SIZE(resp_len) + 1);
>
> Good catch.  Thanks for looking it over.
>
> This is _your_ contribution (I only made a minor fix-up or two), so I=
'll
> apply this your v6 under your name.

OK, and thanks a lot for your time and review!
