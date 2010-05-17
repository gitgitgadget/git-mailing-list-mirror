From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [GSoC update] git-remote-svn: Week 3
Date: Mon, 17 May 2010 15:28:01 +0200
Message-ID: <AANLkTimBxpZYDaE8S-KFivn1F9I983-Ab0q9JUGP53nK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 17 15:28:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OE0Mu-0005jO-4q
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 15:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755333Ab0EQN2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 09:28:23 -0400
Received: from mail-qy0-f171.google.com ([209.85.221.171]:49749 "EHLO
	mail-qy0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698Ab0EQN2W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 May 2010 09:28:22 -0400
Received: by qyk1 with SMTP id 1so7005713qyk.5
        for <git@vger.kernel.org>; Mon, 17 May 2010 06:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:cc:content-type;
        bh=6GHn0T1WiF45QIcHJWkbDQq6fHi2qFYpYMcHAbc9Bw8=;
        b=Ep9Zp2wiPlLhHfxGg9u1pS5Ys4bp6EyOZ/VAikOM2fYSgktz5Wb6mJ00RL/NtZiy3N
         nMaLSln0frMBU98+9E70ePQTNgYQDBqO988qo5qVYUsOHGX82zEE1rZYILpEeppWQTdI
         RZ4fyF/1Nwo55of/g0bjIhQDn60ef3m9cf52M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=IQqU2fZRJB3wfhHWUmEYV4576E3PO/Y6dwJDfNL6D9LbL24lCFIq76Gqlrf6Jb75yD
         zDJoM73b56zhs8dtboc2l4GN5ID6hEkhsP9DoG37vvv3UlWOUpaL72BwRL9e3ILwI+L4
         B7QB7ejHFV48AF7AsduTZnBh+utBCuoAP0PMM=
Received: by 10.229.238.135 with SMTP id ks7mr1110050qcb.31.1274102901162; 
	Mon, 17 May 2010 06:28:21 -0700 (PDT)
Received: by 10.229.182.85 with HTTP; Mon, 17 May 2010 06:28:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147233>

Hi,

In the earlier part of the week, David and I collaborated over IRC and
managed to plug some leaks in the exporter using the data from
Valgrind. We also fixed some bugs and documented some of the
limitations of the exporter. In the later half of the week, I was on
vacation in Berlin and I returned today. I'm not entirely happy with
the exporter yet, but I'll defer working on it for now- this week,
I'll attempt to plug the exporter into the remote helper I built in
week 2.

-- Ram
