From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v14 04/13] ref-filter: implement an `align` atom
Date: Mon, 31 Aug 2015 16:29:52 +0530
Message-ID: <CAOLa=ZR+TtqJsHG11P7L3v0S1T0cddFe9AoE8_ipfyaqs_B+aA@mail.gmail.com>
References: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
 <1440857537-13968-5-git-send-email-Karthik.188@gmail.com> <vpq37yzhncc.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Aug 31 13:00:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWMpX-0007bM-3j
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 13:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752845AbbHaLAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 07:00:38 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:34540 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752772AbbHaLAX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 07:00:23 -0400
Received: by obbfr1 with SMTP id fr1so90082567obb.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 04:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NMeVYGxTXgAwZCNJFjf1MSwGBZZFBF1i0yXDfm2qRuY=;
        b=MzBPOHik29UZpWPgR6G0kjkEoH5PzOvjOEg9ez5rLZXKra4xKDixFjjDeXD4UyhnZA
         ImCnEZCmkYSYqb88oppp+SfVQ0HO9hLZnAzKXSvWt3rvyZDMRtqZ1GSzsYaqXCPwXTz4
         UY4/hzvtjZuAO58ddpoqrHmFupryrBh6EMP483//c/vOnMFBHVuxSFIoK8dpHV6mgrMT
         UuAOB8XZ63gl5Hhr/djA/3oaBBbkufIphLgqkILA9pwx6doXo2BgNr5qHrdpHgucSEPx
         1sS0PRLE9vjgxH7p28EeGxj0USDSfcO2u564sIzHV9QwggAEfvJv5R1gp90CbAMoqK+3
         7TJg==
X-Received: by 10.60.81.69 with SMTP id y5mr7736946oex.30.1441018822320; Mon,
 31 Aug 2015 04:00:22 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Mon, 31 Aug 2015 03:59:52 -0700 (PDT)
In-Reply-To: <vpq37yzhncc.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276872>

On Mon, Aug 31, 2015 at 2:00 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Hi,
>
> Just a remark on the way iterations are going on with this series: I do
> agree that each version gets better than the previous one, which is
> good. However, I have the feeling that we're turning a simple and easy
> to review series into a monster one (reading "v14 .../13" with a
> non-trivial interdiff is a bit scary for reviewers).
>
> Karthik: I think you could (should?) have splitted the work again.
> You're integrating other people's idea in the series, and sometimes I
> think at some point, a better way would have been: "OK, good idea, I'll
> implement it in on top of this series" (and possibly implement it on top
> before you resend, to make sure that the series is ready to welcome the
> new feature). For example, %(contents:lines=X) is good, but could have
> waited for the next series IMHO. This way, you get a shorter series to
> converge faster (straightforward interdiff for the last iterations), and
> then reviewers can focus on the next, short, series.
>
> The opposite is Zeno paradox kind of series, where you add something new
> every time you get close to getting merged, and you actually never reach
> a stable state ;-).
>
> That said, this particular series was a tough one for this, so I'm not
> even sure my advice would have been applicable ^^.
>


What you're saying also makes sense, This series has been changing
based on the wonderful suggestions given by everyone on the list.

It has changed course and that's in a good way. But maybe you're right
I'll probably stop it with the next iteration, which I've already worked on
based on Eric's various suggestion.

So I'll push that soon, and more changes can be then added to the top of the
series.

Thanks for the suggestion.

-- 
Regards,
Karthik Nayak
