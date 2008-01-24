From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: stgit: managing signed-off-by lines
Date: Thu, 24 Jan 2008 15:27:17 -0500
Message-ID: <9e4733910801241227n659a5b34x7f77f25101aa225f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 24 21:27:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI8fz-0006yx-5r
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 21:27:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117AbYAXU1W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 15:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753773AbYAXU1W
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 15:27:22 -0500
Received: from nz-out-0506.google.com ([64.233.162.229]:6820 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753600AbYAXU1V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 15:27:21 -0500
Received: by nz-out-0506.google.com with SMTP id s18so289721nze.1
        for <git@vger.kernel.org>; Thu, 24 Jan 2008 12:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=rdxnNlqZyVQd+t9L858SgjZVz93ZAklXkTIrggjjdCE=;
        b=NEuDgOvegTwQ2owDYvgG2g0AuMhTQl8bamesP8SHo/bTFHJF0EK0lEKd+8tSNuIccnHl8Si5Lk8bfNLA5XaTU3wBqV5zVNNfFe8aGP4TnamKdpMIxNs4VZAcdw3GHJr5zXtpeda/8oeNPu0igqGHK8z0MDGAHmnxQ5CCZTTXq7k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=J3eSPB5ZQdDTz16mTNxTNtoSOfe+EALTDpa5IISD698LzJrwSiuDe4gGQ8e+E1yTsLWZq/jB9WJoAIw9qCI+UUp5QtYa+bM9QYUmCCS3j2I9NO5Y7cBzKX6/IG3D76v1Z4WuA8pd3Y22iNDmLF28AKG8cujHzAHM7nKwD8LgDEk=
Received: by 10.114.149.2 with SMTP id w2mr1309396wad.5.1201206437630;
        Thu, 24 Jan 2008 12:27:17 -0800 (PST)
Received: by 10.114.93.14 with HTTP; Thu, 24 Jan 2008 12:27:17 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71658>

If I import a series of patches from one of my trees into another,
stgit preserves the signed-off-by lines like you would expect it to.
When I export these patches it adds a signed-off-by line for myself
again like you would expect it to. But adding this line on export
needs to checks and make sure that my name isn't already in the
signed-off-by list, without this check I have to manually remove my
name when it gets duplicated.

-- 
Jon Smirl
jonsmirl@gmail.com
