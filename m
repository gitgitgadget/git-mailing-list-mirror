From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 14/17] t5302: disable sealth corruption tests when run
 with --packv4
Date: Sat, 21 Sep 2013 22:13:36 -0400
Message-ID: <CAPig+cSEh26JR_E3rzzr8DrvLK0Z8+d5Kk=22+iNJU+YZLi8mA@mail.gmail.com>
References: <1379771883-10278-1-git-send-email-pclouds@gmail.com>
	<1379771883-10278-15-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>, Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 22 04:13:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNZB7-00016E-LP
	for gcvg-git-2@plane.gmane.org; Sun, 22 Sep 2013 04:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716Ab3IVCNi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Sep 2013 22:13:38 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:44264 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752535Ab3IVCNh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Sep 2013 22:13:37 -0400
Received: by mail-la0-f49.google.com with SMTP id ev20so1484281lab.22
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 19:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=FiveeE55GFiqGRJDzPZ+DkF75PZ83AGETkm9N+s/V04=;
        b=uIZ7qxH3yVYofmXUrBzLS+hPut0PTt7sOATnswPoFzejA2jmglAlmWLW/auXe1kGiB
         MK7G6KQ06OJ4s1umYgsxmCMPZNid6vm6kUVRNkfFFTdauuizYsGbeYsmKInIQ42rbFe5
         ysPqXyhFxGba3cLmXJWnMUnxXCI7cg/yCkD0+atAeo5S1FcazG60eW7RJqe/hAuoMQZE
         fd/MVXSMVLvHGSJB0oZ3CuiXQG9RjHiIJWebr16E3RT2S3D6lMmJmhZ2ljkXXQ4lc1Le
         ilmVzdFVGudO31kaqSmD977YiyADLm1CADQ4zCCmeWJM319ppeQV/kOP72dWhZEgJeQ8
         xf8Q==
X-Received: by 10.112.168.35 with SMTP id zt3mr13123126lbb.11.1379816016384;
 Sat, 21 Sep 2013 19:13:36 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Sat, 21 Sep 2013 19:13:36 -0700 (PDT)
In-Reply-To: <1379771883-10278-15-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: ebryD_95zXV4WpGFKK_0CdHHftg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235155>

On Sat, Sep 21, 2013 at 9:58 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> [PATCH 14/17] t5302: disable sealth corruption tests when run with --=
packv4

s/sealth/stealth/

> These tests assume .pack v2 format and won't work with v4. New tests
> may be needed to do the same thing with v4 format.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
