From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Continued work on sr/vcs-helper and sr/gfi-options
Date: Sun, 6 Dec 2009 01:53:03 +0100
Message-ID: <fabb9a1e0912051653s77ba25e1g9ff1e21219cd06c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 06 01:53:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NH5NV-0006gW-3A
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 01:53:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754228AbZLFAxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 19:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753574AbZLFAxR
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 19:53:17 -0500
Received: from mail-vw0-f197.google.com ([209.85.212.197]:51500 "EHLO
	mail-vw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753549AbZLFAxR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2009 19:53:17 -0500
Received: by vws35 with SMTP id 35so1585344vws.4
        for <git@vger.kernel.org>; Sat, 05 Dec 2009 16:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=kCpXdeFuShQrzscg4ClbDiLFH5K7o0g5hPwh+YEwoIo=;
        b=HO5V2LlB76L5ekqX5ma7LHj1PwfXX8mkYNKYSZHQsCdfdhoz0V0pgbEQZ+wzudC3Qm
         oPlNlxf7HFWZq7k3dsmrB5Ro85ymUAKBJvSC/rvO8D6p9VwpuL98jbkjHT6DOdVh0AfF
         mZhFBRX4CTvBDFSbhpsP5aKuUwtvpQMf3tklQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=jXGnxNepMpSQ6MUHyB04xFWRfuBfnhnGzaeoNMELbpX3xXRD5j5swtBbLm4Jw8fS+1
         tCsb/MwAGpmyaTIKN3RJ2yC+zNKs9+8qa4ogO2s/1PfLpj32sbJrS6Gj1/Oa9oqEBoiU
         u/+LRZiNuWbon3yyLNC4MjydqaJdgjs0PRewY=
Received: by 10.220.123.2 with SMTP id n2mr6328593vcr.71.1260060803049; Sat, 
	05 Dec 2009 16:53:23 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134639>

Heya,

I'm planning to start finishing up git-remote-hg this week, and for
that I need both sr/vcs-helper (in next) and sr/gfi-options (in pu).
How can I best go about working on these? I _think_ what I want is to
merge sr/vcs-helper and sr/gfi-options, into either master or next
(with a three-way merge), but I'm not sure? Also, when I try to rebase
sr/vcs-helper onto master I get conflicts yet again, since these were
already resolved in next, what is the best way for me to proceed in
such a way that it is convenient for you (Junio) and the list, if
possible, without having to untangle those merge conflicts.

Thanks!

-- 
Cheers,

Sverre Rabbelier
