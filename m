From: Bruce Korb <bruce.korb@gmail.com>
Subject: Newbie question: how can I list added files?
Date: Wed, 23 Jun 2010 10:31:07 -0700
Message-ID: <AANLkTinxOE5xcP_V-PvoZGlfsxtcCafoYKy_PuBZnQnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: GIT List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 23 19:31:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORTnR-0005B5-9P
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 19:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902Ab0FWRb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 13:31:28 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:51297 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532Ab0FWRb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 13:31:28 -0400
Received: by gwaa18 with SMTP id a18so131142gwa.19
        for <git@vger.kernel.org>; Wed, 23 Jun 2010 10:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=CbEYKmevp1WMveQ9NwD8DM7egOHRdb2kpfYAKCO4lvY=;
        b=kIAVvx87y+Nd3O9TZ5Ph/5sPCq3eK95W8q0dweqzJlKtrZegWoy2XZuwqiq07T/aV+
         1nvVFvioMJ56PsqsweKmDBRdK/nGUI3O3TdjtncxsK5AXV93+Kq/+J4K3NKq0iZQgNC2
         UoEqrJS56HjSVBf4mU9GvesWrYdTXDn9IwKC8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=GEMD9mG7VrggwkklQssw0bY46uMaIuEHrIaQguhzeI4y8xdgZK9JS9K6TLyFAxpLHj
         aewcjjlekf4qq8XoHmAUHCBsMWdUBWl/vbMV7Bxg2eG0mdpJvtsNurKxgsJkTfJgW1zA
         ebasl6MEMjlLkqNeKk5iuD1TD6oFFi6aECrSc=
Received: by 10.100.128.13 with SMTP id a13mr7109835and.159.1277314287192; 
	Wed, 23 Jun 2010 10:31:27 -0700 (PDT)
Received: by 10.101.107.13 with HTTP; Wed, 23 Jun 2010 10:31:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149522>

git-ls-files doesn't seem to have an option for it,
neither does git-add.  Seems like it ought to be
trivial, but I'm not seeing how to do it.  :(  Thank you!!

P.S.:  yes, I know I can parse the output from git-status.
I'd really rather not for various reasons.  If it's the only
way, then I'll do the only thing.
