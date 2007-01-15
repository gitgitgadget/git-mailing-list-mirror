From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH] Reencode committer info to utf-8 before formatting mail header
Date: Mon, 15 Jan 2007 17:53:29 +0100
Message-ID: <87k5zo44fq.fsf@morpheus.local>
References: <871wm08kcu.fsf@morpheus.local> <7vd55jrj38.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Mon Jan 15 23:14:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6a5u-0003GS-OH
	for gcvg-git@gmane.org; Mon, 15 Jan 2007 23:14:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbXAOWOT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 15 Jan 2007 17:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbXAOWOT
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 17:14:19 -0500
Received: from main.gmane.org ([80.91.229.2]:47935 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751427AbXAOWOS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 17:14:18 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H6a5b-0001id-CD
	for git@vger.kernel.org; Mon, 15 Jan 2007 23:14:04 +0100
Received: from c83-253-22-207.bredband.comhem.se ([83.253.22.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Jan 2007 23:14:03 +0100
Received: from davidk by c83-253-22-207.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Jan 2007 23:14:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-22-207.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:NYzf2U9dwkyGklL9oZsqzN8lg7M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36891>

Junio C Hamano <junkio@cox.net> writes:

>> diff --git a/utf8.h b/utf8.h
>> index a07c5a8..eb64d46 100644
>> --- a/utf8.h
>> +++ b/utf8.h
>> @@ -8,7 +8,7 @@ int is_encoding_utf8(const char *name);
>>  void print_wrapped_text(const char *text, int indent, int indent2, =
int len);
>> =20
>>  #ifndef NO_ICONV
>> -char *reencode_string(const char *in, const char *out_encoding, con=
st char *in_encoding);
>> +char *reencode_string(const char *in, const char *out_encoding, con=
st char *in_encoding, int *len);
>>  #else
>>  #define reencode_string(a,b,c) NULL
>>  #endif
>
> This feels fishy...

I admit that I didn't test-compile with NO_ICONV.

--=20
David K=C3=A5gedal
