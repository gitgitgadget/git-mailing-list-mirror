From: Antoine Pelisse <apelisse@gmail.com>
Subject: =?UTF-8?B?UmU6IEhvdyB0byBzZXQgdGFiIHNpemUgZm9yIGh1bmtzIGluIOKAnGdpdCBhZGQgLXA=?=
	=?UTF-8?B?4oCdPw==?=
Date: Fri, 23 Aug 2013 20:19:41 +0200
Message-ID: <CALWbr2xvMtXddpnkVs8TkSiaLcmpJGY7_hUTa3r_1X1SgDyhng@mail.gmail.com>
References: <52179BAB.3040505@itvault.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: alex@itvault.info
X-From: git-owner@vger.kernel.org Fri Aug 23 20:19:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCvxa-00048R-Hf
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 20:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755640Ab3HWSTm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Aug 2013 14:19:42 -0400
Received: from mail-qa0-f50.google.com ([209.85.216.50]:61962 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754761Ab3HWSTm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Aug 2013 14:19:42 -0400
Received: by mail-qa0-f50.google.com with SMTP id o13so458366qaj.2
        for <git@vger.kernel.org>; Fri, 23 Aug 2013 11:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=4H25iwmozoopgAi153MZDQWiC4KioErXSYX27zHFH7g=;
        b=dcUnoYfDqC8yLLkBW5k9DY8P3BMI/QGIbX2+xo1/ZBMClilRXT5YnggcAXYhj9T6LL
         kV7dnlZwDO/YZRv9r5YLK0cQXOHoloHys3dN8Z4G/QB4gnUs8xfh5Ek0lj9BdiqcWF5z
         U0O/STLT53bspBz/gPTCsQ8sXifD+eL5drpiMjSDhXqr5zUnU5hwor/CPx6YVPESzzGS
         UZt3qt6eLVAX+q7o40xdGyz2XdLWY0RLnoVB1azzPeT8wd/3kKLYTbsbu353R53NUpMn
         wULtyl5JySFaRZUoLj6oaroORAIkZ/XmJeDfFiDt6c0c+7I1bqfIUXB15zX9KKDPZ/gZ
         rzxw==
X-Received: by 10.49.3.131 with SMTP id c3mr1295219qec.33.1377281981311; Fri,
 23 Aug 2013 11:19:41 -0700 (PDT)
Received: by 10.49.104.211 with HTTP; Fri, 23 Aug 2013 11:19:41 -0700 (PDT)
In-Reply-To: <52179BAB.3040505@itvault.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232819>

On Fri, Aug 23, 2013 at 7:28 PM, =D0=AF=D0=BD=D1=87=D0=B0=D1=80=D1=83=D0=
=BA =D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B0=D0=BD=D0=B4=D1=80 <alex@itvaul=
t.info> wrote:
> But those settings seems does not affect on |git add -p|. How to set =
tab
> size for hunks in *git add -p* command?

That's because "git add -p" doesn't go through less/pager.
You can certainly change the tabs size for your terminal with "tabs -4"=
 though.
