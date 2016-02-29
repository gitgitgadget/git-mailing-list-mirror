From: Sidhant Sharma <tigerkid001@gmail.com>
Subject: Re: GSoC 2016 Microproject
Date: Mon, 29 Feb 2016 21:02:35 +0530
Message-ID: <56D46493.4040909@gmail.com>
References: <56D19EF9.3070702@gmail.com> <vpq8u26qo3y.fsf@anie.imag.fr>
 <56D1BEC8.9010302@gmail.com> <vpq1t7yqgi4.fsf@anie.imag.fr>
 <56D2C828.6010901@gmail.com> <vpqpovfblru.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 29 16:32:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaPoT-0003BI-AG
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 16:32:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754067AbcB2Pck (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 10:32:40 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35765 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbcB2Pcj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 10:32:39 -0500
Received: by mail-pa0-f52.google.com with SMTP id bj10so24467522pad.2
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 07:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=O6mCkIkqU/rJftH2ZARyrNvCD8NLhv7OSX8gZGzP7Sg=;
        b=L4wMf1RNDsMs/4X+Pvzj+37ALb4MPBY7+0/lA80ksOr9DKno7UG70aKpaj5RGodlxW
         5GXuYidqCjlCTUmBXapNXsMx9IR29MCp9oQYM6SBFO4I+wnEEBgFzw3FtgjxJ5vbMdo7
         OdIcvWEJeW/mZVGhfhfu6Dl+93tZH+2F/HpdPAd7iHB11iwr1dUxXm6pX8GJDVYA+7XQ
         LDP3QP2Hbzj/ZIRzbl44iB3/Vg76Vejb2fV2MsGwMOtIpa5gHpJk6/o3J/Wkel25bNGz
         m9KycQdkYA9SEygaFpDriUMXkM0gWabppDw6CkHvWT3uHZAkERrqec1Z1rOYUf0gYiKf
         VE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=O6mCkIkqU/rJftH2ZARyrNvCD8NLhv7OSX8gZGzP7Sg=;
        b=m07yOsLRoIgm3RvVIHBAICNeXpOE7R85CUctsW5yQHuTKlb51I17bw6Dc/fUQbstaz
         Qjyyp0Q7Np4LhMjtuubGwPx8D17xBi8YNRbFoAdlSdzmn5y1Zw9qJAzsGr9WBfJv8qaN
         I5SbUIWWCd4S1eTCTJ5rOFBSvX5/FoWDgRwmmYi8oljwcrFdARgqm/sTKhIQrHWDnxHF
         /03iYiaKI5QZqXboCmkmngU/uNTb5BXf6RdyZdXiou9b3SmJ4A/XLecZGDwLcXDJvRCX
         NKej5+rCj13299+dv1NJKME6fECIS1a1YEtvgXpGPyXk2Vm9dnPubIGITHBkliaSplqH
         bNLw==
X-Gm-Message-State: AD7BkJL9VNNfywe8Mjbo5abE/9Y42YfhWqkzHgxtjmqy5RLDY1rKPYffpPbWFm792WOYwQ==
X-Received: by 10.66.132.37 with SMTP id or5mr15410874pab.144.1456759959121;
        Mon, 29 Feb 2016 07:32:39 -0800 (PST)
Received: from [192.168.1.10] ([182.64.202.34])
        by smtp.gmail.com with ESMTPSA id r5sm39060284pap.7.2016.02.29.07.32.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 07:32:38 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <vpqpovfblru.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287845>


>> First, I'm not quite sure what to put in the help message for the
>> options (--quiet, --stateless-rpc, --advertise-refs and
>> --reject-thin-pack-for-testing).
> They are currently undocumented. We sometimes have explicitly
> undocumented options (PARSE_OPT_HIDDEN) when they are used only
> internally to avoid polluting the end-user's UI.
>
> In this case, the command is anyway not meant for end-users so I think
> it would make sense to document them, but not necessarily within the the
> microproject.
So what may I put in the message parameter? I was thinking
perhaps the option itself, without hyphens. Would that be
correct?
>
>> Second, regarding the reject-thin-pack-for-testing option, currently
>> when the option is entered, `fix_thin` is unset
>> (https://github.com/git/git/blob/master/builtin/receive-pack.c#L1736).
>> But using `OPT_BOOL(...)` for the same, the variable would instead be
>> set when the option is given. I think one solution can be to invert
>> `fix_thin` after calling `parse_options`. Am I going right so far?
>> Suggestions and corrections welcome.
> Or use OPT_SET_INT(..., 0) on a variable initialized to 1.
Okay, will do that.
>> Should I make a patch for this and submit it for discussion on the mailing list?
> On this list, it is indeed often more efficient to say "here's what I'm
> done. Any comments?" than "here's what I'm about to do".
>
I'm really sorry, I'm not very familiar with mailing list etiquettes.
I'll keep that in mind :)



Thanks and regards,
Sidhant Sharma [:tk]
