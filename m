From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [PATCH] contrib/git-credential-gnome-keyring.c: small stylistic
 cleanups
Date: Sat, 07 Dec 2013 03:37:21 -0600
Message-ID: <52a2ec51d8a67_29836d5e984f@nysa.notmuch>
References: <1386066764-49711-1-git-send-email-john@szakmeister.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Szakmeister <john@szakmeister.net>
To: John Szakmeister <john@szakmeister.net>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Dec 07 10:45:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpESQ-0006U3-I2
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 10:45:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403Ab3LGJp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Dec 2013 04:45:29 -0500
Received: from mail-oa0-f52.google.com ([209.85.219.52]:63514 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181Ab3LGJp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Dec 2013 04:45:27 -0500
Received: by mail-oa0-f52.google.com with SMTP id h16so1932647oag.11
        for <git@vger.kernel.org>; Sat, 07 Dec 2013 01:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=nciYbaPzBchDpEfXLxxsIF86EFpF+IobwocVRBjTGgc=;
        b=y8dCtYqwdx5V6bAUTqlsScOaIJ+IyHhEKMeJ93NUynfnuVL/7170E029r6ARreFxqX
         Vhw6agF7OjfZk8Nty5pesDG49r2uOKWZsN6DANgKr+jAxfXCc8tmWDq+feleHqCbrax1
         UMM8Oi+Gah8oVX8BKO7l19pR6T+87Zts+IvF4oXwW1HsJ3oirVDIqky3HAVCIHYQ8BRJ
         WawV1uO5dBSDVKpm/j1E6czXB8TTJAG/c0mMrfdahCZjr4kIHgL8c+MKksi6q9x3+L+k
         Q1MeXhJbNpG4qVrZj2CsL/8ln/XjTIDgdSFHmDsueughi5Lt9pHB0QPdQ0tIdpV0PydI
         SZkA==
X-Received: by 10.60.83.17 with SMTP id m17mr144077oey.62.1386409527034;
        Sat, 07 Dec 2013 01:45:27 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id h4sm4193967oel.3.2013.12.07.01.45.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2013 01:45:26 -0800 (PST)
In-Reply-To: <1386066764-49711-1-git-send-email-john@szakmeister.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238972>

John Szakmeister wrote:
> Signed-off-by: John Szakmeister <john@szakmeister.net>
> ---
> The gnome-keyring credential backend had a number of coding style
> violations.  I believe this fixes all of them.
> 
>  .../gnome-keyring/git-credential-gnome-keyring.c   | 55 ++++++++++------------
>  1 file changed, 25 insertions(+), 30 deletions(-)
> 
> diff --git a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
> index 635c96b..1613404 100644
> --- a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
> +++ b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
> @@ -95,9 +95,9 @@ static const char* gnome_keyring_result_to_message(GnomeKeyringResult result)
>  
>  static void gnome_keyring_done_cb(GnomeKeyringResult result, gpointer user_data)
>  {
> -	gpointer *data = (gpointer*) user_data;
> -	int *done = (int*) data[0];
> -	GnomeKeyringResult *r = (GnomeKeyringResult*) data[1];
> +	gpointer *data = (gpointer *) user_data;
> +	int *done = (int *) data[0];
> +	GnomeKeyringResult *r = (GnomeKeyringResult *) data[1];

No need for these castings, a gpointer is void *, so there's no need to cast them.

-- 
Felipe Contreras
