From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Patchdiff
Date: Wed, 27 Jan 2010 01:06:07 +0100
Message-ID: <fabb9a1e1001261606i4f706387vaf5647436e454fb4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 27 01:06:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZvQj-0004Tc-Jq
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 01:06:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755820Ab0A0AGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 19:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754941Ab0A0AG3
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 19:06:29 -0500
Received: from mail-pz0-f189.google.com ([209.85.222.189]:39485 "EHLO
	mail-pz0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754697Ab0A0AG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 19:06:27 -0500
Received: by pzk27 with SMTP id 27so1112556pzk.33
        for <git@vger.kernel.org>; Tue, 26 Jan 2010 16:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=hcT3ZsBliF+zrBxGx7UpkN2Wq+aHSaafCEp8iRj0U7I=;
        b=ciQ96hz3ZzDX7BP3EZJbiX4vRwJodfXgGo1vxmyXW7fjEvrLHJ1nrPOpIeh8oehtyI
         HQzs0jyC9oRWNpsED+reIghXGrTHk2nZT74k8D52SPaZLW9AvyBELXaVzydJGsBydnNJ
         HEyPlbsxAqzbaVWuXrXjnPP36BknmGA7T44EQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=P0CslsrE2Gf1kyibBS9PKZeZBx8qGPLUylE56RRErvBp/M9VP2WC4a04+U8dgtxs1x
         b1jwvbu26a4Iy3c9BWHQMsNdEOsIDK+8X+57QiKXWD9V79QqsfEVguIGBvdCPRoac8gg
         pQvQ6vYSk59pCGcEhpdmXF0yCzm6VCXtuC9X8=
Received: by 10.142.7.9 with SMTP id 9mr1107370wfg.149.1264550787130; Tue, 26 
	Jan 2010 16:06:27 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138091>

Heya,

Do we have anything that allows me to compare two versions of a patch?
In theory it'd do something like "apply both patches to the their
merge base, then show the diff between the results". I don't think we
have something like that, since there's probably some major caveats
about conflicts when applying the patches to their merge-base. Or
perhaps my theory is silly, and there's an easier way to compare two
patches (other than looking at a diff's diff, which I've never been
good at).

-- 
Cheers,

Sverre Rabbelier
