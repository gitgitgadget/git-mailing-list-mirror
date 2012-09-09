From: David Chanters <david.chanters@googlemail.com>
Subject: Re: Keeping two repos in sync
Date: Sun, 9 Sep 2012 09:44:05 +0100
Message-ID: <CACffvTryOcefmqNdJ00TuDPov+TpRZRvZ46UDV-8F_cdp80SgA@mail.gmail.com>
References: <CACffvTqt9UHw1wLVDZ=PDqJuktcD8M7uUfnnuDZ5cf9gwxsSqA@mail.gmail.com>
	<m2k3w3lhjc.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Sep 09 10:44:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAd7o-0000Z5-Ce
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 10:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873Ab2IIIoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 04:44:07 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:62058 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654Ab2IIIoG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Sep 2012 04:44:06 -0400
Received: by obbuo13 with SMTP id uo13so1504532obb.19
        for <git@vger.kernel.org>; Sun, 09 Sep 2012 01:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=iIrVwIy5ztQljRg2TR41qkyk0EHDpoV0Cgj7iX99Xjk=;
        b=I80Uen7g9tzhmn9QXEQ8UktalBOCJg+xqs7qmG+MHlB1mTFP57fP9JgKK49ra3PDLS
         7/B83qAYWDVK+O0w3hiEeNEH66ECCtXgL+afBbOI636W9PkGX9yDopHgMnmWbYyu89nN
         5jf7yxhyr3zAWYjHwjclBuXXzA9hby+7DqCzqcVZek2PZ8fC2ViYIH0+gAkg+lbAi00N
         +boRRpsySzJBsRW2GVUex/cObWfL5aC6/daH0ElqPPgaw2mOV61ZzU0vnHtvQrmiWpyA
         g7xKheaRbvYxAYbixqysZk0PpEgp2rvi7CSt2DVbYhAH+xYwcDkJLtMLDJ8zyvhMkWs6
         naog==
Received: by 10.60.12.167 with SMTP id z7mr10908315oeb.121.1347180245177; Sun,
 09 Sep 2012 01:44:05 -0700 (PDT)
Received: by 10.76.85.170 with HTTP; Sun, 9 Sep 2012 01:44:05 -0700 (PDT)
In-Reply-To: <m2k3w3lhjc.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205068>

Hi,

On 9 September 2012 09:36, Andreas Schwab <schwab@linux-m68k.org> wrote:
> Add "bsd" as a remote in "portable" and cherry-pick each commit in
> "bsd".

I am already kind of doing this at the moment.  Hence:

1.  In portable, I have:

% git remote add bsd /path/to/bsd/repo
% git fetch bsd

2.  At this point I scan the two branches looking for a point to
graft; I might have done this already in the past, but the point is
since grafting is a local operation and I am not working in that
repository, I might need to do it again anyway -- that graft
represents a way of tieing the branches together at a point I can then
"git merge".

Kindly,

David
