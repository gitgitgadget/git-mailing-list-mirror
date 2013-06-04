From: Matt McClure <matthewlmcclure@gmail.com>
Subject: Can `git blame` show the date that each line was merged?
Date: Tue, 4 Jun 2013 09:39:45 -0400
Message-ID: <CAJELnLEiK1C9PeimSwDoJoy=wFbFF0+KoK3jhXSAV4b2DsBKqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 04 15:39:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjrSo-0004y0-7T
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 15:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022Ab3FDNjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 09:39:47 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:52727 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753799Ab3FDNjp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 09:39:45 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp2so258245pbb.0
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 06:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Gbg8JlhhrUOBakJWfkXEsQHJDxs8SqmBwf7Em/1yTio=;
        b=WapOd1nQ89zOdfhNgykvX9cM1zkD+EfgCVpRv8hsRhzt2zE/EJI5FFl1SVy/rF4Rl1
         JoE4IHy7ZYd9QcfoYh7BJuE8JAwjEGBMM01zeKbB9gs6TTtLXte5svOJW4ENxANNAmOu
         MQvecDCdGpdILlq80kXrovH65Ikz4SFTQABYFZaAhSOA9YTYz6cM78TzHJfz3Wk1jAcn
         SJq1HPrgsN8x9saY8f0UF1+bP7zJNT3qjaMmWHHbYAnq2PD1ph9eAq8eK2Vdain/womu
         oKWxWIU1ivoHq9YlzjNufrSjpVKIJDEHhMcgylAyFurqPI9+3h+jB4TysS5qhiIuTTXf
         QVDQ==
X-Received: by 10.68.130.199 with SMTP id og7mr28899994pbb.132.1370353185359;
 Tue, 04 Jun 2013 06:39:45 -0700 (PDT)
Received: by 10.68.254.232 with HTTP; Tue, 4 Jun 2013 06:39:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226366>

Can `git blame` show the date that each line was merged to the current
branch rather than the date it was committed?

Aside: in some trial and error I notice this oddity:

    $ git blame --merges
    usage: git blame [options] [rev-opts] [rev] [--] file

        [rev-opts] are documented in git-rev-list(1)
    ...

    $ git help rev-list | grep -F -e --merges
                        [ --merges ]
           --merges
               --min-parents=2 is the same as --merges.
--max-parents=0 gives all


-- 
Matt McClure
http://matthewlmcclure.com
http://www.mapmyfitness.com/profile/matthewlmcclure
