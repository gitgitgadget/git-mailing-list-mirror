X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: Collection of stgit issues and wishes
Date: Wed, 13 Dec 2006 11:20:20 +0100
Message-ID: <457FD3E4.3090104@op5.se>
References: <20061208221744.GA3288@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0612120143j7d0c1026rab046c8f44ec43ca@mail.gmail.com> <87y7pc2rc7.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 13 Dec 2006 10:20:35 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <87y7pc2rc7.fsf@morpheus.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34199>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuRDu-0003zZ-NM for gcvg-git@gmane.org; Wed, 13 Dec
 2006 11:20:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932649AbWLMKUX convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006 05:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932652AbWLMKUX
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 05:20:23 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:42320 "EHLO
 smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S932649AbWLMKUW (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006
 05:20:22 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 44D5C6BCBF; Wed, 13 Dec 2006 11:20:21 +0100 (CET)
To: =?ISO-8859-15?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
Sender: git-owner@vger.kernel.org

David K=E5gedal wrote:
> "Catalin Marinas" <catalin.marinas@gmail.com> writes:
>=20
>> On 08/12/06, Yann Dirson <ydirson@altern.org> wrote:
>>> - shortcuts (st -> status, etc.), possibly making use of the git al=
ias
>>> system ?
>> Did this last night as it was pretty easy and without the GIT alias
>> system (which I am not familiar with). The idea is that if it cannot
>> find an exact match, it tries to look for all the commands starting
>> with the passed argument. If more than one command is found, it
>> reports an "ambiguous command".
>=20
> That approach can cause problems later on.  If "stgit st" is currentl=
y
> a unique prefix of "stgit status", people might use it in scripts.
> Then, one day, you add the "stgit store" command, or whatever, and
> their scripts start breaking for no good reason.
>=20

People who use abbreviations of commands in scripts ought to be shot,=20
not catered to, especially if they know this abbreviation is=20
automagically calculated.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
