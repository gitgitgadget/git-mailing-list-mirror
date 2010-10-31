From: Lee Doolan <lee.doolan@gmail.com>
Subject: A confusing usage of the term 'successor' in the git glossary
Date: Sun, 31 Oct 2010 11:06:14 -0700
Message-ID: <AANLkTimtYGKJUG94c4qFGropVOAgCOHgX5uo8XmWRNvW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 31 19:06:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCcIO-0002ED-Hk
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 19:06:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756563Ab0JaSGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Oct 2010 14:06:16 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:61355 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756555Ab0JaSGO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Oct 2010 14:06:14 -0400
Received: by vws13 with SMTP id 13so2623757vws.19
        for <git@vger.kernel.org>; Sun, 31 Oct 2010 11:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=oW4/ZckAqMd81PbEwA402LP76v1RkJtBfxe2kYoG+eo=;
        b=EzGrcrvIVuP+8TYaQ1+8t6WYr/oSWcWyVnwMGFTStD5LQ9qPTAw/6TmAxTOwijzQq6
         QAMp9AXitmPvH6lwgt42JOe5rkeXZvSDkinYbDz44yUgXysjY4TnDSwOFGQEUe5J/7n0
         V21x6N1yRD3ilDJacPb35mPGiVgy/XTfHYZgU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=Y4NyiRb5WAZj7I1NQ0UT6ahX7gBHchP8HXMWpEkjS/ZtZD6u5rIz9A60bL24bXRmgo
         nWyH8MuBNigj/QYHx5TLi6HqlnzhH6Q+q0mwyPVU3ZDDmPSvtAub622VdtVS+Pv/Z19y
         auuVUZhmqItQVbz/cstsTH4FSwRCXOuHvjN80=
Received: by 10.224.55.201 with SMTP id v9mr7573588qag.307.1288548374277; Sun,
 31 Oct 2010 11:06:14 -0700 (PDT)
Received: by 10.220.62.5 with HTTP; Sun, 31 Oct 2010 11:06:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160445>

In the gitglossary
(http://www.kernel.org/pub/software/scm/git/docs/gitglossary.html) I
see this:
,----
| chain
|
| A list of objects, where each object in the list contains a reference
| to its successor (for example, the successor of a commit could be one
| of its parents).
`----


don't you mean predecessor instead of successor?
