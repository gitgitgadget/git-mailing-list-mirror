From: Scott Chacon <schacon@gmail.com>
Subject: Git Notes Usage
Date: Mon, 8 Mar 2010 19:52:47 +0000
Message-ID: <d411cc4a1003081152j5b9f3028wa230b5e1d22a36ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 08 20:52:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Noj0Z-0002yC-Ie
	for gcvg-git-2@lo.gmane.org; Mon, 08 Mar 2010 20:52:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755512Ab0CHTwv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Mar 2010 14:52:51 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44749 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754515Ab0CHTwu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Mar 2010 14:52:50 -0500
Received: by wya21 with SMTP id 21so3454797wya.19
        for <git@vger.kernel.org>; Mon, 08 Mar 2010 11:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=+Ns5JJpmHEUZDotPmQZ+ovMENBDmxISiaReUsu+ffIY=;
        b=nAUjRlillc3W6ceAlfYlNUuom7VrXlRkZlErZiy3m8H7fSARN2hDprLawEbmIzNYxX
         g0GnRfRU3nuyuEil4XyfhesoezZ1PsNZ0h5qp5IiT0akySZBCTJCjN2md/N4tjCZyl09
         kIyd0dC7DMJ9hDJFvQNzqoD2UCN5gEtQBo4Vg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=HhxF2JJRLAB5hUL2LjrrD8r3xEILdN1rgv6yNT7NkM8ew2+fu/zy0VCYJgD5D74YLO
         9wPmmYrsOw3gra9AOBGpHcgEdZbFEtl3M2rElSWe50qBGjW9fiiQOODiM03NCEUxki0l
         aXNM11x7C+5T+dZPNZk7nLw7VMFI6eW0fiqY0=
Received: by 10.216.171.145 with SMTP id r17mr2895608wel.182.1268077968746; 
	Mon, 08 Mar 2010 11:52:48 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141780>

I've been trying to write up the git-notes functionality a bit and I'm
a tad confused about the remote workflow.  To share them, is it only
do-able by pushing via the full refspec (ie: 'git push origin
refs/notes/*:refs/notes/*')?  Likewise to fetch them from a server?
Also, if two people write notes into the same namespace at the
same time, how does one merge them?  Is the only way to do so to
actually checkout the notes branch into your working directory and
merge the notes trees?

Thanks,
Scott
