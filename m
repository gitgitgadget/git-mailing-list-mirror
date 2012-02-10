From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Git performance results on a large repository
Date: Fri, 10 Feb 2012 10:39:56 +0100
Message-ID: <CAP8UFD1RTa6+btjJrsfqjOOoCjebZBqK6xkPN7ZVLM04bHO9yw@mail.gmail.com>
References: <CACsJy8AxOZQ7S42V1g-b0vdBxPpjhFZe6qDkGaALnxQ6LiUssw@mail.gmail.com>
	<CB599BA0.42A6B%joshua.redstone@fb.com>
	<CACsJy8DQNHm8sTgxKL=+Ui5OBsJBpvPn+dRmN9bVMwq4TfNuxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Joshua Redstone <joshua.redstone@fb.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 10:40:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvmxX-00007a-9G
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 10:40:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753774Ab2BJJj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 04:39:58 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47119 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765Ab2BJJj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 04:39:57 -0500
Received: by pbcun15 with SMTP id un15so2284244pbc.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 01:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0FOQR3CNSrXiFl3dBWQuBf0Al9o+P9uEQPZmhdQsBBQ=;
        b=GwnMV2Wkb9wMziONPdxogrqxoD7oNV1nY+KDKOPLu7A6zv43+rADzly8GooS32rl73
         yB70StY1VmibofUTlaNKrnOB9cjGXnUJIdYF4ZZTxMAqJvUSjNqgFF7xcIQOj/BTTT5C
         fp862hL2renIrTw5OLCakDd8xp9ZQkq9PoCis=
Received: by 10.68.224.105 with SMTP id rb9mr14463327pbc.75.1328866796983;
 Fri, 10 Feb 2012 01:39:56 -0800 (PST)
Received: by 10.142.115.18 with HTTP; Fri, 10 Feb 2012 01:39:56 -0800 (PST)
In-Reply-To: <CACsJy8DQNHm8sTgxKL=+Ui5OBsJBpvPn+dRmN9bVMwq4TfNuxQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190396>

Hi,

On Fri, Feb 10, 2012 at 8:12 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>
> All these involve unpack_trees(), which is full tree operation. The
> bigger your worktree is, the slower it is. Another good reason to
> split unrelated parts into separate repositories.

Maybe having different "views" would be enough to make a smaller
worktree and history, so that things are much faster for a developper?

(I already suggested "views" based on "git replace" in this thread:
http://thread.gmane.org/gmane.comp.version-control.git/177146/focus=177639)

Best regards,
Christian.
