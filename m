From: "Tim Visher" <tim.visher@gmail.com>
Subject: 'Theirs' merge between branches on a binary file.
Date: Mon, 22 Dec 2008 15:56:31 -0500
Message-ID: <c115fd3c0812221256l494bb824ga8e1640efb07b20c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 22 21:57:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LErqb-0004PV-Dg
	for gcvg-git-2@gmane.org; Mon, 22 Dec 2008 21:57:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754455AbYLVU4e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 15:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754498AbYLVU4e
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 15:56:34 -0500
Received: from mail-gx0-f27.google.com ([209.85.217.27]:47472 "EHLO
	mail-gx0-f27.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754337AbYLVU4d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 15:56:33 -0500
Received: by gxk8 with SMTP id 8so1870027gxk.13
        for <git@vger.kernel.org>; Mon, 22 Dec 2008 12:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=AN7stknV12e5GnhWvKWhRGTG4SA67itDwsIkTc/hW18=;
        b=ddwnGItvclznbRZFvOmb9CGt4NjSUKDei3HA/wo4IUOCYGrg/uTUdS/ANNspbcUDxU
         /xY7UZUrwIb0NdBZmEu/uUW4gOWI2bN0LowoH5LNikOurYoOxsh+ajXj8O8I/tuA1/uW
         loCdnOBCPhQVAsfGCbLDlCw2JmsqcAVo47IBk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=wJM9KkMTdz9OFU+479JofUrCetne3IVnVEdnhfzFoQY+3oJhuEUjF2FbsnXCIGcu6J
         x9YBBCs0ZfkzC5wdmKMgFAcL+QQgSG9QUHs5aVNYVIyCHYGlD009F5u5LfZKEqNlTDl+
         L+3hknoyOWWs32HVNSZTbPpa5UqEVfNKqM6r4=
Received: by 10.100.164.12 with SMTP id m12mr4087358ane.144.1229979391875;
        Mon, 22 Dec 2008 12:56:31 -0800 (PST)
Received: by 10.100.198.2 with HTTP; Mon, 22 Dec 2008 12:56:31 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103768>

Hello Everyone,

I have a binary file that is coming up with a merge conflict
(obviously) between two branches and I want to simply say, 'take their
version of the file'.  Is this possible?  In subversion it's a pretty
trivial merge operation, so I assume there's something similar in git.

Thanks in advance!

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
