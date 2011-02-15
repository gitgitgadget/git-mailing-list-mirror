From: Kevin Ballard <kevin@sb.org>
Subject: Re: What's the definition of a valid Git symbolic reference?
Date: Mon, 14 Feb 2011 19:19:40 -0800
Message-ID: <F624322D-359A-48ED-A241-622042F77CDA@sb.org>
References: <AANLkTinsJkzYggMtNrLRv-qNxRncrXSe6A46Z=d8xkw7@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Vicent Marti <tanoku@gmail.com>,
	libgit2@librelist.com
To: Emeric Fermas <emeric.fermas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 04:19:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpBS9-00051K-Ti
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 04:19:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995Ab1BODTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 22:19:45 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:40956 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192Ab1BODTo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 22:19:44 -0500
Received: by pzk35 with SMTP id 35so936375pzk.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 19:19:43 -0800 (PST)
Received: by 10.142.173.8 with SMTP id v8mr3777941wfe.432.1297739983908;
        Mon, 14 Feb 2011 19:19:43 -0800 (PST)
Received: from [10.8.8.46] ([69.170.160.74])
        by mx.google.com with ESMTPS id x18sm5041818wfa.23.2011.02.14.19.19.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Feb 2011 19:19:42 -0800 (PST)
In-Reply-To: <AANLkTinsJkzYggMtNrLRv-qNxRncrXSe6A46Z=d8xkw7@mail.gmail.com>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166808>

On Feb 14, 2011, at 12:58 PM, Emeric Fermas wrote:

> - As check-ref-format fails when being passed "first", does this mean
> that it's not recommended to create a symbolic reference at the same
> level than "HEAD"? Or maybe this command is not intended to deal with
> symbolic links ?

I don't know about the rest of your question, but check-ref-format
explicitly states in the manpage that the refname must have at least
one /, to enforce the presence of a category (such as heads/) in the
refname.

-Kevin Ballard
