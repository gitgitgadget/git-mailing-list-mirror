From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2010, #01; Tue, 9)
Date: Thu, 11 Nov 2010 19:26:47 +0700
Message-ID: <AANLkTinzT2vts+z0h5m48qjtzwDjCv8XRgRbJJDoMaNM@mail.gmail.com>
References: <7vbp5ymfyo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 13:28:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGWG2-0000sF-I4
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 13:28:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756609Ab0KKM1L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Nov 2010 07:27:11 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43993 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756575Ab0KKM1K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Nov 2010 07:27:10 -0500
Received: by mail-wy0-f174.google.com with SMTP id 28so630026wyb.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 04:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ZjEsEkx94D2OP9a7XUCxVj7TMYvgfuUalwmStVFB6DY=;
        b=uLsHiC1jEqAekZWCrVK/ACJ6lJzmuvPxU66OlYVsdfVtbyQ5LuTaoDPSBSD0A6YmBn
         DMA6o4wKbmcy7DiyD4Nk+pPpoicYbbWFbiQ1elC3aXj/BjmCRZGNub/1XQl6liTwOC9B
         Dkdi/sOwfy4dyKLyZS9Zn3MWAt2LyheWULNfc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=tXXB0EZtcsCxeEEeXJxtx3KW550DuOMvfgeNPEM5W0veDW8px85sqhiDqLogS9gp3U
         Le5yZrmxi5kuJnqrphXWDk3dpJ8mt1yIELflhGjrm8bMDWitPczRZ1d0t3UglJ1g0EIq
         9jR1ja54HWY/uyBQe1yTSqguRdxrXkv73mWRk=
Received: by 10.216.255.148 with SMTP id j20mr665641wes.11.1289478428358; Thu,
 11 Nov 2010 04:27:08 -0800 (PST)
Received: by 10.216.172.199 with HTTP; Thu, 11 Nov 2010 04:26:47 -0800 (PST)
In-Reply-To: <7vbp5ymfyo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161243>

On Wed, Nov 10, 2010 at 2:53 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> * nd/struct-pathspec (2010-09-20) 5 commits
> =C2=A0- ce_path_match: drop prefix matching in favor of match_pathspe=
c
> =C2=A0- Convert ce_path_match() to use struct pathspec
> =C2=A0- tree_entry_interesting: turn to match_pathspec if wildcard is=
 present
> =C2=A0- pathspec: add tree_recursive_diff parameter
> =C2=A0- pathspec: mark wildcard pathspecs from the beginning
> =C2=A0(this branch uses en/object-list-with-pathspec.)
>
> This is related to something I have long been wanting to see happen. =
=C2=A0Will
> give it another look and merge to 'next'.

I have another tree_entry_interesting() impl that does wildcard
matching without match_pathspec(). I need to test a bit more before
sending it out.
--=20
Duy
