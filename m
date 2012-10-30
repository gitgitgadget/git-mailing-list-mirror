From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v6 2/3] completion: add new __gitcompadd helper
Date: Wed, 31 Oct 2012 00:05:34 +0100
Message-ID: <CAMP44s0dctpjobNNRTOFcX4ir+nzenTZMNWFbEvBa-QU93psbA@mail.gmail.com>
References: <1350870342-22653-1-git-send-email-felipe.contreras@gmail.com>
	<1350870342-22653-3-git-send-email-felipe.contreras@gmail.com>
	<20121030225839.GO12052@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Oct 31 00:05:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTKsW-0003j6-F0
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 00:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934772Ab2J3XFf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Oct 2012 19:05:35 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:60295 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932223Ab2J3XFe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Oct 2012 19:05:34 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so843758obb.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 16:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=h4znBm12P5bNL2WB6l1eSvZrfJKFIzeIVTrLfGEq5OA=;
        b=QdR8C864H7B8ftq1JhfOqSIhyeLE/Z9VRTOA4Zugka9uFcsLbSwDDL+HTHikVTHWoL
         YpIXpCX88qaospeuODOpL1sG8u6liKHaWUhid8kWkIyZCaQC/60grv3Seer7YRaelcr2
         uFtUcoxjWGar23ttN0a2yjsI9rNA/zLpZBZFmIJZXhn8B8EKI06l7hHJn1QDic11ZGPx
         hFQY3K0v1FX69ocFUeS0kAL/rr4WkhvkAUMCwAB8LdyBAwmjJNgDnsUfRf+L4cePcrbE
         NLvj9ZIX2wSFk2piQkULmkD7rcFROA08CMcPHSWUrak7R1YjGFnM3NSwa3BgVzMrfe0g
         WIJQ==
Received: by 10.182.10.6 with SMTP id e6mr28819780obb.16.1351638334397; Tue,
 30 Oct 2012 16:05:34 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Tue, 30 Oct 2012 16:05:34 -0700 (PDT)
In-Reply-To: <20121030225839.GO12052@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208768>

On Tue, Oct 30, 2012 at 11:58 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de>=
 wrote:
> On Mon, Oct 22, 2012 at 03:45:41AM +0200, Felipe Contreras wrote:
>> The idea is to never touch the COMPREPLY variable directly.
>>
>> This allows other completion systems override __gitcompadd, and do
>> something different instead.
>>
>> Also, this allows the simplification of the completion tests (separa=
te
>> patch).
>
> This doesn't apply anymore, does it?  The mentioned simplification is
> done in the other series.

Yeah, but you mentioned you didn't like all the COMPREPLY=3D() changes
and it might be time to get rid of them.

So this series supersedes that one.

--=20
=46elipe Contreras
