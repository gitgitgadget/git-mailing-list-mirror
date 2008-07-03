From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: finding deleted file names
Date: Thu, 3 Jul 2008 09:31:55 +0930
Message-ID: <93c3eada0807021701m13b7adddv51537f4cf9d52533@mail.gmail.com>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 03 02:03:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KECHv-0006xG-Pk
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 02:03:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbYGCAB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 20:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751562AbYGCAB5
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 20:01:57 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:12430 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbYGCAB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 20:01:57 -0400
Received: by fk-out-0910.google.com with SMTP id 18so477926fkq.5
        for <git@vger.kernel.org>; Wed, 02 Jul 2008 17:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=HzFv4zVRJtsWZqgXLKMjoIASw+usXgh4d8+djyrz/CQ=;
        b=HeQibOTiSESwLDh9kQIrugpCCjU4KfXwjOdZtu/7biDqT7GSeyCLZzi52unWA2NcOn
         qih5bgQw7lYs8opPs3BC2KF4RU93yl0K5Vho6OBQBR36IUjJSntGhFGtUUZQe6RwVBAi
         o/yf2I4kw5opMCt0nUCCu/9n00crqvhuNX7W4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=EVza2u2V9qzfVxxLseSjkTUJSgoVrjzbpSEleonfbfiik55fzQ/RyL+Hu/JuN/feck
         VQbt+u5awDMa/i+YSdn1o87ThTmcTqq4x1r1KHJ61d+vMqTMo5TsP+P94TkpcJxlnhct
         NYkrViSQR73XvkUWIdX5y+8E5mKT5g38VU9gM=
Received: by 10.82.173.1 with SMTP id v1mr321660bue.68.1215043315300;
        Wed, 02 Jul 2008 17:01:55 -0700 (PDT)
Received: by 10.82.114.1 with HTTP; Wed, 2 Jul 2008 17:01:55 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87206>

git diff --diff-filter=D --name-only HEAD@{'7 days ago'}

finds files deleted during the last 7 days, but if my repository is
only 6 days old I get a
fatal error.

fatal: bad object HEAD@{7 days ago}

Is there something that says "since repository creation", ie., go back as far
as possible, but no further? Is there a symbolic name for the initial commit?

Cheers,
Geoff Russell
