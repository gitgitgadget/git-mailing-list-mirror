From: Greg Brockman <gdb@MIT.EDU>
Subject: Re: What's cooking in git.git (Aug 2010, #02; Wed, 11)
Date: Thu, 12 Aug 2010 18:13:02 -0400
Message-ID: <AANLkTi=Pcn_mwr=5Znr5a3KvN4BAPpqUjro45Lfj7WGF@mail.gmail.com>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
	<4C63BD9B.6000608@viscovery.net>
	<AANLkTi=MenKX7Eh5PTpjfiYirrgLBCamWgorA35rx-Fy@mail.gmail.com>
	<7v62zfqya9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Elijah Newren <newren@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 00:13:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ojg1R-00028d-5n
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 00:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934005Ab0HLWNJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 18:13:09 -0400
Received: from DMZ-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.35]:58922 "EHLO
	dmz-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760920Ab0HLWNG convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 18:13:06 -0400
X-AuditID: 12074423-b7cb4ae000000a9b-a0-4c6471e4d581
Received: from mailhub-auth-1.mit.edu (MAILHUB-AUTH-1.MIT.EDU [18.9.21.35])
	by dmz-mailsec-scanner-6.mit.edu (Symantec Brightmail Gateway) with SMTP id D7.AC.02715.4E1746C4; Thu, 12 Aug 2010 18:12:53 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id o7CMD4e2023084
	for <git@vger.kernel.org>; Thu, 12 Aug 2010 18:13:04 -0400
Received: from mail-gw0-f46.google.com (mail-gw0-f46.google.com [74.125.83.46])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o7CMD2rl026113
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Thu, 12 Aug 2010 18:13:03 -0400 (EDT)
Received: by gwb20 with SMTP id 20so624031gwb.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 15:13:02 -0700 (PDT)
Received: by 10.231.183.134 with SMTP id cg6mr446519ibb.197.1281651182329;
 Thu, 12 Aug 2010 15:13:02 -0700 (PDT)
Received: by 10.231.154.212 with HTTP; Thu, 12 Aug 2010 15:13:02 -0700 (PDT)
In-Reply-To: <7v62zfqya9.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: AAAAAxWWOO0VlwALFZcTug==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153430>

My apologies... I'm still trying to figure out my way around the
conventions around here, and hadn't intended that as an indicator to
not pick up the patch.  I'll submit a revised version using
expanduser("~").

Greg



On Thu, Aug 12, 2010 at 6:08 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Greg Brockman <gdb@MIT.EDU> writes:
>
>>>> * gb/shell-ext (2010-07-28) 3 commits
>>>> =A0- Add sample commands for git-shell
>>>> =A0- Add interactive mode to git-shell for user-friendliness
>>>> =A0- Allow creation of arbitrary git-shell commands
>>>
>>> This needs work on Windows because we do not have geteuid(), perhap=
s just
>>> a compiler flag -Dgeteuid=3Dgetuid
>> I had a submitted a revised patch that just uses HOME, see
>> http://thread.gmane.org/gmane.comp.version-control.git/152050/focus=3D=
152135.
>> =A0I guess that didn't make it in yet.
>
> No, it didn't; because you said
>
> =A0 =A0Err, actually it would probably be a good idea to
> =A0 =A0s/char *home =3D getenv("HOME");/const char *home =3D getenv("=
HOME");/
>
> =A0 =A0Greg
>
> hinting me not to pick it up.
>
