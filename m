From: Kevin Ballard <kevin@sb.org>
Subject: Re: empty directories and git Question
Date: Thu, 16 Sep 2010 12:30:15 -0700
Message-ID: <CDEB2042-A498-4950-A3CD-27F111455234@sb.org>
References: <loom.20100916T095344-932@post.gmane.org> <4C91D631.9010108@op5.se>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 16 21:30:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwKA3-0001f5-I1
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 21:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755952Ab0IPTaQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Sep 2010 15:30:16 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:64427 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309Ab0IPTaP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Sep 2010 15:30:15 -0400
Received: by pzk34 with SMTP id 34so438780pzk.19
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 12:30:15 -0700 (PDT)
Received: by 10.114.36.1 with SMTP id j1mr4245487waj.141.1284665415268;
        Thu, 16 Sep 2010 12:30:15 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id k23sm4959579waf.5.2010.09.16.12.30.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Sep 2010 12:30:14 -0700 (PDT)
In-Reply-To: <4C91D631.9010108@op5.se>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156349>

Apologies to those who were CC'd on the original message, I'm resending to this list as I forgot to set plain text.

I've always wondered about that. Why do we still have this restriction? There is a sha1 hash that is equivalent to the empty tree (4b825dc642cb6eb9a060e54bf8d69288fbee4904). Why can't git just use that to represent an empty directory? I imagine things that touch the working copy may need to be updated to be aware of this, but the problem doesn't seem insurmountable.

-Kevin Ballard

On Sep 16, 2010, at 1:32 AM, Andreas Ericsson wrote:

> You can't have empty directories in git.
