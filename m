From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Feature idea: Ignore content
Date: Tue, 19 Jan 2010 18:59:27 +0530
Message-ID: <f3271551001190529h389ce321k52dcca6b03e4e8f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 19 14:29:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXE9a-00024q-40
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 14:29:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447Ab0ASN3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 08:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943Ab0ASN3t
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 08:29:49 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:38440 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240Ab0ASN3s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 08:29:48 -0500
Received: by yxe26 with SMTP id 26so3243119yxe.4
        for <git@vger.kernel.org>; Tue, 19 Jan 2010 05:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=siyWIFBdjUtdkfKETEn+GLGppituXXKsR+tXIrlUL+o=;
        b=MfdwNfNDrfBCiYUSkuBz/jGh5MlV4vaoDChDteCUEAaKbkHanQQ5sb3cDd0zQEClnJ
         uyxzL9EKAXxC7uYkuLEQqL1LW6xZo6CLHJCmozV1hNGn53ko1wGxCERV9M7shzQBW01l
         zEcWxOXYt0IaDsCfNcFjWRrKsqkF4uE2lXQ9g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=Hg8SYkx3ux0Gq3o1vveDBsLNmq9jdEU3myFdhvGibyFoVVL6kyim0adlRZOCa0Atj2
         XdykBN8Ec6gjoOr6ftX3AMAeJ+ykCjdYVWWKAohcY8RbifTSzgrdjX5/vf8j6sGMQpN3
         OiXhpvHxy5VWlr9xvwQqQGq6XKMlqZPx22vyY=
Received: by 10.90.208.20 with SMTP id f20mr6854762agg.49.1263907787225; Tue, 
	19 Jan 2010 05:29:47 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137457>

Hi,

Often, I find that I need to track a file which contains a small
portion I don't want to track (read: line with a password). Instead of
moving that out to a separate file and ignoring that file, is it a
good idea to add a feature to Git to allow ignoring content instead of
whole files? Since Git by nature tracks content, this shouldn't be too
hard to implement, right?
