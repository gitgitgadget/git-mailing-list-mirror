From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: recovering from "unordered stage entries in index" error
Date: Fri, 22 May 2015 07:17:50 +0700
Message-ID: <CACsJy8Bdx5tto0w1q7rZ1ORx8RmHZCEKPyBqYs37k=YvbO3kzA@mail.gmail.com>
References: <D377A9280DB18546A2471214D5CBB0E908599428C7@exchdb01>
 <CACsJy8AS-9Cv6V=OKTckpnqd6OGsmvRy17TLoikT4QkA0sRofg@mail.gmail.com> <xmqqwq01kh8r.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "McHenry, Matt" <mmchenry@carnegielearning.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 22 02:18:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvafU-0001Jo-5F
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 02:18:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756117AbbEVASY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 20:18:24 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:33632 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755225AbbEVASX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 20:18:23 -0400
Received: by iebgx4 with SMTP id gx4so20563680ieb.0
        for <git@vger.kernel.org>; Thu, 21 May 2015 17:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NWzLfI53sZMsX0o4XRMRw7yjOyLnhkWGRV7E8UXY0T4=;
        b=uOiQGOsCf0tolZx5ShouvaaJmC3jTiTZJi7j4VCjB7UTN3IpTHOtNlzHkb1cTS+A/I
         Jhb9UgPjYilaFi5xc5s7hJ5GJiXiSX8N/LBpDLqNqFroe6VGEO525Qruj5j3EOw3+sMc
         +0oY738povTxWn0Nfj4ke4VCfJOu609sPwmwCb3VpXkg0iGcZpPSsA05jOG7oNRqY0cj
         CW6c2siBFTp4XajZUW7z3nY28DbkTuiIwPN/LskhechnzD2I71SEw0zeRfkiFnMdqop5
         dsQrfY9XqtA6N7s65amR8+ponjcz112C+PBdvaHekXopy6E5luIQvSuGaDzp78DhTQum
         +e8w==
X-Received: by 10.50.176.134 with SMTP id ci6mr1860560igc.27.1432253900991;
 Thu, 21 May 2015 17:18:20 -0700 (PDT)
Received: by 10.107.181.136 with HTTP; Thu, 21 May 2015 17:17:50 -0700 (PDT)
In-Reply-To: <xmqqwq01kh8r.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269676>

On Thu, May 21, 2015 at 11:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> This message can be improved to show what entries have this problem.
>> But then I don't see any way to recover the index manually. ls-files
>> will die too.
>
> Isn't this failure coming from git-svn that tries to write out a
> tree after it prepared whatever it wants to record in its (possibly
> temporary) index?  I have a feeling that the index held by the end
> user is not broken.

Ahh that would explain why ls-files works. Yep.
-- 
Duy
