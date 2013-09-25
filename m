From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: "git checkout foo" is getting confused by folder named "foo"
Date: Wed, 25 Sep 2013 10:33:27 +0700
Message-ID: <CACsJy8DO8ck-ZWuzFbYJyK=mpAkyC+7_vaOfOixd3ahWje7CEA@mail.gmail.com>
References: <CAEQewpqLcDJPo2gUWPk-xc3OitdTC4gH2tnyqaURiQ77BApNog@mail.gmail.com>
 <CAJDDKr64ou+gO7WJLFZ4zOSv+VCbkiW7nKuZa9=5_fiSqGUeyQ@mail.gmail.com> <87y56lsie0.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Keshav Kini <keshav.kini@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 25 05:34:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOfrW-0003aI-Ee
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 05:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754661Ab3IYDd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 23:33:58 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:41652 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754306Ab3IYDd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 23:33:58 -0400
Received: by mail-ob0-f174.google.com with SMTP id uz6so6085697obc.33
        for <git@vger.kernel.org>; Tue, 24 Sep 2013 20:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ZnRjeTLVz/LKZypOqHQQFjyzjU0KbmliQD39e46OUMA=;
        b=vLG91ydBfUMgSHfADnCplF0clZNn/hJgmSrxRsyL2hX7p0EXGheLRUODmHYIRESX/G
         ZtRVPCj5PAtB2nH5Atnyy/9eXST/jZIeH/JBe1J3mJWW4PK4wCuuhOW3olk7XkOUhOeo
         nW/NP41gFjxE46io/bTMkW1HSoHvDDc1n8J7TQ+75/sgJKs3G/S2kWc65Wv1pFS8+mgA
         AAlyyudkFiqlw4DrIPRZFPLSvxMOFwivAF+JNOYvV+Nz7JAwFwWPC/b2VWMfwN8dUcYf
         baGvEhySXJK7xznBqjkcs0ckCYmPu86jcs2omuaefM6wp5/Fz/0UnpWUAZTSNg3kimlr
         7oiA==
X-Received: by 10.60.134.14 with SMTP id pg14mr73799oeb.66.1380080037394; Tue,
 24 Sep 2013 20:33:57 -0700 (PDT)
Received: by 10.182.49.233 with HTTP; Tue, 24 Sep 2013 20:33:27 -0700 (PDT)
In-Reply-To: <87y56lsie0.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235331>

On Wed, Sep 25, 2013 at 10:13 AM, Keshav Kini <keshav.kini@gmail.com> wrote:
>     [2] fs@erdos /tmp/extraction-framework $ git checkout wiktionary --
>     fatal: invalid reference: wiktionary

It may work if we demote this from fatal to error warning so the dwim
logic in checkout has a chance to try differently, I think.
-- 
Duy
