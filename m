From: Jonathan del Strother <maillist@steelskies.com>
Subject: Re: v1.7.0-rc0 shows lots of "unable to find <sha1>" on git-stash
Date: Sat, 30 Jan 2010 00:46:17 +0000
Message-ID: <57518fd11001291646l5b0b581dm553689232b0910e8@mail.gmail.com>
References: <57518fd11001290712s2585e468o73b746b7ca27e1f1@mail.gmail.com> 
	<7vzl3wiz59.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>, Jens.Lehmann@web.de
X-From: git-owner@vger.kernel.org Sat Jan 30 01:47:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb1UJ-0004uv-M4
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 01:47:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754800Ab0A3Aqq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2010 19:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754519Ab0A3Aqq
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 19:46:46 -0500
Received: from juliet.asmallorange.com ([207.210.105.70]:48863 "EHLO
	juliet.asmallorange.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017Ab0A3Aqp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jan 2010 19:46:45 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:56670)
	by juliet.asmallorange.com with esmtpsa (TLSv1:RC4-MD5:128)
	(Exim 4.69)
	(envelope-from <maillist@steelskies.com>)
	id 1Nb1U6-0003Wk-6m
	for git@vger.kernel.org; Fri, 29 Jan 2010 19:46:46 -0500
Received: by ewy1 with SMTP id 1so2511444ewy.39
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 16:46:40 -0800 (PST)
Received: by 10.216.88.140 with SMTP id a12mr719419wef.157.1264812397135; Fri, 
	29 Jan 2010 16:46:37 -0800 (PST)
In-Reply-To: <7vzl3wiz59.fsf@alter.siamese.dyndns.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - juliet.asmallorange.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - steelskies.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138413>

On 29 January 2010 17:44, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan del Strother <maillist@steelskies.com> writes:
>
>> Heya,
>>
>> git-stash in v1.7.0-rc0 gives me several hundred lines of :
>> The previous build I was using -
>> 5b15950ac414a8a2d4f5eb480712abcc9fe176d2 from Jan 19th - didn't show
>> this problem. =C2=A0Want me to try and bisect further?
>
> Yes, please.
>

ee6fc514f2df821c2719cc49499a56ef2fb136b0 (Show submodules as modified
when they contain a dirty work tree) seems to be the first bad commit.
