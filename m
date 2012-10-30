From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] completion: simplify __gitcomp test helper
Date: Tue, 30 Oct 2012 22:43:10 +0100
Message-ID: <CAMP44s34yBSurkiCb7bvJFt82_F=hdkFLDyd0o=9Yrsn-TRWqg@mail.gmail.com>
References: <1350869941-22485-1-git-send-email-felipe.contreras@gmail.com>
	<1350869941-22485-3-git-send-email-felipe.contreras@gmail.com>
	<20121030212725.GA15709@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Oct 30 22:43:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTJam-0000YC-OS
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 22:43:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934784Ab2J3VnN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Oct 2012 17:43:13 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:54568 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934781Ab2J3VnK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Oct 2012 17:43:10 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so776361obb.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 14:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ESsOCtJqVa65KVWO63eNTmqPRGA4WTDywg2Rth7wuKY=;
        b=iNj6Whh5+rMmeMQWgxcEo468g0CcIIL144SxsfhxBecMOIhNR0e3Sz7B0YirlU7Fkh
         Vvv5wcNjLRCVWZVr1KVVSKEt2uEJegGGpKhKxulhTAbz4sM9InuSTcB69gKh2GFTADmx
         R3fZrC7uZvVZQqsGQ/GtFO39kI3o5iLw7HM8eay5IeDKswZ4tIe0H6MDf8O/SlCe/kDS
         f0nxrSmTxcUe6GFqiXo2FoUO1OfGOSR9ZI53APEKxmXrHO5nmzXvsHNQvzk9Gxw2QR0J
         bw2OEGdlDCm89IHm6itEURIeVfo7+/s5jr51KyULMyY4pTFPyccg6BVTmF2sHwLiNmnN
         w4vg==
Received: by 10.182.52.105 with SMTP id s9mr28934696obo.25.1351633390375; Tue,
 30 Oct 2012 14:43:10 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Tue, 30 Oct 2012 14:43:10 -0700 (PDT)
In-Reply-To: <20121030212725.GA15709@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208749>

On Tue, Oct 30, 2012 at 10:27 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de>=
 wrote:
> On Mon, Oct 22, 2012 at 03:39:01AM +0200, Felipe Contreras wrote:
>> By using print_comp as suggested by SZEDER G=C3=A1bor.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  t/t9902-completion.sh | 13 +++++--------
>>  1 file changed, 5 insertions(+), 8 deletions(-)
>>
>> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
>> index 1c6952a..2e7fc06 100755
>> --- a/t/t9902-completion.sh
>> +++ b/t/t9902-completion.sh
>> @@ -74,15 +74,12 @@ newline=3D$'\n'
>
> This $newline variable was only used to set IFS to a newline inside S=
Q
> blocks.  AFAICS after this change there are no such places left,
> because print_comp() takes care of IFS, so $newline is not necessary
> anymore.

Right, I thought I did that =3D/

--=20
=46elipe Contreras
