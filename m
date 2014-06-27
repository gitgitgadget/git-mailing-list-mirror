From: Christian Halstrick <christian.halstrick@gmail.com>
Subject: How to populate index/worktree when recursive merge merges multiple
 common ancestors?
Date: Fri, 27 Jun 2014 07:50:44 +0200
Message-ID: <CAENte7jg7RnpEFmZ0QWGw=a-AvAN6AF=cknHXWyTEuo9zq7ERg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 27 07:51:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0P46-000138-2y
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 07:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbaF0FvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 01:51:07 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:52066 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbaF0FvG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 01:51:06 -0400
Received: by mail-qg0-f53.google.com with SMTP id i50so3926903qgf.40
        for <git@vger.kernel.org>; Thu, 26 Jun 2014 22:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=HL4bFWw3X17MNUP0BHYJvQkUCAtWkKMMHvGHacXtXKE=;
        b=U/bY7JQTsDAGwy2bvMKREQw5+Mcc39lK8+A6Fo41svbRdwWSre3NP6lO4oQ4EM5idZ
         gKYVqWbkKnWkIkt3WerWxoret3QK1SLjFb0WkQx+9OBxAUXMwspNuAyy2SZD7l8QeP3Z
         kjZLIRCGMFOt3lolFiHnTK1489Lzp4FYNbEFyrNAZmRUZ7/10yjUuGh7z/EgTEV7HeBv
         ssawo/aXAjYarsszWzeDKoow4yJGP46Q19dVjKoOuNfVtuYDoxHEYYPOphyfqS6sWjlx
         b4uhrIs2siScUyy9Palw8MfSfr7e2dDh08M8lxBOgIpxdDZBZ4oX6wMDdWmXtP3neTLk
         zHhg==
X-Received: by 10.140.47.173 with SMTP id m42mr3749368qga.9.1403848264529;
 Thu, 26 Jun 2014 22:51:04 -0700 (PDT)
Received: by 10.96.179.199 with HTTP; Thu, 26 Jun 2014 22:50:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252532>

Imagine git does a recursive merge between A and B and finds multiple
common ancestors X1,X2 for these commits.
- Does git try to create an implicit/temporary common ancestor X3 by
merging X1 and X2?
- How should workingtree, index (stage1,2,3) look like if during that
merge of common ancestors a conflict occurs? Will I see in stage2 and
stage3 really see content of X1 and X2?
- How is the end user supposed to fix this? Imaging merging X1 and X2
leads to conflicts solved by the end user leading to a implicit common
ancestor X3. Then merging A and B with X3 as common base again
conflicts occur.

Ciao
  Chris
