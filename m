From: skillzero@gmail.com
Subject: Global reflog?
Date: Sun, 14 Feb 2010 13:49:10 -0800
Message-ID: <2729632a1002141349s6c9a31b7u6784d89d132547ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 14 22:49:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgmL9-0004cH-Am
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 22:49:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365Ab0BNVtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 16:49:12 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:44847 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300Ab0BNVtL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 16:49:11 -0500
Received: by iwn39 with SMTP id 39so1629046iwn.1
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 13:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=LKPhZSNhhkfn/CsluoToXKBVXqz3f37J+FFQn+CY3O0=;
        b=VLYVflyDNl2ibQujPHMKr150QNkr2Kj0R1h+l+YPc8dHFCiU8Y7GzVdUiOYuf9suzZ
         mo4mlG3j0zhguFeTZGtzIv+ipRPGd/G5mddj6L3HWqX5Rgl7f9W4asZyowFK5NQhorVM
         0WFq0MRDDxso8Rk4u8IpdoWOXfXrnpTL3xCqY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=smvjVZ50nHIO8BsESfnQp8eyTC5YPQXDQGN4PU0TjfkuIGqxjNDuwOO8TGcRkdrNK6
         LBp9yFpDF94k6z4gQtR6e9tGC+fn7yWm3QN5Vc1XClPiwo/r2qddnnRH6qKhCgakFka2
         vOec7qRzpqsQUp4zWwl7LoNWwYinV0m2QffEU=
Received: by 10.231.190.146 with SMTP id di18mr4107668ibb.19.1266184150692; 
	Sun, 14 Feb 2010 13:49:10 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139945>

Is there a way to have git maintain a single reflog across all
branches (and stashes)? I switch between branches, create and delete
branches, stash save and pop, etc. frequently and it would be great
for me if there was a way to have a global reflog that showed every
operation, independent of a particular branch. Is there some way to
enable this?
