From: Ori Avtalion <ori@avtalion.name>
Subject: Warning about conflict markers - undocumented 'diff --check' feature
 & suggestion
Date: Tue, 29 Mar 2016 01:44:06 +0300
Message-ID: <CALgdb5JuoYpHAPxTY2cHdbkcPUjKtsWQ_DY5rBrw-YKCwj2yvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 00:44:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akftO-0005qc-GK
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 00:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755405AbcC1WoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 18:44:09 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:33821 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755396AbcC1WoI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 18:44:08 -0400
Received: by mail-wm0-f42.google.com with SMTP id p65so115794349wmp.1
        for <git@vger.kernel.org>; Mon, 28 Mar 2016 15:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to;
        bh=xqWYTq/CwrWDIdVhJD37Qwj4cPrhJWxqOmBoX1A7zQA=;
        b=nRYhvfjTjr+R5bc86xA+489YEEI3aURmyNnc1/mYIqG5AqLgzBgBqigzRUaYpRPVVH
         OCZbIZon1PclKch/RHQz0ItdhLsKVpx7vL629rGkss/J4oUa+RkZAS6b3Oy6Y3rlkIN9
         d5j2lRjj1nxHK5vGhydi7AoqkfhAMbh5cf8O0BzH6t+IruHTcwjQ0NnlzPeQw5BusHao
         H9u80jitySZEpKSZLBxhRGD1o6iwMg2Uy3p7ojJej+tDSwjjIHv1aTcPYy6l/3uLNUXq
         YMUHIt+S5gIAob6MzIUrlHmhsSK0pqxpmoM8OWYdK8GaueHYuopXRI6sK/nneF0Enk1B
         6bzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:date:message-id:subject:from
         :to;
        bh=xqWYTq/CwrWDIdVhJD37Qwj4cPrhJWxqOmBoX1A7zQA=;
        b=GpiejfYH7xPfVAfk/SMGQpqaYXtEmtjpjJ82DCVINU4cIzZpVCJUFx5uh4SLS1FRXE
         xNcXEDMDs22X2GF1qxEO+phZ33NzVIMGkz0Try/IMcHx995T3Si5P7fvnIIk/lGQjxdJ
         awXfgHMZ98dY4tXVNyZsnM/JVbEctCmWRS208xEwPPynm4eJ+Hj5BzlM52HlUt/6Aree
         AKV+SRgR5XK7i+vhC9qM0jf019ORuwL72AITlBmS7gQJmt89RFzZLpOf8F0s6c3UGMay
         aWN5K+R/KsbmuSVAjdVDJMufys+d2DFbbWcoZp4K/yqdsEhsab9pcdAqKodIEsDHKJQ3
         jNrg==
X-Gm-Message-State: AD7BkJJ32CGWp8A2QTXD3k3zAzibHWZx0KMcyRiT5N8I587E1/8ILlmdIdKDpBuDiayF3geLnfKZj6cPdarPOA==
X-Received: by 10.194.92.107 with SMTP id cl11mr34404023wjb.21.1459205046692;
 Mon, 28 Mar 2016 15:44:06 -0700 (PDT)
Received: by 10.194.69.132 with HTTP; Mon, 28 Mar 2016 15:44:06 -0700 (PDT)
X-Google-Sender-Auth: FIsRa_-e9eJJuihxHVVRJZOcirg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290082>

A bug report and a suggestion:

`git diff --check` has been warning about conflict markers since 2008:
https://marc.info/?l=git&m=122398500726634&w=2

This is an undocumented feature. The current documentation for the
flag only mentions "whitespace errors".

This check will also be useful in `git add`, to prevent accidental
staging of conflict markers.
Perhaps it could be included, if not by default, then at least with a
configuration setting.

Thoughts? Is this perhaps an existing feature that I'm missing? :)

-Ori
