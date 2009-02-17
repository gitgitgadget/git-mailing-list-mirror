From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 2/2] Google has renamed the imap folder
Date: Tue, 17 Feb 2009 12:45:17 -0500
Message-ID: <76718490902170945s5c15228bn798fe6b7e0063da@mail.gmail.com>
References: <200902171045.05904.johnflux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 18:46:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZU1v-0003qD-GX
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 18:46:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753048AbZBQRpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 12:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753039AbZBQRpU
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 12:45:20 -0500
Received: from rv-out-0506.google.com ([209.85.198.226]:25987 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753027AbZBQRpS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 12:45:18 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2106573rvb.1
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 09:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jFBccsopiALpO8KpRweSIkQsbTf3io9WJrtjC1kDKpE=;
        b=IjZe4Y686OouTWjAUoLzSTe2cyoS5dmuYiIK5GusXH21PmQ0D9DGyY9C4dvCIcMhnp
         s8/0ZxbIHJrZzfi+2DJStsX1rGvHktZ5sdSo5mIIfYTNGiwQzsvetfzn0+dJq6B1A4pT
         YVMRjaQlphAw+tivvREiBVVPLNIy77wLBBsK0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rHRIjXl2mZS5gotOCb9b54nmfHfTseBrnYp5N2BTYAgI2fc5ErmFYK2WrZF5Eshzvj
         Wy6/OtmUNWSknmHkspNK2tzFlRsxzpMUj2AazrqTQfzoYE+YDi6y0dw9mArfvdpGDSGJ
         Y67BBqwXCJoe0qXhj7M4fzp8V0ZzrjbI583YA=
Received: by 10.141.115.20 with SMTP id s20mr2122803rvm.70.1234892717613; Tue, 
	17 Feb 2009 09:45:17 -0800 (PST)
In-Reply-To: <200902171045.05904.johnflux@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110423>

On Tue, Feb 17, 2009 at 5:45 AM, John Tapsell <johnflux@gmail.com> wrote:
> Also add a comment that the web interface wraps the lines
>
> Signed-off-by: John Tapsell <johnflux@gmail.com>
> ---
>  Documentation/SubmittingPatches |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index 9b559ad..aa41c9e 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -491,12 +491,18 @@ message, complete the addressing and subject fields, and press send.
>  Gmail
>  -----
>
> +GMail does not appear to have any way to turn off line wrapping in the web
> +interface, so this will mangle any emails that you send.  You can however
> +use any IMAP email client to connect to the google imap server, and forward
> +the emails through that.  Just make sure to disable line wrapping in that
> +email client.
> +
>  Submitting properly formatted patches via Gmail is simple now that
>  IMAP support is available. First, edit your ~/.gitconfig to specify your
>  account settings:
>
>  [imap]
> -       folder = "[Gmail]/Drafts"
> +       folder = "[Google Mail]/Drafts"
>        host = imaps://imap.gmail.com
>        user = user@gmail.com
>        pass = p4ssw0rd

Hmm, maybe just point users at send-email? It has SSL support built-in
now so it can trivially use gmail's SMTP servers and you need not
worry about mangling. So the only remaining reason to use the imap
kludge is so that you have access to your gmail address book for
filling in the To/Cc fields and the subject.

j.
