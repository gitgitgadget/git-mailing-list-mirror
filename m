From: Jeremy Scott <jeremy@great-scotts.org>
Subject: files deleted with no record?
Date: Tue, 24 Jun 2014 11:15:09 +1000
Message-ID: <CAFDwLfyXrUZUUuaciAjamn-cXJ6mAv_D41zLwT4AZE=cmAX7rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 03:15:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzFKi-0003UE-14
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 03:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751AbaFXBPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 21:15:10 -0400
Received: from mail-qa0-f45.google.com ([209.85.216.45]:60558 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752374AbaFXBPK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 21:15:10 -0400
Received: by mail-qa0-f45.google.com with SMTP id v10so6252513qac.4
        for <git@vger.kernel.org>; Mon, 23 Jun 2014 18:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=+LLx0O9yZMIDso6n6KJeRRMLHYf6iIMQFYqmWm0CZ1Y=;
        b=oTj2/yy2WTM234oRIbVl5ojrMyDKxK4EMlPozUC/EPko5tVs4nRUAc52WbbG/SS6cm
         NpoEaEx70GONCC6ljNwT18lStRmor58B6zSm8XUxgeILL00NPY5CmGXYKn1qIFWhcbg8
         oWG/xIVxhnR2AxclOTroQLDGanR83EpHB/PomCFh/ikdGmm3/nksZi1tdjFMyNINLSbV
         5W8Il6BSxrFA/32QOZI0U4Ku/QUYYqk466UhTcAEZOTUhJt7y1DuVYx2uLwsgDPd6Dd/
         kvJbIoaCDDNHHo4iy6rJZXltbH2Dnf4Z5YlTxeL1MY9WojkRBo45+i0pu5GKdHl3df5f
         brNQ==
X-Received: by 10.224.26.68 with SMTP id d4mr14434944qac.61.1403572509298;
 Mon, 23 Jun 2014 18:15:09 -0700 (PDT)
Received: by 10.140.34.146 with HTTP; Mon, 23 Jun 2014 18:15:09 -0700 (PDT)
X-Google-Sender-Auth: MZYlo2cQavcrRfa_-zC9CCrn9IE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252382>

I just encountered a situation where a merge was made, with no
apparent changes in files (ie no log), but the result was that some
files were deleted.



person A adds some files
person B adds some files from the same point
person B commits and pushes.
person A commits -- now merge is required
a few more commits on top of person B's commit
person A merges - this removes the files that B added. There is no log
of the files being deleted

Clearly this is possible - was this a user error?



Thanks
