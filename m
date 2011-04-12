From: Patrick Doyle <wpdster@gmail.com>
Subject: Confused situation after a merge
Date: Tue, 12 Apr 2011 09:29:00 -0400
Message-ID: <BANLkTi=hkXjSRzB4H11c7YDw6OXDqLTnjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 12 15:29:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9der-0006VK-TT
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 15:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755367Ab1DLN3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2011 09:29:22 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53251 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754974Ab1DLN3V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2011 09:29:21 -0400
Received: by fxm17 with SMTP id 17so4266967fxm.19
        for <git@vger.kernel.org>; Tue, 12 Apr 2011 06:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=QxjlVr/IMbOHYqJl9lM9HemeEpAUCDHKUSBDyhw9vh0=;
        b=keZIQiMe1bHYV0Fl68r0fK2XoS6RtQ940+D11dAhVPjUQqCoRYFavfUC2CXGJ3nyUX
         /eY60ybDmMIxoAkg/Ta8NiHtUVyM4Y36yTOCdI0LI0r+X+dKaGabr41FWTg8I7Ez2HnR
         gRlWGSqMGfQKrHSUFOzq/K1VoW7VfAXJk7Z34=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=kiPOgqII3XRQblpZTflnBLH22KAdDZ34EnGqTPQZVBVNFrmzHcCsil/Q+oICfrV4Vm
         OO0TelA55n3ir/JcYc+94QpPwJsOilBkOknlp4Yc93MDk78kmOWwjttiBS7nhkTqPHLo
         ZNNcTa4whZTWxN0/EVU8nLpuqTVpHFwz8Krdo=
Received: by 10.223.112.83 with SMTP id v19mr4512089fap.122.1302614960172;
 Tue, 12 Apr 2011 06:29:20 -0700 (PDT)
Received: by 10.223.123.135 with HTTP; Tue, 12 Apr 2011 06:29:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171392>

Hello folks,
I'm trying to sort out a confused working copy.  I'm not sure how
things got into this state (I'm still waiting for a phone call from
the person who got things into this state), but I have a working copy
whose "git status" looks like this:

# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	new file:   oalib/cmos7rf_sc/tiehi/constraint/hierDesign.oa
#	new file:   oalib/cmos7rf_sc/tiehi/constraint/master.tag
#	new file:   oalib/cmos7rf_sc/tiehi/constraint/prop.cfg
#	modified:   oalib/cmos7rf_sc/tiehi/layout/layout.oa
#	new file:   oalib/cmos7rf_sc/tiehi/schematicz/data.dm
#	new file:   oalib/cmos7rf_sc/tiehi/schematicz/master.tag
#	new file:   oalib/cmos7rf_sc/tiehi/schematicz/sch.oa
#	modified:   oalib/cmos7rf_sc/tiehi/symbol/symbol.oa
#	copied:     oalib/cmos7rf_sc/tiehi/layout/layout.oa ->
oalib/cmos7rf_sc/tielow/layout/layout.oa
#	new file:   oalib/cmos7rf_sc/tielow/schematicz/data.dm
#	new file:   oalib/cmos7rf_sc/tielow/schematicz/master.tag
#	new file:   oalib/cmos7rf_sc/tielow/schematicz/sch.oa
#	modified:   oalib/cmos7rf_sc/tielow/symbol/symbol.oa
#
# Changes not staged for commit:
...
#	deleted:    oalib/cmos7rf_sc/tiehi/constraint/hierDesign.oa
#	deleted:    oalib/cmos7rf_sc/tiehi/constraint/master.tag
#	deleted:    oalib/cmos7rf_sc/tiehi/constraint/prop.cfg
#	modified:   oalib/cmos7rf_sc/tiehi/layout/layout.oa
#	modified:   oalib/cmos7rf_sc/tiehi/schematic/data.dm
#	modified:   oalib/cmos7rf_sc/tiehi/schematic/sch.oa
#	deleted:    oalib/cmos7rf_sc/tiehi/schematicz/data.dm
#	deleted:    oalib/cmos7rf_sc/tiehi/schematicz/master.tag
#	deleted:    oalib/cmos7rf_sc/tiehi/schematicz/sch.oa
#	modified:   oalib/cmos7rf_sc/tielow/layout/layout.oa
#	modified:   oalib/cmos7rf_sc/tielow/schematic/data.dm
#	modified:   oalib/cmos7rf_sc/tielow/schematic/sch.oa
#	deleted:    oalib/cmos7rf_sc/tielow/schematicz/data.dm
#	deleted:    oalib/cmos7rf_sc/tielow/schematicz/master.tag
#	deleted:    oalib/cmos7rf_sc/tielow/schematicz/sch.oa

That is, the index contains a bunch of files listed as new files,
while the working copy lists those same files as "deleted".

Not having been there when he did this, I don't know exactly what
happened, but I suspect that he tried to do a "git pull" which
resulted in some conflicts (with our mostly binary repository) and
that things went south from there.

Looking in .git, I see a 41 byte ORIG_HEAD from 10:49 yesterday
morning, and a 169 byte FETCH_HEAD from 19:51 last night (as well as
an updated index from 19:51) last night.

I guess I'm looking for some tips on how to do some forensic analysis
to understand what was done, as well as some tips on where to go from
here.  You folks are always so helpful when I ask questions such as
this on this list.  Thanks again.

--wpd
