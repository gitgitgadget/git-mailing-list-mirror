From: John Tapsell <johnflux@gmail.com>
Subject: Groups of commits
Date: Wed, 28 Apr 2010 10:59:44 +0900
Message-ID: <j2u43d8ce651004271859t8f306261n330004142a42b6df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 28 03:59:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6wZ5-0004Ya-P0
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 03:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754718Ab0D1B7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 21:59:46 -0400
Received: from mail-pz0-f204.google.com ([209.85.222.204]:50305 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753548Ab0D1B7p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 21:59:45 -0400
Received: by pzk42 with SMTP id 42so9473766pzk.4
        for <git@vger.kernel.org>; Tue, 27 Apr 2010 18:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=TG3haVndeanEjILHBWe71HbcSyQK20ldm9y+aGjmrLM=;
        b=L2T4ngNcV1ZNNqjIwmkEJd4WRtIvvihPRdimABzm8zlpCg79CufjiaIMFqcnnI/+p/
         2bwVYx/kCttwrhwvfFx0XvLUGmsQtxMg+l9icWb8028DpIP3YKeNHiOJ8k4Z41AEdFLp
         DUnbi6evmnx8ozUuZKtFKm8bCBNjo7fuMbcTI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=MKoDo9yiBLJH5wgcB2NsPPNnFJow5MWiqTzr9ezl7JHduS0IZXPQZAUUu5xUlLnVAj
         NZRwwylYcCPBURBq9lEBl/Mfn+GvC/QUQjpovnUuvO0iOm5br5D/VBO0XfY38JFU5/g6
         yJJTGwIz8lJm2n7B3UFTfPLSD1lWlqJw820u8=
Received: by 10.114.214.26 with SMTP id m26mr3794655wag.204.1272419984587; 
	Tue, 27 Apr 2010 18:59:44 -0700 (PDT)
Received: by 10.114.14.18 with HTTP; Tue, 27 Apr 2010 18:59:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145964>

Hi all,

  In my work place, we have a lot of strict rules to get something
committed.  The code has to pass against a large test suite, it has to
be tested on different hardware, and so on.

  The problem is that it forces everyone to have one single large
commit for a week's work.  All the intermediate stages get squashed
and that history forever lost.

  It would be nice to have a commit in the repository, treated as a
single commit for all purposes, but then be able to split it into
multiple commits if necessary.

  Any ideas?

John
