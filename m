From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/4] Good bye fnmatch
Date: Sat, 15 Feb 2014 15:29:39 +0700
Message-ID: <CACsJy8C+3AED3p0sWb91gq6tY4zAH+k0SdMv0RkpeqJPzL+naw@mail.gmail.com>
References: <1392429709-9237-1-git-send-email-pclouds@gmail.com> <8761og3htv.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Feb 15 09:30:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEae5-0004pw-4M
	for gcvg-git-2@plane.gmane.org; Sat, 15 Feb 2014 09:30:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbaBOIaM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Feb 2014 03:30:12 -0500
Received: from mail-qc0-f177.google.com ([209.85.216.177]:65318 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374AbaBOIaL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Feb 2014 03:30:11 -0500
Received: by mail-qc0-f177.google.com with SMTP id i8so21191227qcq.22
        for <git@vger.kernel.org>; Sat, 15 Feb 2014 00:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Gx5aumAJOr1GJYjYoXOb0rlPHzXl/0uBNF9cvR5c6wM=;
        b=pmTIkfNk1E0V8JzyLZVUPhtiJ6L2/yA2VmnLpY/L6wFzTjqVXtpNDHkegp+LJb7RVu
         NVdjtwddob2lWS3SFRrFYgR09OpdRgxTEaLogfHGmVRJQa4Q1yc9bEYxbBs3Z3AibbpW
         tqm8uJTuvSAvmXRpI/K3INXJ1+vO3aYUA9piZOQ5IYGHs5g5Qd6AAnf2ptD/7TrWD7q0
         lDAO5rbETjTEwS7aXVmvWEa92W8/VNOZtt/LY2hBuPcx7sJCWEHECLmkuuusAXUHW4g7
         VGDOT5+203fQAKSlg0WEURywbZUX7OuqL2MV3WxgA/5ef1KCsgDLIhHDzxxNDALHHNM4
         qoKw==
X-Received: by 10.140.24.193 with SMTP id 59mr19204895qgr.11.1392453010618;
 Sat, 15 Feb 2014 00:30:10 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Sat, 15 Feb 2014 00:29:39 -0800 (PST)
In-Reply-To: <8761og3htv.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242179>

On Sat, Feb 15, 2014 at 3:23 PM, David Kastrup <dak@gnu.org> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> Long story short, we wanted globbing wildcard "**" so I ripped
>> wildmatch library from rsync to do it.
>
> Since version 3.0.0, rsync is GPLv3
> <URL:https://rsync.samba.org/GPL.html>.  So be sure to take an older
> version.

Yes. See 5230f60 (Import wildmatch from rsync - 2012-10-15), the code
was taken from the last GPL-2 commit.
--=20
Duy
