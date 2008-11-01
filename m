From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: Re: [PATCH] add instructions on how to send patches to the mailing list with Gmail
Date: Sat, 1 Nov 2008 11:00:05 +0100
Message-ID: <adf1fd3d0811010300ye0aca83t12d271388d35b8d4@mail.gmail.com>
References: <b97024a40811010028l36606128v61172807f4cf503a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Tom Preston-Werner" <tom@github.com>
X-From: git-owner@vger.kernel.org Sat Nov 01 11:01:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwDIX-0004Nq-DL
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 11:01:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbYKAKAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 06:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbYKAKAK
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 06:00:10 -0400
Received: from mu-out-0910.google.com ([209.85.134.189]:36036 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbYKAKAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 06:00:09 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1560224muf.1
        for <git@vger.kernel.org>; Sat, 01 Nov 2008 03:00:07 -0700 (PDT)
Received: by 10.103.214.8 with SMTP id r8mr6012775muq.125.1225533606062;
        Sat, 01 Nov 2008 03:00:06 -0700 (PDT)
Received: by 10.103.179.20 with HTTP; Sat, 1 Nov 2008 03:00:05 -0700 (PDT)
In-Reply-To: <b97024a40811010028l36606128v61172807f4cf503a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99723>

On Sat, Nov 1, 2008 at 8:28 AM, Tom Preston-Werner <tom@github.com> wrote:
> Gmail is one of the most popular email providers in the world. Now that Gmail
> supports IMAP, sending properly formatted patches via `git imap-send` is
> trivial. This section in SubmittingPatches explains how to do so.
>
> Signed-off-by: Tom Preston-Werner <tom@github.com>
> ---
>  Documentation/SubmittingPatches |   27 +++++++++++++++++++++++++++
>  1 files changed, 27 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index a1e9100..f0295c6 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -456,3 +456,30 @@ This should help you to submit patches inline using KMail.
>
>  5) Back in the compose window: add whatever other text you wish to the
>  message, complete the addressing and subject fields, and press send.
> +
> +
> +Gmail
> +-----
> +
> +Submitting properly formatted patches via Gmail is simple now that
> +IMAP support is available. First, edit your ~/.gitconfig to specify your
> +account settings:
> +
> +[imap]
> +       folder = "[Gmail]/Drafts"
> +       host = imaps://imap.gmail.com
> +       user = user@gmail.com
> +       pass = p4ssw0rd
> +       port = 993
> +       sslverify = false

Warning: It is not secure.

> +
> +Next, ensure that your Gmail settings are correct. In "Settings" the
> +"Use Unicode (UTF-8) encoding for outgoing messages" should be checked.
> +
> +Once your commits are ready to send to the mailing list, run the following
> +command to send the patch emails to your Gmail Drafts folder.
> +
> +       $ git format-patch -M --stdout origin/master | git imap-send
> +
> +Go to your Gmail account, open the Drafts folder, find the patch email, fill
> +in the To: and CC: fields and send away!

Are you sure the mail does not get whitespace damaged?

Santi
