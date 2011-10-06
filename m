From: =?UTF-8?Q?Marcin_Wi=C5=9Bnicki?= <mwisnicki@gmail.com>
Subject: List of directories containing only ignored files
Date: Thu, 6 Oct 2011 15:56:37 +0200
Message-ID: <CAC9GOO__nN9W1vvoMxq2LKnn=YoFPjTE6jKPbQ2h7im3JtujQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 06 15:56:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBoRS-0005cr-SB
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 15:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758579Ab1JFN4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 09:56:39 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:50860 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758348Ab1JFN4i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 09:56:38 -0400
Received: by qyk7 with SMTP id 7so2570029qyk.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 06:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=PDb2f6ktYqP1X0rB0+hFZ7p0CM7iC9IjUSGSyGZF49U=;
        b=eaJUWGuxb9LMmlXO9Y/OfJE0weBaoh+gr4bOjPgBkoogev/1dGtLut979LfeyRRVjK
         3Gz5wrAGnNepD9+vtJzb+baQrYQx/JR4nuDyiducOFIcsOxRbUWl8HSSEeXYX+0Iu4pC
         vxsdPyEtJmGMS54BILP92eQWwlq2XqjZN4T7w=
Received: by 10.229.88.143 with SMTP id a15mr560845qcm.191.1317909397337; Thu,
 06 Oct 2011 06:56:37 -0700 (PDT)
Received: by 10.229.170.2 with HTTP; Thu, 6 Oct 2011 06:56:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182952>

What's the easiest way to find all directories that contain only
ignored files but are not ignored themselves.

For example, given following .gitignore:

  obj/

and following files:

  /project1/foo.c
  /project1/obj/foo.o
  /project2/obj/bar.o

Where /project2 contains leftovers from different branch that are not
cleared on switch because they are ignored.

I would like to see:

  /project2


Alternatively: how to remove such leftovers when switching branches ?
