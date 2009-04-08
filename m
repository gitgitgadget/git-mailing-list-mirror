From: Ping Yin <pkufranky@gmail.com>
Subject: Any way to edit the file in index directly?
Date: Wed, 8 Apr 2009 09:03:03 +0800
Message-ID: <46dff0320904071803k68fddff4j226760392e0c5bcc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 08 03:04:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrMDY-0000Kl-Uk
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 03:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755832AbZDHBDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 21:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755163AbZDHBDG
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 21:03:06 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:21763 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753335AbZDHBDE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 21:03:04 -0400
Received: by rv-out-0506.google.com with SMTP id f9so3005885rvb.1
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 18:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=4AiRbXuJ36bQY5GePKjici9Q9bSg5KF/3CUWqzNA1vU=;
        b=XxP0VCbE9VSib19DHDA3Wi8DiIS6qjfxK4YWYo96+JsELFibVzpYu0+E+Vl+6d13a7
         lNZRNMoc6JccjoRhWv6G9AETkxSa8nUfCs6BwP9AMMu0t3vTDi6ennyerWIYUW5bfFMX
         Wiz/BrXvjjrJy7uvvaz7456bHE64rmmFItpFE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=UKSinTKMc4tCoULkLP2hRwIUmWfhUN+Tk/hEgPH5PU2DBZgmLGuWV7MPzle6cocEkR
         rWSsV5BJzEQ/0Ka4WptQzbOhRQ1k9glUOOrZOvol09oe+hvJvSrOQuKX5UmmDyAg2fe5
         SG+RrsFGvbZ4ax9urMLq9KKFvl1BwykacILWM=
Received: by 10.114.199.3 with SMTP id w3mr388680waf.181.1239152583341; Tue, 
	07 Apr 2009 18:03:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116014>

There seems to be a patch for this ( add -e?), but i forget where to find it.

For a big change, instead of "add -p", it may be easier to edit the
index directly ( with the corresponding worktree file alongside)

Ping Yin
