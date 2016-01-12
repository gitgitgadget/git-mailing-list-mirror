From: Daniil S <ds98s3a@gmail.com>
Subject: Git doesn't save capitalization change in file names.
Date: Mon, 11 Jan 2016 18:06:17 -0800
Message-ID: <CAMkNX-K=GQ6LkZv2PS5Pfs+v2bN1ozi9P5ZN4Z60Ba-3JtuRkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 03:06:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIoLn-0005je-CQ
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 03:06:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761289AbcALCGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 21:06:19 -0500
Received: from mail-yk0-f174.google.com ([209.85.160.174]:33219 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761238AbcALCGS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 21:06:18 -0500
Received: by mail-yk0-f174.google.com with SMTP id k129so430596624yke.0
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 18:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=gD9xcSM2T5DTV3kz8HxJuNiUosVFlco/WOw42Kvsz2E=;
        b=fh2Z8055G3h+pyAaBN+uy9Ms8fmzIJIBBU/RGQh/RwGjpzvzEHqZaAvaodcT6uDlCi
         B9biVcOZJsGpUuhbuH0DXqoUtZwmiVETnwCBKpgq/Ntc/J1/K3ViGccjB/yGQzoFPQuU
         wjMPqgF0GnKHlKXw4eYhYwVXcUD39MUTxLFZDByDmfB04Tw9ahnHzNGL6OCzaKFlWm9I
         uYgZsZcfW4gS5czlLYGRE88cxcM6aeA8gCoBd8HucS71msIqW2P+0stL3dI6kdz/EwoX
         gWC6n8/1BMOm2HEorlkmDIxF3IzVPH8M2nPmMdr+xh7cz7Y42vp8dBkAinhg8B1nG+KW
         jhdw==
X-Received: by 10.129.155.198 with SMTP id s189mr91396737ywg.316.1452564377718;
 Mon, 11 Jan 2016 18:06:17 -0800 (PST)
Received: by 10.129.146.80 with HTTP; Mon, 11 Jan 2016 18:06:17 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283760>

So I've now encountered this with both GitHub and BitBucket, Windows and
Linux versions, so I'm fairly sure it's git's fault.

Example: if file named "Pathfinding.java" was renamed to "PathFinding.java"
and that change is then committed, filename won't change in repository.
