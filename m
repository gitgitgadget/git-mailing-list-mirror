From: "Christian MICHON" <christian.michon@gmail.com>
Subject: patches in context format ?
Date: Mon, 12 Jan 2009 10:00:11 +0100
Message-ID: <46d6db660901120100g7f62a0c2k68c96cbfc23dab5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "git list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 12 10:01:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMIfz-0005Ok-Ge
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 10:01:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbZALJAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 04:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751958AbZALJAP
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 04:00:15 -0500
Received: from fk-out-0910.google.com ([209.85.128.187]:36973 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950AbZALJAN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 04:00:13 -0500
Received: by fk-out-0910.google.com with SMTP id 18so5306554fkq.5
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 01:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=CsBZOrthUlcV1BLlOuwNpoelTaHFOeAmVPGTp33FiGg=;
        b=DNrqW7khF4nqj/Rhl6GYuijWiat/NiIUw7xGPcJN3zvOAPnv5z//V278RTPOxUGGk4
         mj5Kh628sa1d0cYF54m1iN2ADj37C0Yn7Lx3UqK6CoM1P/yLsMmHdkN2kP1F3AeWgV7o
         /FYNZgbm1qu9whCiAihsJxDlapeBYsOK+YkYY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=e6vYB1H31sSDfU8SVFhb0ez8e3Bvgugb+EC+CDLYuabipRGCmCxoJBIAn969suvEsq
         FNvtKucqOF6UnEGcz51TXV17JH9Jg0BNMB2FWijZbXlYh8gKYktTtvP0sPe/+qVUpWRi
         D0K0Djf3xiO4U7NWxczcmGiyQKpoKaJoeRQcE=
Received: by 10.103.248.1 with SMTP id a1mr10287262mus.40.1231750811773;
        Mon, 12 Jan 2009 01:00:11 -0800 (PST)
Received: by 10.103.118.7 with HTTP; Mon, 12 Jan 2009 01:00:11 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105306>

I'm maintaining a git tree of the vim project: this work can be seen
at http://github.com/cmichon/vim

vim patches do not come as unified format, but only as context format
instead (from a "diff -c").

The current solution I have is to use the original patch command,
stage modifications and add new files. I do not like this solution,
because I have to work out the commit messages out of the mbox and I
lose reproducibility. I'm basically maintaining a subset of shell
scripts, the original patches and an artificial way (ugly) to get
timestamps of modifications (for the commit dates).

Instead of this complicated procedure, I'd like to use "git apply" or
"git am", provided I can get git to support "context output format" as
input for patches ?

I guess the answer is no, but has anyone on the list been working on
this ? is there another way to translate from "context" to "unified"
format ?

TIA

-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git inside !
