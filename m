From: Dongsheng Song <dongsheng.song@gmail.com>
Subject: gitweb.cgi bug
Date: Sat, 8 Feb 2014 21:37:58 +0800
Message-ID: <CAE8XmWqH__rx+OvO-xOejWz_TrQitJ2rHJgp1gxOzNVNmrkJmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 08 14:38:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WC86y-00067f-MK
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 14:38:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758AbaBHNiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Feb 2014 08:38:20 -0500
Received: from mail-oa0-f54.google.com ([209.85.219.54]:58410 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbaBHNiT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Feb 2014 08:38:19 -0500
Received: by mail-oa0-f54.google.com with SMTP id i4so5588850oah.13
        for <git@vger.kernel.org>; Sat, 08 Feb 2014 05:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=HIWUFrwq+OGdl/EkbkmTwcobEZ42B1mf8Kf2pOXqjT8=;
        b=i/cuWp8wKm7gaEE3/F5/XxpgGBTFYgPt5aSb0prc27QS2oFAZFb1uFv0ZfkLtYnnY1
         zC2mQ+x+OE44CPLIPrvq+QHwdo0cmx6RoCMONzdhPxpJA9IhogPifbSkiAw8Z5tO9Fbd
         geeevrHYQoDnGMY+oN5g7clqG5qNP39LwFxkEuxRgc4SZ2TebkakKMafow68SpmVes+H
         aGQhDIfYxa8gc+A1SiwTlHmVWNs8cODKf2+SCI0ZXG2w0uf4HccT9Ko+WZfLtpYo3EAg
         ajAtadW41oykxuzupr194kieSXcsaguKgJNShf4VmHEKgzeFWpL9BzpMx1H/19h13UZm
         jN8w==
X-Received: by 10.60.98.40 with SMTP id ef8mr17789278oeb.13.1391866698754;
 Sat, 08 Feb 2014 05:38:18 -0800 (PST)
Received: by 10.182.240.16 with HTTP; Sat, 8 Feb 2014 05:37:58 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241835>

On Thu, Feb 6, 2014 at 7:01 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> The latest maintenance release Git v1.8.5.4 is now available at
> the usual places.
>

I have an git repo PROJECT.git, the full path is /srv/repo/git/PROJECT.git,
when I set git_base_url_list in gitweb.conf:

@git_base_url_list = qw(https://192.168.30.239/repo/git
                            git@192.168.30.239:repo/git);

I got the result:

https://192.168.30.239/repo/git/PROJECT.git
git@192.168.30.239:/PROJECT.git

This is wrong, it should be (without the leading '/')
git@192.168.30.239:PROJECT.git

Regards,
Dongsheng
