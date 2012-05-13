From: Paul Betts <paul@paulbetts.org>
Subject: Re: XSS in search form at git-scm.com
Date: Sat, 12 May 2012 20:14:26 -0700
Message-ID: <CALaqWPBB-sriFro=6TBDJ53y9Y=-1vMYEzEutOGcDs9tLEekFg@mail.gmail.com>
References: <CANurz1edia5ctzRn9b=H-VZX6o=bmEiS2WMbqyQTXN0VrhYtcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: forshr@gmail.com
X-From: git-owner@vger.kernel.org Sun May 13 05:15:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STPH4-0000cA-GO
	for gcvg-git-2@plane.gmane.org; Sun, 13 May 2012 05:15:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577Ab2EMDO2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 May 2012 23:14:28 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:60903 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752504Ab2EMDO1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 May 2012 23:14:27 -0400
Received: by bkcji2 with SMTP id ji2so3052757bkc.19
        for <git@vger.kernel.org>; Sat, 12 May 2012 20:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=k/oMnqKMzynG3YVLIdFj56zFbm+124i9YAVDPnW/Xwo=;
        b=li8xLr4Ljs20+zyiMqIuKpS9aUdhv4OJp/Yc5WPh/ZxRuTcroeBg574UFy47VOGjl1
         5vsDKlahsB5oMPX6ekDkHpQUlg+lPkqGM966LfgCUyxKTL79dgX/rY8OemVi9v6wW9Rt
         4Tglye1Ofs6UWZ9sv2sVfC5s1pSRpdPCcDQDZI3o8Bu7iTItfg5GrEzVZB5vCqVayYu5
         8Jk7pWxN7Nc8D8VLMPxbxoCwS/LyIxBgpql/sq5PYL+RgXctvrf+6uSfypltrOQ55WK+
         7w2FjDNuYKjWsr9qX+8ygC8ZR0hbI3wlmRUjn2bUTFsTGcno7an/AdLDEMOt1kkJbM43
         fRXw==
Received: by 10.204.128.200 with SMTP id l8mr1299542bks.94.1336878866358; Sat,
 12 May 2012 20:14:26 -0700 (PDT)
Received: by 10.204.248.145 with HTTP; Sat, 12 May 2012 20:14:26 -0700 (PDT)
In-Reply-To: <CANurz1edia5ctzRn9b=H-VZX6o=bmEiS2WMbqyQTXN0VrhYtcA@mail.gmail.com>
X-Gm-Message-State: ALoCoQnp9MM8b9kkDVLKfO6fjsAjVG58uIJ7sVBjqjUk8E2s6yGyrxqD0ipHOoraPa2vqMMHOxHa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197743>

Hi Anton,

Bugs for git-scm.com are tracked on GitHub, please file your issue at
https://github.com/github/gitscm-next/issues.

--=20
Paul Betts <paul@paulbetts.org>

On Fri, May 11, 2012 at 5:28 AM, Anton <forshr@gmail.com> wrote:
> Hello.
>
> Search form at git-scm.com is vulnerable to XSS.
>
> Short link
>
> bit.ly/KQ2Tcd
> http://bit.ly/K7VvJM
>
> Real links
> alert
> http://git-scm.com/search/results?search=3D%3Cscript%3Ealert('privet%=
20Lambda%20:peka:%20_/')%3C/script%3E
> Google logo
> http://bit.ly/K7VvJM
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
