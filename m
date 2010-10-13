From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] Fix to push --progress. The --progress flag was not being
 passed into tranport.c from send-pack.h, making the --progress flag unusable
Date: Thu, 14 Oct 2010 02:40:56 +0800
Message-ID: <AANLkTim-0wzsX1XxbjXEyf0hg+5T5P_yPCoaNQ2ReKV5@mail.gmail.com>
References: <AANLkTin9_kofdy49WF4V_JoovVR+G8DN7vn-cz3p84fz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Chase Brammer <cbrammer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 20:41:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P66GA-0006uM-0Y
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 20:41:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042Ab0JMSk7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Oct 2010 14:40:59 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:53178 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298Ab0JMSk7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Oct 2010 14:40:59 -0400
Received: by ewy20 with SMTP id 20so2505654ewy.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 11:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YgRAt6y53AQM3/FTmBvznlFn7DWrmMR9RwMCtLF9Oio=;
        b=e7WU3F1zsu6YPQdEv4J7iBE+aCDYKPspmVRR4c7SScsk4HTMD3lUstoaCjAQR2qaeD
         E6VbYEx21JWUCFCUVwWE/+TZOKYy+jXSz4PLIPITNaldWxajlD2RHpgxQUwGRfVOj3cB
         iJoMIBfRMnaKKLyQ9ttauFJcQ2UP9g0Ly60yg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BXXjOny31th+9g5tivk02lMlHi/u0j8jBFT+e7upHrE5r9Dr7V78a/sY66CMP4tsDu
         s44866ogSdlBrNsL1dxyn7L7Sy5X5dyyFeKDwgZBm05SBq/9O+PV2gn/YZ2l97xk9Jv6
         4eCS3XVK5omAO/zBq8BmSr2UGTg+tHzmEC1+s=
Received: by 10.213.31.135 with SMTP id y7mr281779ebc.21.1286995256925; Wed,
 13 Oct 2010 11:40:56 -0700 (PDT)
Received: by 10.213.33.197 with HTTP; Wed, 13 Oct 2010 11:40:56 -0700 (PDT)
In-Reply-To: <AANLkTin9_kofdy49WF4V_JoovVR+G8DN7vn-cz3p84fz@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158959>

Hi,

On Wed, Oct 13, 2010 at 6:21 AM, Chase Brammer <cbrammer@gmail.com> wro=
te:
> The result of this is external tools and tools writing standard error
> to a file from bash would not be able to receive progress information
> during a push. =A0Similar functionality is seen in fetch, which still
> works.
>
> An example that previously would output no information for --progress=
:
> git push origin master --progress > ~/push_error_output.txt 2>&1
>
> The above example and others now work with this patch.
>
> Helped-by: Jeff King <peff@peff.net>
> Helped-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Chase Brammer <cbrammer@gmail.com>

The long subject line not withstanding, your patch seems corrupt.

Guess I'll have to write it by hand.

--=20
Cheers,
Ray Chuan
