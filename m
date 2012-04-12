From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] tests: add initial bash completion tests
Date: Thu, 12 Apr 2012 19:15:40 +0300
Message-ID: <CAMP44s2Ug91_sQ-XR3ck2k+x+eQRt9PNRRBOUnkrnNRhY6fEpw@mail.gmail.com>
References: <1334181423-4391-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 12 18:15:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIMgV-0001YR-8Y
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 18:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934490Ab2DLQPm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Apr 2012 12:15:42 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:63538 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932196Ab2DLQPm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Apr 2012 12:15:42 -0400
Received: by eekc41 with SMTP id c41so558163eek.19
        for <git@vger.kernel.org>; Thu, 12 Apr 2012 09:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=fa4hQyfoj+qORbrrd8uSIN81i5hy+cKUobaHT265ExU=;
        b=D05o8MSg9RqEvJLyXBAcRGua/39qGfhtA2SEt4bCeM0oV0jh1ei+NZzs1wL/fOSNlv
         a4lKDMSRD6LqyxCG6jeGzOHrJa6C7gpghjSWpmfdz9F/+ipPwnOwCe6b15SeyXv4K7qR
         MhAD/9NFrwfPTSptrBo6czkfx7KEPE9gLPyudjp4FLIlL2r5jT6IZ3ht5ZJPSbPpFz80
         PXIeE81ibbs5sJ0MIwgQuuIUvlCIRLt49R+c7kUzgnX7oIDC6rNrsy3ukdOwC5KEoIRj
         aY7vER8yGaiovcNtIUsJjV8VVtZ2wVKgTkrYxWH7Oh2LAK/VbwWb4AX+GVy3trTiOy1a
         KxkA==
Received: by 10.14.127.129 with SMTP id d1mr465757eei.59.1334247340607; Thu,
 12 Apr 2012 09:15:40 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Thu, 12 Apr 2012 09:15:40 -0700 (PDT)
In-Reply-To: <1334181423-4391-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195345>

On Thu, Apr 12, 2012 at 12:57 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:

> +test_expect_success 'double dash' '
> + =C2=A0 =C2=A0 =C2=A0 cat >expected <<-\EOF &&
> + =C2=A0 =C2=A0 =C2=A0 --paginate
> + =C2=A0 =C2=A0 =C2=A0 --no-pager
> + =C2=A0 =C2=A0 =C2=A0 --git-dir=3D
> + =C2=A0 =C2=A0 =C2=A0 --bare
> + =C2=A0 =C2=A0 =C2=A0 --version
> + =C2=A0 =C2=A0 =C2=A0 --exec-path
> + =C2=A0 =C2=A0 =C2=A0 --html-path
> + =C2=A0 =C2=A0 =C2=A0 --work-tree=3D
> + =C2=A0 =C2=A0 =C2=A0 --namespace=3D
> + =C2=A0 =C2=A0 =C2=A0 --help
> + =C2=A0 =C2=A0 =C2=A0 EOF
> + =C2=A0 =C2=A0 =C2=A0 test_completion "git --"

There's a mistake here ^.

--- b/t/t9902-completion.sh
+++ a/t/t9902-completion.sh
@@ -96,7 +96,7 @@ test_expect_success 'double dash' '
        --namespace=3D
        --help Z
        EOF
-       test_completion "git --"
+       test_completion "git --" &&

        sed -e "s/Z$//" >expected <<-\EOF &&
        --quiet Z

--=20
=46elipe Contreras
