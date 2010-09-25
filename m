From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH/RFC] rev-parse: stop interpreting flags as options to
 rev-parse once --flags is specified
Date: Sat, 25 Sep 2010 17:25:16 +1000
Message-ID: <AANLkTim0oxhgtgqbrqP-jDL29jj0y=h6BLssEAFzags9@mail.gmail.com>
References: <robbat2-20100924T191752-102740530Z@orbis-terrarum.net>
	<1285399156-21792-1-git-send-email-jon.seymour@gmail.com>
	<AANLkTi=8gv5arpdOVGHvf7sjNd==G=a4HoBBTbizq=OK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jon Seymour <jon.seymour@gmail.com>
To: robbat2@gentoo.org, casey@nrlssc.navy.mil, git@vger.kernel.org,
	brian@gernhardtsoftware.com
X-From: git-owner@vger.kernel.org Sat Sep 25 09:26:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzP9K-0008Ti-QO
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 09:26:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754410Ab0IYHZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 03:25:18 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:62078 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956Ab0IYHZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 03:25:16 -0400
Received: by qyk36 with SMTP id 36so2363801qyk.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 00:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=EnH/uWyOTwDsHzcQeewIEC8MTaO/MA142ewASANLaaQ=;
        b=sQSC2ipZD2KABPAj3U4UQyl31auwbOGN6JcFMfblqRT7Vi+fjcw2neLnxJh1uGs3JB
         IJ/K5AWsbjBERdCRvJvmQaPSgqeC5K8BgflNjhDYOsY3pu1EAeUDVSvZGA+IfnpCyOzU
         9bWeQj6yB575eTDq5mqx42F9LX0H8Jr9PCaWI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=JXP365cOccDcV1YGxIlbAAB9P/CsGt2LFw51d2ooCj3QoSqCUAIVQfzyU3gZCwXNhG
         ppQwC8BkKvEyiB3afONc7CZw4gZBy/3d9is2zblSko3z8bfiRk3be6xTsCknkv3VaUh9
         IkUJdD4q/W4Ba+8Un1t7bNMKMakEN+vccQU50=
Received: by 10.229.52.28 with SMTP id f28mr3267240qcg.241.1285399516342; Sat,
 25 Sep 2010 00:25:16 -0700 (PDT)
Received: by 10.229.219.196 with HTTP; Sat, 25 Sep 2010 00:25:16 -0700 (PDT)
In-Reply-To: <AANLkTi=8gv5arpdOVGHvf7sjNd==G=a4HoBBTbizq=OK@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157128>

On Sat, Sep 25, 2010 at 5:19 PM, Jon Seymour <jon.seymour@gmail.com> wrote:
> On Sat, Sep 25, 2010 at 5:19 PM, Jon Seymour <jon.seymour@gmail.com> wrote:
>> Current git rev-parse behaviour makes --flags hard to use if the remaining
>> ...
>
> Note that I haven't run the test suite yet to see if it breaks
> anything. I'd also
> expect to write additional tests and update the documentation.
>
> jon.
>

Mmmm...almost certainly not going to regress anything, since there
does not seem to be a test or script that uses --flags. Ahem.

jon.
