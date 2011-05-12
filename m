From: Jordi Bunster <jordi@bunster.org>
Subject: push --mirror on post-receive hook?
Date: Thu, 12 May 2011 14:35:15 -0700
Message-ID: <BANLkTim9S2qGRB=bWxWkMj3s=kmD=YaZqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 23:35:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKdXY-0008H5-Cs
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 23:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758622Ab1ELVfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 17:35:16 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:50241 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757879Ab1ELVfP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 17:35:15 -0400
Received: by pzk9 with SMTP id 9so895795pzk.19
        for <git@vger.kernel.org>; Thu, 12 May 2011 14:35:15 -0700 (PDT)
Received: by 10.68.40.165 with SMTP id y5mr960727pbk.338.1305236115304; Thu,
 12 May 2011 14:35:15 -0700 (PDT)
Received: by 10.68.59.195 with HTTP; Thu, 12 May 2011 14:35:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173500>

Is it safe to call push --mirror $SOME_REMOTE on a post-receive hook?
Is push always safe for the source repo?
