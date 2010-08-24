From: Wes James <comptekki@gmail.com>
Subject: coding process
Date: Tue, 24 Aug 2010 09:31:21 -0600
Message-ID: <AANLkTi=Aei+-nbNFqY4CNjx5E+nNaOSp7-j+ruuK4kMN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 24 17:31:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnvTF-0007Nr-T8
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 17:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755297Ab0HXPbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 11:31:24 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49530 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507Ab0HXPbW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 11:31:22 -0400
Received: by vws3 with SMTP id 3so574376vws.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 08:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=x1oqdayo5rztPuCgRjB5axXEp/IdAH6ivfl8TVpy2dc=;
        b=tHkS2Lkz9hQ0B/sEkt0KgTXeu7jpNgRcS1O9VtESStd+y6fPXJsd2Xour9e3pojngg
         AyCQ/gbM82LZN0quWxh1QSeZwDGgusfWOAKKszRlsb2Gmnixfr+Su16SRKqhmbNben2S
         wpn0iNufiv2waJRCnE2qTZz9ym4ll5k0TiqBM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=Ua1uIKX0WiQzQmNKhSxOC/CkXS12bAwKJjxcjvHByW0PV4EHUnzVfpUucPFtfL6pV1
         BXSxCY5w6R1VnB7D/hEC2PgEIN1yssc2UFkfKu/Qv4YEwNbk7huLPEr1PcE+FLZdJAGE
         Cd/9NvKhSTsdsTV2G33sB4EBf2hEbanDX2Nsg=
Received: by 10.220.49.204 with SMTP id w12mr4312852vcf.103.1282663881961;
 Tue, 24 Aug 2010 08:31:21 -0700 (PDT)
Received: by 10.220.94.21 with HTTP; Tue, 24 Aug 2010 08:31:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154318>

I am working with git and I'm wondering if coding like the following
is a good way to manage code:

create code then commit
when a good set up code is ready push to master
create a branch
create code then commit
when code is good, merge and push to master
go back to create branch

Anyone else have a procedure they go through when managing code?

thx,

-wes
