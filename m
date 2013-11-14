From: =?UTF-8?B?0JvQtdC20LDQvdC60LjQvSDQmNCy0LDQvQ==?= 
	<abyss.7@gmail.com>
Subject: 64-bit support.
Date: Thu, 14 Nov 2013 16:58:31 +0400
Message-ID: <CAJc7Lbr9Ej8JHo6m4HFwdo9GE2tBQCkypEMxMW+jEXKB1Lry=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 14 13:58:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgwVL-0005B9-IT
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 13:58:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753708Ab3KNM6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 07:58:34 -0500
Received: from mail-vb0-f41.google.com ([209.85.212.41]:46902 "EHLO
	mail-vb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753650Ab3KNM6c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 07:58:32 -0500
Received: by mail-vb0-f41.google.com with SMTP id w8so1691964vbj.0
        for <git@vger.kernel.org>; Thu, 14 Nov 2013 04:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=oMkqtsffKEiDMSMG2B5X9QCz20Y87GbbLG4dGJ94O8s=;
        b=Mbr/x/u8MtBtaM2fROPdTq/alqv3DzHCjDQd+agBaKLN8o/WhdBNDCXP96y+PlFGp4
         hDiqDWTDiPDLEqLqZzZNCAKsQ+oA1WDJYLTAEPcjCDF08U4wwnD06FQGlgr8ySQIjrPH
         i2IYLenHIGb2uzNBF0N2oLDjjOGXZxeww/QKI+1odZFVK5bsHtUylCbA6O9avvFU+rUW
         Gx9CV521+kzS6Ht3VfFTIGySfUPr21SECRFK2IwhHNc9C+8RTqTafnkhBtZT3hO9E4oE
         FP4Cy1gE8ZU1ko/PepODMmqOAcWThC6wvOer7GJGn9mPR/bH7uTQhna+PSERu01PeQur
         4q4g==
X-Received: by 10.52.26.69 with SMTP id j5mr518322vdg.21.1384433911756; Thu,
 14 Nov 2013 04:58:31 -0800 (PST)
Received: by 10.58.109.71 with HTTP; Thu, 14 Nov 2013 04:58:31 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237846>

Hi!

Do you plan to implement the 64-bit support in git? - Right now I have
a problems sometimes with a huge repo and renaming detection. If I
merge more than 32768 files at once, then the renaming detection
fails, because of limitation inside git. The limitation is put by max
32-bit value.

I tweaked sources locally, to use 64-bit value as a number of merging
files - generally, it works. But I'm not so brave to try to replace it
everywhere in git.
