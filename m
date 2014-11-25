From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 0/2] git-am: add --message-id/--no-message-id options
Date: Tue, 25 Nov 2014 17:27:34 +0100
Message-ID: <CAP8UFD0+Ef9JbbkZ+LBHcD6DVZiMGxFdrMnjLEViHHMERY5wuw@mail.gmail.com>
References: <1416924056-29993-1-git-send-email-bonzini@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Nov 25 17:27:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtIxl-00019E-GC
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 17:27:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbaKYQ1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 11:27:36 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:34143 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbaKYQ1e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 11:27:34 -0500
Received: by mail-ig0-f174.google.com with SMTP id hn15so5274076igb.13
        for <git@vger.kernel.org>; Tue, 25 Nov 2014 08:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=g0t1qSaG2DKxNY4Vw8Kksn0dQfOIfkyT0gUuMPrfvdU=;
        b=qKl8SsmtAjfQHOhIrw5TPxXxrgIT8GCvHg9PIytIIOUGN1jpOjCmnQwwgZwvgST5vn
         xvdPCYNUwpbxr3fTsXG1BMFYmWuHDYw+wBceWX1SZp0BnN1KcjIGAojwqwO9pg2qBfvI
         /1DumDww9CRk4dNBYAv7If1bRqeYQaNyu4RIiYY4FqI15QNHoRVxOLiYN43bV+Pk7Rpz
         buTcF3xMm4OWmrNwoS55nnBKDlUT7IGrSHPPYcENaq44c5TbP2za5xJ6WpUDzJIL85cZ
         qqkO3asiZN3uMklWWKSCTS4sLD6UwnD7ieFsCwfF1u65Q3AkJJR9TI3uYyNG6bl+8ZwB
         oe9g==
X-Received: by 10.51.17.73 with SMTP id gc9mr18058325igd.24.1416932854352;
 Tue, 25 Nov 2014 08:27:34 -0800 (PST)
Received: by 10.50.30.40 with HTTP; Tue, 25 Nov 2014 08:27:34 -0800 (PST)
In-Reply-To: <1416924056-29993-1-git-send-email-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260223>

On Tue, Nov 25, 2014 at 3:00 PM, Paolo Bonzini <bonzini@gnu.org> wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
>
> This series adds a --message-id option to git-mailinfo and git-am.
> git-am also gets an am.messageid configuration key to set the default,
> and a --no-message-id option to override the configuration key.
> (I'm not sure of the usefulness of a mailinfo.messageid option, so
> I left it out; this follows the example of -k instead of --scissors).
>
> This option can be useful in order to associate commit messages with
> mailing list discussions.
>
> If both --message-id and -s are specified, the Signed-off-by goes
> last.  This is coming out more or less naturally out of the git-am
> implementation, but is also tested in t4150-am.sh.

Did you have a look at git interpret-trailers currently in master?

Best,
Christian.
