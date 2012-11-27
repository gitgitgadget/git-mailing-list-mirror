From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: gitpacker progress report and a question
Date: Tue, 27 Nov 2012 02:38:24 +0100
Message-ID: <CAMP44s29Ns2ea9f8ozr+W-eKAv=Q8f8d30t9zrfXfV7Jf5ZpFw@mail.gmail.com>
References: <20121115212818.GA21558@thyrsus.com>
	<CAMP44s30px2FgieC9VcGji7T+yWFo7gMSwQhtuztHrqto8B7Aw@mail.gmail.com>
	<20121126220108.GB1713@thyrsus.com>
	<CAMP44s2+NDyL2Vf=iKR09f-YUnp=G2BCiYj-+qKuP7JA-+YkmQ@mail.gmail.com>
	<20121126234359.GA8042@thyrsus.com>
	<CAMP44s3HAzSPsrGwcpQpx_3n2aHK5wm++_7_Cbk3qRWMkxDh6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Tue Nov 27 02:38:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdA8F-0000hr-V1
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 02:38:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757804Ab2K0BiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 20:38:25 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:65362 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757724Ab2K0BiY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 20:38:24 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so11899875oag.19
        for <git@vger.kernel.org>; Mon, 26 Nov 2012 17:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gaQTl7FJm/UqQbM+0Qwa4w3K8FGlX4NA0igf92UAv1A=;
        b=QlVunXCHZunBJ9brM+Fa8Qn+MMrYoswOCuMNlRvIzv9/Wl41N1LC6Ky/nRysVvPUgr
         FuZAlVewsFgXRTpN4umIKOj4MQcQOt/b1IbYZLIa7eSIneCDYe9E/54VkvNFq3GQGHns
         IIM9GCO1YaqzeQzzdL1/8reaCM+UDAn95m1o0EPRzKXYc7n+0tZT9tEm+M+n40ufg2me
         CVmQE58S5oW51Ytd/Fs+N5Gf8pZr1zcD+Cp2XBNXJWeX0klCTP6ld+Vf+lyvYIEceKWl
         u9wG/vAq5RMyBnZj+jXOqA4z/BW4SPFZumZafpmBxTBchxvVV7xtpMHyP6SdFKsmCAb3
         ApKw==
Received: by 10.60.28.132 with SMTP id b4mr5389761oeh.41.1353980304181; Mon,
 26 Nov 2012 17:38:24 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Mon, 26 Nov 2012 17:38:24 -0800 (PST)
In-Reply-To: <CAMP44s3HAzSPsrGwcpQpx_3n2aHK5wm++_7_Cbk3qRWMkxDh6g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210524>

On Tue, Nov 27, 2012 at 2:29 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:

Actually no, they are not exactly the same, your version has a bug
when dealing with spaces in a commit message (which pretty much all
proper multi-line commit messages have).

> == spaces ==
> with
> spaces
>

Mine doesn't:

> == spaces ==
> with
>
> spaces
>

-- 
Felipe Contreras
