From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Checkout tag?
Date: Sun, 22 Jan 2012 17:18:14 +0700
Message-ID: <CACsJy8AUaJ_tkLSHYPZEPLuiNitRMS77b7n9JFeV6HABHj9Qiw@mail.gmail.com>
References: <1327226753653-7213023.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Abscissa <bus_nabble_git@semitwist.com>
X-From: git-owner@vger.kernel.org Sun Jan 22 11:19:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RouVs-0005z7-Qw
	for gcvg-git-2@lo.gmane.org; Sun, 22 Jan 2012 11:19:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165Ab2AVKSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jan 2012 05:18:47 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:48601 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877Ab2AVKSq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jan 2012 05:18:46 -0500
Received: by bkas6 with SMTP id s6so1673935bka.19
        for <git@vger.kernel.org>; Sun, 22 Jan 2012 02:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=33dStLRNnI3jlYDj4udFma/juzcMyof7ioHMUm9zGSw=;
        b=tPZNTKe9X9ofVRK7IctfAfPzw64qeuNZjXTEBIaaAiPzG2FpT+t5ZZxD7ZO59XmI51
         4cY2npJltwXdymlXSLsv91gk2VdUCXOXTqjvbDGHd1fqIk0h4FaybFkZWKV7hAOglvRe
         9z6N5i4NH/aScjx2oGVhb9ZUOXKybpU9SLiRk=
Received: by 10.205.133.133 with SMTP id hy5mr1625495bkc.94.1327227525132;
 Sun, 22 Jan 2012 02:18:45 -0800 (PST)
Received: by 10.205.123.145 with HTTP; Sun, 22 Jan 2012 02:18:14 -0800 (PST)
In-Reply-To: <1327226753653-7213023.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188950>

On Sun, Jan 22, 2012 at 5:05 PM, Abscissa <bus_nabble_git@semitwist.com> wrote:
> I've managed to figure out you switch branches with the checkout command,
> like this:
>
>>git checkout branch_name
>
> Does that work for tags as well? The docs don't seem clear on that. If not,
> how do you get the working copy to be a specific tag?

Magnus already answered your checkout question. I just want to add
that you can view a tag's content even without checking out. For
example,"git archive" can create a zip/tarball of any tree-ish. "git
ls-tree" lets you view directory structure of a tree-ish, "git show
<tree-ish>:path" lets you view content of a specific file.
-- 
Duy
