From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 14/14] Documentation: add documentation for 'git interpret-trailers'
Date: Mon, 10 Feb 2014 02:17:50 -0500
Message-ID: <CAPig+cQePC+ozQL9RqGhU8kJL=JOauuJHSSTJZXLP5m7Qhc-Pw@mail.gmail.com>
References: <20140206194123.325.99451.chriscool@tuxfamily.org>
	<20140206202004.325.93939.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Feb 10 08:17:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCl7r-00068J-9a
	for gcvg-git-2@plane.gmane.org; Mon, 10 Feb 2014 08:17:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbaBJHRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Feb 2014 02:17:51 -0500
Received: from mail-yh0-f53.google.com ([209.85.213.53]:41440 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbaBJHRu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Feb 2014 02:17:50 -0500
Received: by mail-yh0-f53.google.com with SMTP id v1so4728138yhn.12
        for <git@vger.kernel.org>; Sun, 09 Feb 2014 23:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=s9KthUjQHWB3vdN+XJyu51RA32hsajYccPQSEGB2FvQ=;
        b=KqtoagzD2FEhNKG89+UC3XazbqKc7CkOcb+PC43LHE8d/WB3qO5rkVio6I4vRr7RBj
         HNlz8Ak/6+snvlNmCwI1VZDPrhIsrQwatJeQl6A/LdscUvhqZklWoMBLuvflAwFnlmFE
         JgLG8EiRUQgQalsMnzdNEjuw8tXkMnK5Hx/IiWDeRXMWASpiRbZiBfwFA4WCYUPzKAPv
         B02xSKITRorgKe5aJX/g/kJ/GW5oSx4KA7E4lz5LYYDIs1+KTTSRMBGbJxDJDGTb8wTK
         EHA+HYzw8E9USSX3HJHeSwq1uDMpIsMH6qd7Vdypa2Kq3fsQ86pBMFrkx9jP0q4Pg+MI
         ylkg==
X-Received: by 10.236.174.37 with SMTP id w25mr26258923yhl.36.1392016670203;
 Sun, 09 Feb 2014 23:17:50 -0800 (PST)
Received: by 10.170.189.143 with HTTP; Sun, 9 Feb 2014 23:17:50 -0800 (PST)
In-Reply-To: <20140206202004.325.93939.chriscool@tuxfamily.org>
X-Google-Sender-Auth: C8DPGEAjIYv5_jBc11OnEmB6NXw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241903>

On Thu, Feb 6, 2014 at 3:20 PM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
> new file mode 100644
> index 0000000..0617941
> --- /dev/null
> +++ b/Documentation/git-interpret-trailers.txt
> @@ -0,0 +1,132 @@
> +OPTIONS
> +-------
> +--trim-empty::
> +       If the 'value' part of any trailer contains only whitespace,
> +       the whole trailer will be removed from the resulting message.
> +
> +----infile=<file>::
> +       Read the commit message from `file` instead of the standard
> +       input.

s/----/--/

> +
> +CONFIGURATION VARIABLES
> +-----------------------
