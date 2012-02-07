From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Merging only a subdirectory from one branch to the other
Date: Tue, 7 Feb 2012 09:38:22 +0000
Message-ID: <CAHVO_90MQamw7oB8ry5YBEWSnRnxDZvQ4ApVuuv4AYR6VRuXSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 10:38:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuhVO-00012G-8t
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 10:38:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756228Ab2BGJiY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 04:38:24 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:64949 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755892Ab2BGJiX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 04:38:23 -0500
Received: by qcqw6 with SMTP id w6so3928092qcq.19
        for <git@vger.kernel.org>; Tue, 07 Feb 2012 01:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=+baUV/pbwTLCPHjEdTO+l+457cXIKGs/CnuGDTpUVY8=;
        b=qIEJ34QU69mIyxyn2tX6e8z6qyFHwAh/AJdrpV4c0mCRGFKqKLmqX/LCJHwpSQyLgV
         gz/8YIO7gSzB34Ls/gzPRpzjBL8pADyKgFyAc88O7TpsDoFgibz1/wgDJOkpVkCTdGXx
         x2OK71j9MyKM+TvJQfqM/oOBgOofDFrmenCNA=
Received: by 10.229.135.149 with SMTP id n21mr8971044qct.85.1328607502988;
 Tue, 07 Feb 2012 01:38:22 -0800 (PST)
Received: by 10.229.155.212 with HTTP; Tue, 7 Feb 2012 01:38:22 -0800 (PST)
X-Google-Sender-Auth: ZassdjvWvdngQ2Uq_7Dtfqb1LLM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190158>

Hi,

I've been Googling for this one and am, mostly, more confused than
when I started so if you could humor me for a moment.

I have a branch with a particular subdirectory tree. The tree has a
lot of history. However, all the history for that subdirectory is
exclusive to it (no commits changed anything outside it). I now need
to merge that subdirectory into a completely different branch without
loosing any history. I think git-read-tree might have something to do
with it but I don't understand the help file at all. Any help
appreciated.

Cheers....
