From: Leonardo Kim <dalinaum@gmail.com>
Subject: Branch names with slashes
Date: Wed, 14 Dec 2011 19:17:32 +0900
Message-ID: <CAGcUY13TOodu1BO3DCoNnVvNZ9QkWAbD-RmyqQX6P1q6tcO+yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 14 11:17:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ralu6-0006YR-94
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 11:17:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755668Ab1LNKRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 05:17:33 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:47394 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753919Ab1LNKRd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 05:17:33 -0500
Received: by ggdk6 with SMTP id k6so567508ggd.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 02:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=flTQlJTjTwjBxZFnbD3quZMk13gxT6XduTYIgp/twGc=;
        b=ffRDNf/mUHW4OzuUV9azMj7wridGoFPkETtmZ/aSV86K1o12tecbLiNcyr+44qQ08Q
         /reSuTI2WxeVMrwkCKt3b61W91ImFZW6VQIqMkEBFTY8Kek0OMYDBSamSn8ZQur0rwQE
         waJNuXdu6FyvhdohzXhJfZQMUvLJIVkr0f/yU=
Received: by 10.182.118.67 with SMTP id kk3mr5554419obb.27.1323857852561; Wed,
 14 Dec 2011 02:17:32 -0800 (PST)
Received: by 10.182.7.8 with HTTP; Wed, 14 Dec 2011 02:17:32 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187106>

Hi

Branch names can contain slashes, so we can use 'development/foo' as a
branch name. If I choose 'development' as a branch name, it doesn't
work. There is a directory named development at '.git/refs/heads'
directory. So we cannot create a file named development for
'refs/heads/development'.

An error message may occurs like below. Unfortunately, It is not of help to me.
'error: 'refs/heads/development/foo' exists; cannot create
'refs/heads/development'.

I think that dealing with a file system and an error message above is
not sufficient for a novice like me. I hope that it should be
improved.

Thanks for your response.
Leonardo YongUk KIM
