From: Marco Costalba <mcostalba@gmail.com>
Subject: RFH: Unable to get one big pack
Date: Thu, 18 Jun 2009 16:55:55 +0200
Message-ID: <e5bfff550906180755i774576c1o1c540224cea675ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 18 16:56:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHJ25-0007BG-Cx
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 16:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756158AbZFROzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 10:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754965AbZFROzy
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 10:55:54 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:55270 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753441AbZFROzy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 10:55:54 -0400
Received: by bwz9 with SMTP id 9so1135107bwz.37
        for <git@vger.kernel.org>; Thu, 18 Jun 2009 07:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=AfbOxQlGbXXxEQ5WUIhgK/x69qqh47E5ujuNp//BjOQ=;
        b=Lt5LrvUDV36ez0fepMN6Q670KoQg6eFJAgdC5+AUDYAtKGBJHw9TvfAxVeXFycMcFr
         +pZ6vfte/FUj7noBcnnzclmVbX2CAhFPtbSqI/QILUXE0DweczZIejcm4XS8iorWnjE5
         CXLSi4/hfvTmm1c6DZ0dSd8UMWhkzJLojkjtk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=Rykv+/tLTTd83/a4MuQTqMKiyGFrjjZDE/m2B/jantXHtrp2PtYW2W3FlwBrdmYpz8
         vQ6odNGoruLECFkUu6oPN5EoU0oRw8flWjTy7Jxgog36TPPsxdyERZ6cdNpRlB5E3Q58
         FMYFHC81PhtluNeHGyMm/fzQOhYUedpdfWpLI=
Received: by 10.216.3.206 with SMTP id 56mr458476weh.99.1245336955641; Thu, 18 
	Jun 2009 07:55:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121849>

Sorry for the silly question, but I have tried anything to get one big
pack instead of many objects.

I tried git repack but with no success:

$ git repack -adf
Counting objects: 3317, done.
Compressing objects: 100% (3317/3317), done.
Writing objects: 100% (3317/3317), done.
Total 3317 (delta 2607), reused 0 (delta 0)
$ ls -R .git/objects | wc -l
  519
$

Thanks in advance for your kind help
Marco

BTW I have trid also git prune in any way but without succes either.
