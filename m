From: Xue Fuqiao <xfq.free@gmail.com>
Subject: Re: Cant download Git for Mac
Date: Tue, 3 Nov 2015 07:45:35 +0800
Message-ID: <CAAF+z6GTSqFjaFkZrEZ+_Vw9DOs3j_d7MvtO2G6QdVQMQpEVXw@mail.gmail.com>
References: <45B8EAA0-2886-4ACA-9E3D-37B1A47C1945@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: MH <mkckkcm@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 00:45:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtOnF-0005Mi-8z
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 00:45:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbbKBXph convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Nov 2015 18:45:37 -0500
Received: from mail-io0-f175.google.com ([209.85.223.175]:34413 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620AbbKBXpg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Nov 2015 18:45:36 -0500
Received: by iody8 with SMTP id y8so3134039iod.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2015 15:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=jCdEqvpgOOsbtAr9oqMAARlZ+fvLT+f4nFwNqTGxVXo=;
        b=lV+U2wPuEne0lLAXgiuqwzFtJztwQhSGgOemaqeCR2ujNQF2G05MiWXLmYIOjKsjM8
         2NKXv3VgIaXmcrPc8D2FW0QwIIfwsUz2DmYRWBVnQD/ONZswtz7m93EWtXHeHGzmERqP
         I9rnbNy+qydvRXiSECJctrg/sDKzAzwdvG57ubFgZjy6PecxmkUXlCnfgKxDj+8w1K1l
         Vs5cG+lXy8a41VjcSdDA8LjTJ91Z93DUIbWj2SSDBXtmWpW5QSssfSi6qXzGUgH+E14V
         1u1dwqHjo/Ywt2CnkpHLVxzZVb9AOELKwsEQeT7oIW6tqVirU9V5st/j6MoXlgxQl/vr
         ugYw==
X-Received: by 10.107.135.28 with SMTP id j28mr24788650iod.188.1446507936010;
 Mon, 02 Nov 2015 15:45:36 -0800 (PST)
Received: by 10.79.94.2 with HTTP; Mon, 2 Nov 2015 15:45:35 -0800 (PST)
In-Reply-To: <45B8EAA0-2886-4ACA-9E3D-37B1A47C1945@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280737>

On Tue, Nov 3, 2015 at 3:18 AM, MH <mkckkcm@gmail.com> wrote:
> I am trying to download Git and when I try it says =E2=80=9Cdownloadi=
ng=E2=80=9D but it isn=E2=80=99t/

Yes, I can reproduce on Firefox 41.0.2 and Google Chrome 46.0.2490.80.

> There is an option to download from source forge but I have been told=
 that is not a good idea.

Why isn't it a good idea?  IMHO they are the same.  See:

* https://github.com/git/git-scm.com/blob/master/app/controllers/downlo=
ads_controller.rb
* https://github.com/git/git-scm.com/blob/master/lib/tasks/downloads.ra=
ke
* https://github.com/git/git-scm.com/blob/master/app/views/downloads/in=
stallers/index.html.haml

> Any reason Git is not downloading from git.scm/downloads?

I don't know.  But this mailing list is not the right place to report
issues of git-scm.com.  Please report it here:
https://github.com/git/git-scm.com/issues/new

Thank you.
