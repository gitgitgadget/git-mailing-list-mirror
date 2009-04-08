From: Elijah Newren <newren@gmail.com>
Subject: Re: need help with git show :1:...
Date: Wed, 8 Apr 2009 12:07:00 -0600
Message-ID: <51419b2c0904081107s7ba08367w671d5b494095402@mail.gmail.com>
References: <6838.1239212486@relay.known.net>
	 <51419b2c0904081058p7d5a56c3j6aa5cebb0188ad43@mail.gmail.com>
	 <7199.1239213762@relay.known.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: layer <layer@known.net>
X-From: git-owner@vger.kernel.org Wed Apr 08 20:10:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrcCW-0002yP-KU
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 20:08:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755603AbZDHSHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 14:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755197AbZDHSHF
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 14:07:05 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:18884 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753709AbZDHSHC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 14:07:02 -0400
Received: by yx-out-2324.google.com with SMTP id 31so244631yxl.1
        for <git@vger.kernel.org>; Wed, 08 Apr 2009 11:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8uAXxnunT6XPi43aQszjgxrxYz32emqV9ZIn6VCSwa4=;
        b=WabOlED8C1pSYPT3uYAVLRmzfLQs+7C69ivuYWuaT45ov+UhezC5Kd/8iuFcv0ruTs
         S8qKkiPliN28l+1odUuAILQ8+xltogRrYUKQbffv6vtZLV4pnfaIPxT5jmA6yvrQKg+V
         qYJSPi1CEi7ypqvesUMr8rZFhvxTYB1U+jsy4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=S/fqTsDyxFem7Cf95MR9h5kdxLNDkIXar5xb4bKM4VyfYAjPAplhZ45cHNfwDcRoRE
         BX+l5SMh/T0e23H8khsEcXQLqmCL0MOlI0F7WWOJNVZw9XmXuQBLntcRK1QgEzs6wlnf
         2RDXhh2aA1tRCoqXqGvvUoy5pQ5Eil1BueLGs=
Received: by 10.231.11.137 with SMTP id t9mr425712ibt.49.1239214020812; Wed, 
	08 Apr 2009 11:07:00 -0700 (PDT)
In-Reply-To: <7199.1239213762@relay.known.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116102>

Hi,

On Wed, Apr 8, 2009 at 12:02 PM, layer <layer@known.net> wrote:
> Elijah Newren <newren@gmail.com> wrote:
>>> Does the file have conflicts?  Try
>>> git ls-files -s src/c/sock.c
>
> Yes, it did have conflicts.  I resolved the conflicts via editing, but
> want to look at the other versions before finalizing the edits.
>
> quadra% git ls-files -s src/c/sock.c
> 100644 ef6c9b94c678dc79760edfd15a0796b3726b76f6 0       src/c/sock.c

That suggests that the file is not unmerged, i.e. that there aren't
any remaining conflicts.  This explains why your commands wouldn't
work unless you used stage 0 instead of 1 or 2.  Now, why there
weren't conflicts when you thought there were?  I have no idea, unless
perhaps you did a stray git add src/c/sock.c.

Hope that helps,
Elijah
