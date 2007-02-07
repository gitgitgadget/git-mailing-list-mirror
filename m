From: "Don Zickus" <dzickus@gmail.com>
Subject: git log filtering
Date: Wed, 7 Feb 2007 11:41:41 -0500
Message-ID: <68948ca0702070841m76817d9el7ce2ec69835c50e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 07 17:41:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEprd-0004Gp-SS
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 17:41:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965655AbXBGQln (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 11:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965676AbXBGQlm
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 11:41:42 -0500
Received: from nz-out-0506.google.com ([64.233.162.228]:30929 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965655AbXBGQlm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 11:41:42 -0500
Received: by nz-out-0506.google.com with SMTP id s1so228914nze
        for <git@vger.kernel.org>; Wed, 07 Feb 2007 08:41:41 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=DgCYWRQhkgvRr7Dtfo9tIrPvQA8/wVn3nnbEk6rqkCRtAEBFFGnkIu2H5x8UfV7ZXdvLLcfkrAINxAvSKH71HZK2xif2+COS2ndYjpuErzAPYgKu+ZOuLPHqkcLxCAJdMW2WgkBYUqQV/IUJ5r8eF/hs4oKDGeNTGOLwMQAo8L4=
Received: by 10.65.112.5 with SMTP id p5mr14250935qbm.1170866501447;
        Wed, 07 Feb 2007 08:41:41 -0800 (PST)
Received: by 10.65.189.12 with HTTP; Wed, 7 Feb 2007 08:41:41 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38938>

I was curious to know what is the easiest way to filter info inside a
commit message.

For example say I wanted to find out what patches Joe User has
submitted to the git project.
I know I can do something like ' git log |grep -B2 "^Author: Joe User"
' and it will output the matches and the commit id.  However, if I
wanted to filter on something like "Signed-off-by: Joe User", then it
is a little harder to dig for the commit id.

Is there a better way of doing this?  Or should I accept the fact that
git wasn't designed to filter info like this very quickly?

I guess what I was looking to do was embed some metadata inside the
commit message and parse through it at a later time (ie like a
bugzilla number or something).

Any thoughts/tips/tricks would be helpful.

Cheers,
Don
