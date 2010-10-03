From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv5 00/16] Add missing &&'s in the testsuite
Date: Sun, 3 Oct 2010 09:54:40 -0500
Message-ID: <20101003145440.GG17084@burratino>
References: <1286082644-31595-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 16:58:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Q0n-0008KJ-KV
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 16:58:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753933Ab0JCO55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 10:57:57 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50797 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650Ab0JCO54 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 10:57:56 -0400
Received: by iwn5 with SMTP id 5so5828100iwn.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 07:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=dOpLi38FUq6CjuHl9bEBy1pHBObF4wAvQlUfWBbFrig=;
        b=GJnk/sKE56JdtdfK3M6CkL6gRlOeWGk/VvYkpAO57/Jm6oCSt/W/NgZ+vq9tWFP75q
         0f5MjSlhIIh9865Hy5w5N/vxime4mmUTjOvk1QxTToU1stHA22r1TeI/oS6klrdDhTQd
         4YQXDFKRCMG2d77mRUZEXtPLHBnu/T2BPA8vg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xcBnCMrZSEYEsxN3GdR6X6sxNY232wfeOW91Hi49yjTp+mjd6JuMxP1LOiy7kNmPx5
         kh8eIZGLZpl6gtKKD39zSK82B9MffLYb7j7erm2zJ8p1oiyO9/FFS6eSJam2pXX74J+C
         kvpELE2fCjHf6nHUurInV5jXnvT28WHIJtLMM=
Received: by 10.231.161.68 with SMTP id q4mr8693052ibx.79.1286117875861;
        Sun, 03 Oct 2010 07:57:55 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id h8sm3786449ibk.21.2010.10.03.07.57.53
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 07:57:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286082644-31595-1-git-send-email-newren@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157880>

Hi,

Elijah Newren wrote:

> This patch series fixes many of the missing &&s in the testsuite.

Except as pointed out in my replies to 1, 3, 7, 8, 15, 16,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.  I wish we could automatically detect these broken &&
chains, to make this less of an uphill battle.
