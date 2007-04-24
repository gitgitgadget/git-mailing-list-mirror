From: "Matthias Kestenholz" <lists@spinlock.ch>
Subject: gitattributes
Date: Tue, 24 Apr 2007 13:36:56 +0200
Message-ID: <1f6632e50704240436l4a81d8c9s1bbf95a7892db68c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 13:37:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgJKO-0004aS-Sz
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 13:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161543AbXDXLg6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 07:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161712AbXDXLg6
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 07:36:58 -0400
Received: from nz-out-0506.google.com ([64.233.162.227]:2866 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161543AbXDXLg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 07:36:57 -0400
Received: by nz-out-0506.google.com with SMTP id o1so397826nzf
        for <git@vger.kernel.org>; Tue, 24 Apr 2007 04:36:56 -0700 (PDT)
Received: by 10.114.130.1 with SMTP id c1mr3003485wad.1177414616207;
        Tue, 24 Apr 2007 04:36:56 -0700 (PDT)
Received: by 10.114.154.15 with HTTP; Tue, 24 Apr 2007 04:36:56 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 6831cbdd7ed537b1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45443>

The .gitattributes system together with input/output filters has already
proven exceptionally useful for me. I've got some co-workers which
do not seem to care about CRLF line endings or whitespace damage.

core.autocrlf = input

and

[filter "whitespace"]
  clean = stripspace
  smudge = cat

and

*.php  filter=whitespace
*.tpl  filter=whitespace

saves me minutes every day when I review changes made by others,
because otherwise the diffs are getting illegible (Sometimes, the whole
file is shown twice only because the line-ending changed)

It would be really great if these features were included in the next
release.


Thanks,
Matthias
