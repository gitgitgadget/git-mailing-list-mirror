From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/9] for-each-ref: add %(current) for current branch marker
Date: Sun, 19 May 2013 16:44:57 +0530
Message-ID: <CALkWK0mYH1YSYkQeu=t8=fHyQT+MUmbccTBJm89NFo3NoPsvjw@mail.gmail.com>
References: <1368959235-27777-1-git-send-email-pclouds@gmail.com> <1368959235-27777-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 13:15:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue1aY-0003JU-TW
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 13:15:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754062Ab3ESLPi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 May 2013 07:15:38 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:46497 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753899Ab3ESLPh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 May 2013 07:15:37 -0400
Received: by mail-ie0-f177.google.com with SMTP id 9so12201564iec.36
        for <git@vger.kernel.org>; Sun, 19 May 2013 04:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=38cVQkz5yy3Advb9MDaWkk2FG0uYSqH3ThWeKECtQ+Y=;
        b=Bkl+7y2S1PkRHnOJubKsJX9zkX/pXMzdrCB6nC2xx2kKPQH80El4D65IQ/EC4zwd9K
         1y0cvWsXBcd8luJ7RdNz7PsHLqYXODDjnYoleReGEJY0dEYu5TfEtTOa9S3nECNWvrKT
         3QRpDvk94/byvnKvdyigeqeHou3xCjAVmS6D6A3BLBbaDJgJ297yiR3rerW0QDdfZe3/
         MCJVPo4viBKAJm7WQpEbjbuzOYRr2/iBKeZdo6fLXW0cWzP695kZv4iGDnPludxKwhSG
         w6yXfGLQ7HtV66jZzdFHJktEVDWdcXT/OQVBum9jBCax/pp7mUgMUNGwM6CUMUIcUhJk
         MySQ==
X-Received: by 10.50.73.65 with SMTP id j1mr2851732igv.49.1368962137081; Sun,
 19 May 2013 04:15:37 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Sun, 19 May 2013 04:14:57 -0700 (PDT)
In-Reply-To: <1368959235-27777-5-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224849>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index 08d4eb1..498d703 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -75,6 +75,7 @@ static struct {
>         { "upstream" },
>         { "symref" },
>         { "flag" },
> +       { "current" },
>  };

So you've implemented it as another atom.  Good.
