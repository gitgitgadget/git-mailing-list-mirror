From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 9/9] completion: remove __git_index_file_list_filter()
Date: Sat, 27 Apr 2013 21:41:54 -0400
Message-ID: <CAPig+cSp2wsvZaJ1vKn3UOGL4FyGFj4j4OFKQAeN-pVNMYZKaw@mail.gmail.com>
References: <1367093407-8898-1-git-send-email-felipe.contreras@gmail.com>
	<1367093407-8898-10-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 28 03:42:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWGcq-0007dB-Ji
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 03:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753894Ab3D1Bl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 21:41:56 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:51392 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770Ab3D1Blz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 21:41:55 -0400
Received: by mail-la0-f46.google.com with SMTP id fs13so1891016lab.19
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 18:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=j147ieUm/wE5ssouUG5CCAT+GPP8mmvwZp/G2I+NHd4=;
        b=ybMkIS0ssBvWl98RoxWiR5eqXl72hQQ/fNd9Mr5KApkM4C+SuQXIJombUtfIfHQspu
         QmlvUr040pllUzQ6ZCZD6XBQipuMhqBGdOUyigzDLpGkW5y7J4oec7sq9KNcMTzionQR
         kHwF4471ymZjT5+HYF0II6IT2n3/NSXxChBQWOUT7QXIyxdQEKo2PvxEFOEE3QRm4rsV
         ij7oisjA5psKM4b3oB4skg8sT2jKmEwOKA+2Sgo0obqlkK0wgyBtinyevC9m/GrqSgIW
         0iQwZxme2ek5MjIhP6urFdSOaOOQKp6T2USq+niHE5+wzMUlASZxcCme8hJBJmRP0RVN
         9rhQ==
X-Received: by 10.152.28.230 with SMTP id e6mr25043291lah.57.1367113314268;
 Sat, 27 Apr 2013 18:41:54 -0700 (PDT)
Received: by 10.114.199.11 with HTTP; Sat, 27 Apr 2013 18:41:54 -0700 (PDT)
In-Reply-To: <1367093407-8898-10-git-send-email-felipe.contreras@gmail.com>
X-Google-Sender-Auth: Bvy8vTYR7QtqgzRp9OVvYXIElFk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222720>

On Sat, Apr 27, 2013 at 4:10 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Refactor the code into the only caller; __git_index_files().
>
> Also, Somehow messing up with the 'path' variable messes up the 'PATH'

s/Somehow/somehow/
s/messing up/messing/

> variable. So let's not do that.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
