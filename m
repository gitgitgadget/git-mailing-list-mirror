From: Jarkko Hietaniemi <jhi@iki.fi>
Subject: wishlist: make it possible to amend commit messages after push to
 remote
Date: Thu, 06 Aug 2015 20:23:02 -0400
Message-ID: <55C3FA66.90805@iki.fi>
Reply-To: jhi@iki.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 07 02:23:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNVRJ-0006JS-06
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 02:23:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752894AbbHGAXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 20:23:08 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:33131 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524AbbHGAXH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 20:23:07 -0400
Received: by qged69 with SMTP id d69so65135721qge.0
        for <git@vger.kernel.org>; Thu, 06 Aug 2015 17:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:reply-to:user-agent:mime-version:to
         :subject:content-type:content-transfer-encoding;
        bh=T/4cRZysvhh5ocfG2fdPp6/G0RgWi98GmplK4KZriLY=;
        b=MZuH53U5X3asls+dp1S4z6BPnWL/TZGif6hg7XN1NQo3M+PBRYAyio4AuM83qJjnzj
         nB+swFB7U1pCIlDFTcTox2uR/FBs2cOOJbcZCEKGXowH3uFcLAR+INxVEvx6E3Ox3wnL
         rg7xjIo1F7d+x0tmbPJfwbK0ml76rXZrTEfQkaOhfWYwD3CPtNvuH6sXJBpDv3lx3kBB
         ZPo0LMZLhqOvJdXkTNDaWbkRrCfB4srpQ3Cy2MF680Yp/OGBoiD3rtTD4O0J9KDZ5Xpm
         yYQxBQlyu0j6RxKgg4f6wN3NAV9dKDkQwNzbA+XJXT1A0tZMBL1RsD7LAi6RRoiEVz41
         ND1Q==
X-Received: by 10.141.28.11 with SMTP id f11mr8542266qhe.78.1438906985859;
        Thu, 06 Aug 2015 17:23:05 -0700 (PDT)
Received: from Vredefort.local ([2601:18f:200:9bed:e851:f763:2053:775])
        by smtp.gmail.com with ESMTPSA id 78sm4063261qhh.42.2015.08.06.17.23.05
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Aug 2015 17:23:05 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275454>

Not for the first time, and probably not for the last, I pushed a commit
upstream without adding a link for the bug report as I was meaning to.

Or it could have been...

- Simple typos.

- Broken URLs.

- The impossibility of two consecutive commits referring to each other
because the older one cannot know what the newer one will be called.

- The following morning / 5 minutes / 5 second later thinking of
an additional factoid that would've been great to have in the
commit message.

In general, I find the fact that once a commit has left the building,
it goes into your permanent record, and cannot be changed, ever, to be
very, very annoying. I get the cryptographic "sealing" with all the
preceding changes, but...

Not that I've thought this through... but couldn't there be a bunch of
"aliases" (new SHAs) for a commit?  The original one being the
"master", but as/if the commit message is changed, it could get new
SHAs.  Sort of separating the real data of the commit, and the metadata?
