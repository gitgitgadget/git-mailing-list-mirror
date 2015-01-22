From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] Fix unclosed here document in t3301.sh
Date: Thu, 22 Jan 2015 13:21:23 +0100
Message-ID: <CALKQrgdDfcGtk9MWdfQTC7hSgkDAWjN1O_U6F4BCJdMjoULD7Q@mail.gmail.com>
References: <20150122115936.GA2358@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: Kacper Kornet <draenog@pld-linux.org>
X-From: git-owner@vger.kernel.org Thu Jan 22 13:46:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEH9h-0001OE-76
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 13:46:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851AbbAVMqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 07:46:34 -0500
Received: from mail14.copyleft.no ([178.255.144.193]:44883 "EHLO
	mail14.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbbAVMqc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 07:46:32 -0500
X-Greylist: delayed 1499 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Jan 2015 07:46:32 EST
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail14.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1YEGlO-0001tk-Rs
	for git@vger.kernel.org; Thu, 22 Jan 2015 13:21:30 +0100
Received: from mail-pa0-f50.google.com ([209.85.220.50])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1YEGlO-000Icc-KX
	for git@vger.kernel.org; Thu, 22 Jan 2015 13:21:30 +0100
Received: by mail-pa0-f50.google.com with SMTP id rd3so684777pab.9
        for <git@vger.kernel.org>; Thu, 22 Jan 2015 04:21:24 -0800 (PST)
X-Received: by 10.66.141.138 with SMTP id ro10mr1631035pab.67.1421929284042;
 Thu, 22 Jan 2015 04:21:24 -0800 (PST)
Received: by 10.70.105.4 with HTTP; Thu, 22 Jan 2015 04:21:23 -0800 (PST)
In-Reply-To: <20150122115936.GA2358@camk.edu.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262825>

On Thu, Jan 22, 2015 at 12:59 PM, Kacper Kornet <draenog@pld-linux.org> wrote:
> Commit 908a3203632a02568df230c0fccf9a2cd8da24e6 introduced  indentation
> to here documents in t3301.sh. However in one place <<-EOF was missing
> -, which broke this test when run with mksh-50d. This commit fixes it.
>
> Signed-off-by: Kacper Kornet <draenog@pld-linux.org>

Acked-by: Johan Herland <johan@herland.net>

> ---
>  t/t3301-notes.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
> index 245406a..433f925 100755
> --- a/t/t3301-notes.sh
> +++ b/t/t3301-notes.sh
> @@ -658,7 +658,7 @@ test_expect_success '--show-notes=* adds to GIT_NOTES_DISPLAY_REF' '
>  '
>
>  test_expect_success '--no-standard-notes' '
> -       cat >expect-commits <<EOF
> +       cat >expect-commits <<-EOF
>                 commit 2c125331118caba0ff8238b7f4958ac6e93fe39c
>                 Author: A U Thor <author@example.com>
>                 Date:   Thu Apr 7 15:18:13 2005 -0700
> --
> 2.2.2



-- 
Johan Herland, <johan@herland.net>
www.herland.net
