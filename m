From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] api-trace.txt: fix typo
Date: Tue, 5 Apr 2016 13:15:45 -0400
Message-ID: <CAPig+cRO22wVRkrMicxLe=Gw4905QMxnnxM8kvtsMJaFv76Yrg@mail.gmail.com>
References: <1459850723-46974-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 19:15:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anUZz-0007o6-Eo
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 19:15:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753210AbcDERPr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 13:15:47 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:37853 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162AbcDERPq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 13:15:46 -0400
Received: by mail-ig0-f177.google.com with SMTP id g8so19950416igr.0
        for <git@vger.kernel.org>; Tue, 05 Apr 2016 10:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=bK3dWc5qBj+Q13jEecSgBFLT3xWfwym+e8wy1y023xU=;
        b=r8hdAxvShFC1r5vKpfRFpCROacmbKnHASsNzc7tQUi0HGMarfU2c60euzg3saKAD0p
         BOcgh3yhx98h96ZBXnZnJb3bkbAeEqTdRw5S/cDo2B/7TlaWFglKH70h+ypYCTk+3MPf
         ubIpUxhViJqZ2gwtnVVXbk8E9IfCQanhIPOyJGxxN7CB1hsymkLyb9LQd3MhdOyklb0/
         CkGjqv3mneHBtObTQNOn7tuq4k/GcLybKv2rLZ6C84llTsppynMA+jfIBXMEk3BJYCoQ
         z121u+lExkAeuCovGo0MPF4GBVSSP9cbkj9m2uQcbtwYolv+IAsTuZs572pk27oRAY20
         hvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=bK3dWc5qBj+Q13jEecSgBFLT3xWfwym+e8wy1y023xU=;
        b=AyrEWVD72ybBycQjFxY7tot1ebSg3LGFpdBZBond++jU0y+eXIHHIepwqjLnSh8qlP
         Jvkk0u6NjARBNjL3KI52nrKSPlGsFTskfcPTzI5Ydx+D7K4R5rbr5WCXQx360aYe4VQY
         JOwGZ2Qv+eyab1q/KKWrplKoX2Ja4f2k2YhDr0LV2UsChr4efzv3lBXJOoGY+bEUtYVF
         popUc8JaSadnOD8OHfSmA44jaEUbgnL8I/qs8KcxveCNUeL1nPU0odUviN3iIb0tul6k
         133wmXWoJ18UtTeoV9SZD+V1jBEBQkRpenTQpVjadM5oWbV9LQRwQhcJ+mGD/sNAdCah
         YQ8g==
X-Gm-Message-State: AD7BkJJ7W2ZqaN91Q9DVdBWr1yBAFR3bOgzzDEDaIotAE/dFiOJqTXT/+++TCxjdmUwhssbJWyqHskxzecpBNg==
X-Received: by 10.50.40.101 with SMTP id w5mr18180867igk.17.1459876545444;
 Tue, 05 Apr 2016 10:15:45 -0700 (PDT)
Received: by 10.79.12.139 with HTTP; Tue, 5 Apr 2016 10:15:45 -0700 (PDT)
In-Reply-To: <1459850723-46974-1-git-send-email-gitter.spiros@gmail.com>
X-Google-Sender-Auth: hbnklHYvDSKiYQhbO-hHQTF3AnQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290800>

On Tue, Apr 5, 2016 at 6:05 AM, Elia Pinto <gitter.spiros@gmail.com> wrote:
> The correct api is trace_printf_key
>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
> diff --git a/Documentation/technical/api-trace.txt b/Documentation/technical/api-trace.txt
> @@ -28,7 +28,7 @@ static struct trace_key trace_foo = TRACE_KEY_INIT(FOO);
>  static void trace_print_foo(const char *message)
>  {
> -       trace_print_key(&trace_foo, message);
> +       trace_printf_key(&trace_foo, message);
>  }

Since you're touching this already, I wonder if it would make sense to
rewrite this example to avoid the dangerous sending of an arbitrary
string (which might contain %) to a printf-like function. Like this,
for example:

    trace_printf_key(&trace_foo, "%s", message);
