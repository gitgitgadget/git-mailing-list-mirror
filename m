From: Alf Clement <alf.clement@gmail.com>
Subject: git hooks to run something
Date: Tue, 24 Mar 2009 11:56:05 +0100
Message-ID: <556d90580903240356q3a72fd0bwa5ebe335914bc469@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 24 11:58:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm4KH-0007px-E1
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 11:57:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758014AbZCXK4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 06:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757482AbZCXK4K
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 06:56:10 -0400
Received: from mail-gx0-f208.google.com ([209.85.217.208]:55298 "EHLO
	mail-gx0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757622AbZCXK4I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 06:56:08 -0400
Received: by gxk4 with SMTP id 4so6325621gxk.13
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 03:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=EHVqLZEmaGvUeY/flL5A32Hc89As+1punLG79pn2kFE=;
        b=v45zT/4M5Yy4uTk/MlHJRovasyx8DPN11w+GlbniBkhj6YTKYK60Ah3Xo9HXAjk1xF
         HjccybaFQEBijYRhHZDwVgBWjdTYgMXFp0yCrOQCi6H2T1QhU3kXmBKe/ZMsNhoa139O
         lFJO++1KQ7MacNXT3ZrBJpGW2KzY/wQYj08gE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=EDFvyEkqvERUO8RPcBpPqeZW3a0roBQiWr7hdQpQW0VWN87D8b37rK7TdBJZqyhP4V
         QNtWD53YBaKOiNzcguPQ6d/TtZwKtbeTV1FjZut774B+8uBOCXTkwgi8k3qqxQh6iwzO
         Ekg4jizD2VoD20+/cyTbQAUGiio3RJYPox6aw=
Received: by 10.231.19.70 with SMTP id z6mr2094389iba.29.1237892165684; Tue, 
	24 Mar 2009 03:56:05 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114448>

Hi all,

when I switch between branches, I would like like to delete some
object files and prepare some setup files.
I there a good way to do this automatically when I run "git checkout
branch", like
misusing a hook to run a make in a special directory?
All would happen in my local repository.

Thanks,
Alf
