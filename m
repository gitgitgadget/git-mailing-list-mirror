From: Tay Ray Chuan <rctay89@gmail.com>
Subject: specifying one-side of a merge commit?
Date: Thu, 12 Aug 2010 13:11:52 +0800
Message-ID: <AANLkTi=mnO8+XM4Bcjneaq+ngUSFesvZ_TYMRyy=f43a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 12 07:12:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjQ59-00059W-VF
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 07:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432Ab0HLFLz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 01:11:55 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:44775 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919Ab0HLFLy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 01:11:54 -0400
Received: by ewy23 with SMTP id 23so453935ewy.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 22:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=x5m12tbU1gjIXuQ/4+CMRaLVdQE6rffzvDMBOwUuwhI=;
        b=mbZj+V0ArGqRPb78FHM1o0rB/DtoFDpOUE1h5uA3OHSIADr27V1Sz66OLd/iqsqEn8
         SQDvfLebXSw4UqAu3ZC5aEhAcO4aKGnVFP5QuC33S1lAgUs8hGwsnpaC3VzOq/OdPkDv
         cb+TT3nLJORvqgatOSEBkVOcX/fA7+/Jbpjr4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=Q5ojh+JyRxi+hjVYEWNHtjcPvCTAgDX4dOQn2qnbbcqHPX/weHlRKTAqqcmUq74XZw
         vKC0/IJLBZ2hHgGWCVOvMNSwnDAFV3u5wLKShiIHHt7hZR3vyj/75n3nnyVkTbKs970a
         cZS2Njm+WQOmQroICpkscauc9rRiTTdjHBKP0=
Received: by 10.213.104.138 with SMTP id p10mr2324899ebo.6.1281589912986; Wed,
 11 Aug 2010 22:11:52 -0700 (PDT)
Received: by 10.213.15.72 with HTTP; Wed, 11 Aug 2010 22:11:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153338>

Hi,

I wonder how do you guys do this?

So far, what I've come up with is this:

  $ git rev-list $MERGE ^$MERGE^ | head -2 | tail -1

I'm sure there's a better way.

-- 
Cheers,
Ray Chuan
