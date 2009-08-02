From: skillzero@gmail.com
Subject: Subtree merging of sub-directories between repositories?
Date: Sat, 1 Aug 2009 23:37:01 -0700
Message-ID: <2729632a0908012337l6d84ba76o81239d324ba11cf2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 02 08:37:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXUh0-0002Aw-U3
	for gcvg-git-2@gmane.org; Sun, 02 Aug 2009 08:37:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940AbZHBGhD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Aug 2009 02:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751871AbZHBGhD
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Aug 2009 02:37:03 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:53392 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbZHBGhC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Aug 2009 02:37:02 -0400
Received: by qyk34 with SMTP id 34so2341738qyk.33
        for <git@vger.kernel.org>; Sat, 01 Aug 2009 23:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=h29Bw0KCA8/5ZObeuZarDiUBkicCWjO/3W8Uly86bWk=;
        b=KvNHN43ER/9/PNJ2zjEC1LwON9lRCvXFeMgbGfnqaywUEscKSHKkpG9jZqdqkrR58t
         ypVfm8qLaW1+XOVdQWVPjCcja7Hgp268TkcB5ps5u/qAz/iepqqyFnUkms6LTQGhk3MP
         7YhnHo+2WQqLxFdqxmBysrUzGc/Kbu/pw75aE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=kqHiYBkIw2xbSqXhzr1VuFJQIIPFIVUJEg17ZP1okZtYgl+SbMvDZQprdyubPGEQJJ
         iQgMp6K6axheWzlQNI/5O/NyfK5kJhUkQFLtREkWHqWWFFRL3v2wHTF38fTwqRj4meyj
         t4wlckGg1NULtCVYvPvkjMqNc9qeoILKauTzA=
Received: by 10.224.54.139 with SMTP id q11mr3622958qag.97.1249195022000; Sat, 
	01 Aug 2009 23:37:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124667>

Is it possible to use the subtree merge strategy to import just one
directory from a repository into a directory of a different
repository? The subtree merge example describes bringing in an entire
repository as a directory, but I'm not sure how to adapt that to just
import part of the source repository. The repositories are completely
different, but repository A has a couple directories I want to import
into repository B (along with the history that affected those
directories). I may also make changes on either side and it would be
nice to be able to re-merge in either direction.

I was thinking I might need something like the git-subtree script, but
maybe this can be done with standard git commands?
