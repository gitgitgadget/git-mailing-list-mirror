From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2] git-archive: Add new option "--output" to write 
	archive to a file instead of stdout.
Date: Mon, 16 Feb 2009 18:59:33 +0100
Message-ID: <bd6139dc0902160959h689470e3mf55407bc24c96816@mail.gmail.com>
References: <599636D7828020419E3AB2DE5CCC8130036BF8B1D5@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: carlos.duclos@nokia.com
X-From: git-owner@vger.kernel.org Mon Feb 16 19:01:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ7mq-0000VY-Gi
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 19:01:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbZBPR7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 12:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbZBPR7g
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 12:59:36 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:3116 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbZBPR7f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 12:59:35 -0500
Received: by fg-out-1718.google.com with SMTP id 16so273551fgg.17
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 09:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=c80YYa0lyEBofeLHz9cCvPbEmNROOVo8VD4PjY/IQUc=;
        b=OLfMJi6tW3Csxebog20pC2X1sytz4MMttwPhUC5wMDcU9p0131kK52CQWmxqaPuep1
         ZdFgqnGAaqKKnZMoDmX1baXi+JtFZxEOqd2lWNzIaxN321NvYzP7/X551MUPN7oQUJwh
         bQ8L97tE4jd/+jipYrZ6B9UkXc8WMEb1GRkus=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=shZxBvlEKqpBDc9njpHX42U6eRUzebWay1CA7RgljCIQTAADFEwsjkymBQTZ56sxfI
         8gsBDnAl0NaZgvIHsxY1zXLHDJL7p7AquzydoJlA6K71BtgHOeGGxETaT9GBkQFVaqJr
         FPJ5RJmj8Run7Z4EHo0Xyg9GMFuuHRL61tayU=
Received: by 10.86.62.3 with SMTP id k3mr297979fga.27.1234807173669; Mon, 16 
	Feb 2009 09:59:33 -0800 (PST)
In-Reply-To: <599636D7828020419E3AB2DE5CCC8130036BF8B1D5@NOK-EUMSG-02.mgdnok.nokia.com>
X-Google-Sender-Auth: 40a23165ba46e461
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110219>

Heya,

On Mon, Feb 16, 2009 at 18:37,  <carlos.duclos@nokia.com> wrote:
> When archiving a repository there is no way to specify a file as output.
> This patch adds a new option "--output" that redirects the output to a file
> instead of stdout.
>
> Signed-off by: Carlos Manuel Duclos Vergara <carlos.duclos@nokia.com>
> ---
>
>    NOTE: I can only use a webmail client, so some of the tabs might
>    have overwritten by it. If  that's the case I'll resend the patch as
>    MIME attachment.
>
>  Documentation/git-archive.txt |    3 +
>  archive-zip.c                 |    1 -
>  archive.c                     |   17 +++++
>  t/t0024-crlf-archive.sh       |   19 +++++
>  t/t5000-tar-tree.sh           |  148 +++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 187 insertions(+), 1 deletions(-)

Fixed that for ya :).
Anything that should not go in the commit message should go after the
triple dashes. Also, please wrap your lines at 80 characters. If your
web-client does not support this, please do so manually.
For your convenience, here is a line of 79 characters:
-------------------------------------------------------------------------------

-- 
Cheers,

Sverre Rabbelier
