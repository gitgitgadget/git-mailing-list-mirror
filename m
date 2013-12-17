From: Gunnar Strand <gurra.strand@gmail.com>
Subject: Document SubmittingPatches: inconsistency regarding to: and cc: for
 approved patches
Date: Tue, 17 Dec 2013 10:59:14 +0100
Message-ID: <CAEsF1LtJBA8gT9nEJv0_4CKRLGL7eWD19ghUGzQ9uWUCmj8X7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 17 10:59:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VsrQt-0004sx-LC
	for gcvg-git-2@plane.gmane.org; Tue, 17 Dec 2013 10:59:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752556Ab3LQJ7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Dec 2013 04:59:15 -0500
Received: from mail-oa0-f43.google.com ([209.85.219.43]:53219 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790Ab3LQJ7O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Dec 2013 04:59:14 -0500
Received: by mail-oa0-f43.google.com with SMTP id i7so6345455oag.2
        for <git@vger.kernel.org>; Tue, 17 Dec 2013 01:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=2rI7KXUa4hPXGBJqfS660esAOQ323Wqx3I/VNA46mys=;
        b=ORrw/9uyN8sa/GQ8fV6m/PS0Vg51H9BKH6cdRaQgfc+jhLxf+4u2cDJA+4ZX+CIPzy
         t2NdgGNo+e9cQSKmzP9meEs6N3mWDY2symm+w/nyVRrKvEmzf94S5h029FTSIkT8dnzz
         b4GhKMKlrQXYcN1gMz5xPCaxefxCXzf5Ll6EmXlDQTIsDjOjqLi/+mZ/lc0hCxZD8te9
         mxhKlrOeNB+Izc/N6oDrlsk1YeoURIWXhLU2y87zsJe+IW865O6kSZ4dO7rwcGtG71ke
         QESIJd78GLEdftFz4ahcNd9AfM56jFrH61Pn7+W3IvQX3i6U5/79pMkD1lDLSMqR514Q
         wyKQ==
X-Received: by 10.182.220.225 with SMTP id pz1mr15117796obc.51.1387274354184;
 Tue, 17 Dec 2013 01:59:14 -0800 (PST)
Received: by 10.76.94.238 with HTTP; Tue, 17 Dec 2013 01:59:14 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239377>

Hi,

The patch submission document has an inconsistency regarding who should be
"To" and "Cc" for approved patches:

To maintainer, cc list:

212 After the list reached a consensus that it is a good idea to apply the
213 patch, re-send it with "To:" set to the maintainer [*1*] and "cc:" the
214 list [*2*] for inclusion.


To list, cc maintainer:

339  (4) The list forms consensus that the last round of your patch is
340      good.  Send it to the list and cc the maintainer.


Ref 1:
https://github.com/git/git/blob/master/Documentation/SubmittingPatches#L212
Ref 2:
https://github.com/git/git/blob/master/Documentation/SubmittingPatches#L339


BR
Gunnar
