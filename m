From: Arun Raghavan <ford_prefect@gentoo.org>
Subject: Removal of post-upload-hook
Date: Thu, 14 Jan 2010 23:31:57 +0530
Message-ID: <6f8b45101001141001q40d8b746v8385bc6ae37a6af4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 19:02:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVU1d-0000yW-BG
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 19:02:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757384Ab0ANSCT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 13:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757372Ab0ANSCT
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 13:02:19 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:18988 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757175Ab0ANSCS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 13:02:18 -0500
Received: by qw-out-2122.google.com with SMTP id 9so486961qwb.37
        for <git@vger.kernel.org>; Thu, 14 Jan 2010 10:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:from:date
         :x-google-sender-auth:message-id:subject:to:content-type;
        bh=y53PVph3ZAshOmZdBfq9yMy5WZzCMRZ12eyxEsSBGHQ=;
        b=bwbBf0yPycnJw+OuDAstXM7iGXa1MTC9oURITbG8TDwvk3ty7yeBSuVt0BiVNnxUDi
         EQyX8Xlu/dtMgXXHsgq/N09p6OtTVhSO5nBS+V5X9SuLIGci+3c8/qQbg+yHgkG1k/Zb
         +6J/qBwXttiL+74bXnEEUzISzp9453RNZGf4M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        b=mB1J6ISb6c9pUdeeHD7RyLsk622IQ7RGwTTtxqQS6VgOHX4sSgC35k7Sb35Xrq5FFG
         8l3se4NwJa4tvm9+is5zEFRqtv+9GGZubhM7HHuUuLWLz3B07ZVXOS1W3QhiGGu5bx8U
         VtCXwdXZLdxb9JU7QDtIUpXuDh0kowB0vS/eA=
Received: by 10.229.31.206 with SMTP id z14mr918773qcc.79.1263492137226; Thu, 
	14 Jan 2010 10:02:17 -0800 (PST)
X-Google-Sender-Auth: a31aacc0fd65112c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137007>

[I'm not on the list, so please CC me on replies]

Hello,
I noticed that the post-upload hook had been removed in commit
1456b043fc0f0a395c35d6b5e55b0dad1b6e7acc. The commit message states:

    This hook runs after "git fetch" in the repository the objects are
    fetched from as the user who fetched, and has security implications.

I was wondering if someone could shed some light (or links) on what
security implications this hook has?

Thanks,
-- 
Arun Raghavan
http://arunraghavan.net/
(Ford_Prefect | Gentoo) & (arunsr | GNOME)
