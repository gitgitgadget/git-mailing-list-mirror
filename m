From: Kevin Ballard <kevin@sb.org>
Subject: Re: git check-attr -z and quoting
Date: Tue, 2 Nov 2010 14:24:43 -0700
Message-ID: <7583D61F-64FA-44A8-B5C5-6E0FC329ED32@sb.org>
References: <20101102155705.GA17207@gnu.kitenet.net>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Tue Nov 02 22:25:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDOLr-0004bW-6f
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 22:25:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753213Ab0KBVYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 17:24:47 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:48257 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753104Ab0KBVYq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Nov 2010 17:24:46 -0400
Received: by pvb32 with SMTP id 32so989646pvb.19
        for <git@vger.kernel.org>; Tue, 02 Nov 2010 14:24:45 -0700 (PDT)
Received: by 10.142.169.17 with SMTP id r17mr2726686wfe.68.1288733085818;
        Tue, 02 Nov 2010 14:24:45 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id y42sm11704271wfd.22.2010.11.02.14.24.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Nov 2010 14:24:44 -0700 (PDT)
In-Reply-To: <20101102155705.GA17207@gnu.kitenet.net>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160558>

On Nov 2, 2010, at 8:57 AM, Joey Hess wrote:

> First, thanks to all for supporting -z in various commands like 
> git ls-files and git diff. Big help for plumbing, as I'm sure you know.
> 
> But, git check-attr -z only enables NUL separation of its input; output
> always has munged pathnames. This bit me trying to use it as plumbing.

What do you mean by munged pathnames? As long as the path doesn't contain the sequence ": " it seems like the output should be unambiguous.

-Kevin Ballard