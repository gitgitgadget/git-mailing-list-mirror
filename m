From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 3/4] gc --aggressive: make --depth configurable
Date: Mon, 17 Mar 2014 06:06:04 +0700
Message-ID: <CACsJy8BazLsv5PACp4WE5ToAr6S7JuByRYZ=2FErDPbiOZRZWw@mail.gmail.com>
References: <1394976904-15395-1-git-send-email-pclouds@gmail.com>
 <1394976904-15395-5-git-send-email-pclouds@gmail.com> <CAG+J_Dw=Y5d2JTOngkxH=vNg3C43nP5=y7S6VXS=aHgmBshYZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 00:07:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPK92-0000AO-I4
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 00:07:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755849AbaCPXGg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Mar 2014 19:06:36 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:61122 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755770AbaCPXGf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Mar 2014 19:06:35 -0400
Received: by mail-qg0-f42.google.com with SMTP id q107so14504009qgd.1
        for <git@vger.kernel.org>; Sun, 16 Mar 2014 16:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=CXOYTzRToYxiN/sflkPcoUhnr2kKCsqt9gw4Vry7PI0=;
        b=WgRIhxLR+SpD0CBZmSvqtzbTx04nf8S2AnuEL8L5EuDSXA2q3/lNAAihydeSpLZNjj
         3YNoZ3gAY4DHhmklPZ9gf5aZ30OnLy1MfTh5uo52efJg5o3c2GSEhgHI74EpPXGjRo/y
         8jX9Wc/3MCmGd1bOLduBXQUx6Dza4TF7yhPRddU5y2MdzqR+bASbupOiHqqPHlKnYHkk
         s1cYEEYVH4e7rZ3+ylrHPNpOY4rdD+eu9LYZp2M09XRtrESBKbJN6tOT4jCfJiF2gt/N
         gGUDzkUGqXjcbeTRHstMwey5LMx5ocwojM+d3sVMXsiWObqPvI3PCnkHx6YPzVepZvbL
         XxLQ==
X-Received: by 10.140.43.69 with SMTP id d63mr1258876qga.45.1395011194812;
 Sun, 16 Mar 2014 16:06:34 -0700 (PDT)
Received: by 10.96.146.102 with HTTP; Sun, 16 Mar 2014 16:06:04 -0700 (PDT)
In-Reply-To: <CAG+J_Dw=Y5d2JTOngkxH=vNg3C43nP5=y7S6VXS=aHgmBshYZQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244214>

On Mon, Mar 17, 2014 at 12:10 AM, Jay Soffian <jaysoffian@gmail.com> wr=
ote:
> On Sun, Mar 16, 2014 at 9:35 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com>
> wrote:
>>
>> When 1c192f3 (gc --aggressive: make it really aggressive - 2007-12-0=
6)
>> made --depth=3D250 the default value, it didn't really explain the
>> reason behind, especially the pros and cons of --depth=3D250.
>>
>> An old mail from Linus below explains it at length. Long story short=
,
>> --depth=3D250 is a disk saver and a performance killer. Not everybod=
y
>> agrees on that aggressiveness. Let the user configure it.
>
>
> Suggestion to link to the email discussion(s) on gmane in the Documen=
tation
> or at least the commit message?

If you mean the discussion back in 2007, there is a fake header
"Gmane-URL" in Linus' mail in the commit message.
--=20
Duy
