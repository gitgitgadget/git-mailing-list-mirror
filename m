From: Keshav Kini <keshav.kini@gmail.com>
Subject: Re: [spf:guess,mismatch] [PATCH v2] diff.c: keep arrow(=>) on show_stats()'s shortened filename part to make rename visible.
Date: Sat, 12 Oct 2013 00:35:15 -0500
Message-ID: <87mwmfyru4.fsf@gmail.com>
References: <38848735-7CFA-404E-AE51-4F445F813266@gmail.com>
	<A15CCF08-83FD-4F3C-9773-C26DEE38FD33@gmail.com>
	<52584125.1090706@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 07:35:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUrrS-0002tr-Ch
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 07:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751Ab3JLFf2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Oct 2013 01:35:28 -0400
Received: from plane.gmane.org ([80.91.229.3]:55950 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751225Ab3JLFf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 01:35:27 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VUrrK-0002ng-Jx
	for git@vger.kernel.org; Sat, 12 Oct 2013 07:35:26 +0200
Received: from cpe-72-179-6-119.austin.res.rr.com ([72.179.6.119])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 07:35:26 +0200
Received: from keshav.kini by cpe-72-179-6-119.austin.res.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 07:35:26 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: cpe-72-179-6-119.austin.res.rr.com
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Cancel-Lock: sha1:gLRZxxY9sn19KLx/9QTzw3mNI1A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235943>

Sam Vilain <sam@vilain.net> writes:

> On 10/11/2013 06:07 AM, Yoshioka Tsuneo wrote:
>> +				prefix_len =3D ((prefix_len >=3D 0) ? prefix_len : 0);
>> +				strncpy(pre_arrow, arrow - prefix_len, prefix_len);
>> +				pre_arrow[prefix_len] =3D '=C2=A50';
>
>
> This seems to be an encoding mistake; was this supposed to be an ASCI=
I
> arrow?

That's supposed to be a null terminator character, '\0'. See
https://en.wikipedia.org/wiki/Yen_symbol#Code_page_932

-Keshav
