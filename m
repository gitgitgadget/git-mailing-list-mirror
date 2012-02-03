From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Problem pushing to a Novell share
Date: Fri, 03 Feb 2012 11:33:27 -0800
Message-ID: <7vipjnpv94.fsf@alter.siamese.dyndns.org>
References: <CAJ4nRM0-3GWN=OYOXDdGtktU0mc8mhcoKqbo=U4Jm5AmSbPAyQ@mail.gmail.com>
 <7vmx90vlyr.fsf@alter.siamese.dyndns.org>
 <CAJ4nRM1K=sCy8_0PG-NADVn4T0XG1ELC7AvtQyW-Dc1cUMzEXQ@mail.gmail.com>
 <7vfwesu2ma.fsf@alter.siamese.dyndns.org>
 <CAJ4nRM3xazYuNyDNE_Ff9ueGPCuH_dRtaE9s-8sLj+hhDFTY2w@mail.gmail.com>
 <CAJ4nRM2+u9OcLgJBN7+_rv1OiXETGNhozAfvYtj=hVNTfCMxhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?R=C3=BCdiger?= Kessel <ruediger.kessel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 03 20:33:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtOt5-0007wz-KR
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 20:33:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754906Ab2BCTda convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 14:33:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52946 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754773Ab2BCTd3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Feb 2012 14:33:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0893561AE;
	Fri,  3 Feb 2012 14:33:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=bhRjJKossuQj
	QjuHRZCaZkpzao0=; b=jwhsovpcHTraX/aWmfmexvk7BcCEqKE/wjx9S1E3gmr6
	cy006OGoluxzIM0M4X5ZYF+3HqKxmIqsgDTtypMDicTY1YXxrKWR4bJAVkDnEc67
	mXqnmh4uLDpKqYUGBQKVIBNMEO1DjM8gCK1JzpDH7tbiiv1IzKiR/l2fIPH4R6U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=aggAob
	57PU++jlKN35lN0wW+i4ZCyCv6sRlpXGTi05+vPc3Qru6qt6Mu+B9R1gAP6puWgk
	x35oEgruJ54lJ3X7TNYpWQmhYM5LmXTw+A4MlAA/WDRjh8j+DGveY9DPML9o5Wvx
	VX4xnCw83rs42pM7GQF2dV/OCKmqGSM4bAczM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 004D561AD;
	Fri,  3 Feb 2012 14:33:29 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8CEBB61AC; Fri,  3 Feb 2012
 14:33:28 -0500 (EST)
In-Reply-To: <CAJ4nRM2+u9OcLgJBN7+_rv1OiXETGNhozAfvYtj=hVNTfCMxhQ@mail.gmail.com>
 (=?utf-8?Q?=22R=C3=BCdiger?= Kessel"'s message of "Fri, 3 Feb 2012 17:33:37
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F2A9D000-4E9D-11E1-8957-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189792>

[jc: just forwarding to the list --- the msysgit list might have been a
better place to forward to, but I know msysgit folks read this list too=
,
so...]

R=C3=BCdiger Kessel <ruediger.kessel@gmail.com> writes:

I have confimed that it is not a mingw problem. Direct calls to
CreateFile() in kernel32.dll show the same behaviour.

On a Novel share I get Error 80 "File exists" if a directory does not
exist, while I get Error 3 "Path not found" on a local drive

2012/2/3 R=C3=BCdiger Kessel <ruediger.kessel@gmail.com>:
 Well, it is a Novell bug, but what can we do?

 I studied it in detail and open() sets errno=3DEEXIST if the directory
 is missing on a Novell share causing git_mkstemp_mode looping 16k
 times and never creates the dir.

 The correct errno would be ENOENT, but that not what the systems is se=
nding.

 So it is either using stat on the directory before trying to create
 the tmp-file or GIT cannot be used with Novell shares. What is it
 going to be?

 Protocolling the mkdir error handling I saw that git creates quite a
 number of new directories this way. Therefore my pessimistic approach
 might be too costly at the end.
