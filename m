From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Merging (only) subdirectories
Date: Wed, 1 Dec 2010 11:18:10 +0000
Message-ID: <AANLkTimZc0r8WBOsE73V=7SKdZgONiCKfYCk7rBrCY3F@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 12:18:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNkhY-0003Tn-FA
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 12:18:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752967Ab0LALSM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Dec 2010 06:18:12 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:32870 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520Ab0LALSL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Dec 2010 06:18:11 -0500
Received: by gwj20 with SMTP id 20so3308168gwj.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 03:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=cghpNv/5g5NsA9+IX7ZAtSgGzq1bM36UDh0VicOlUNA=;
        b=LFemjLBPYjEntK//nr7tnVhl4svLeTTywHVmNvHlnaNb5hqevSzXFl3VHiGA/saAfJ
         u3oNW/teo2Z73lNz+LZiC9um8+tdtgVgwkNn6MxPalGdQRFPZM67dEMPi8o56uMlTuhs
         uiTjiuXU6Gvc9f1/yFST17KtVjL68XoyAXjYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        b=m9ihuJv3WD470WaQCQUrS9ss/cPP3+Bjesa3JdVx4ui17GHWONDChlEvAhYU7TuzTa
         aDb4lTt6Qk8vmZ3itvwZJrXzHZcCoS3czWtEgq4w8U9w3YvDyB7MRihVWS6eCrqXqRj/
         XnhpVTfcbe/hGFrbwQwq2xuvijnjxqBQvfhV4=
Received: by 10.100.80.8 with SMTP id d8mr859025anb.108.1291202290830; Wed, 01
 Dec 2010 03:18:10 -0800 (PST)
Received: by 10.100.38.15 with HTTP; Wed, 1 Dec 2010 03:18:10 -0800 (PST)
X-Google-Sender-Auth: D378wiZv7x7QUGnT10P85PG2ixA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162498>

This might take a bit of explaining... and for those familiar with it
I'm talking about Moodle themes which will help one or two of you.

We develop themes for Moodle. All themes live in their own
self-contained directory. So, when creating a new theme we create a
new branch (from some version of Moodle - more in a moment) then a new
theme folder, do the dev, and commit/push the results.

We have lots of clients and for one reason or another we have lots of
different versions of Moodle and/or different customisations. So each
client ends up with their own branch.

The problem comes when Client A wants to purchase Theme B. We can't
just merge the theme branch because all the rest of the project
contains (potentially) a different version of Moodle. So we have to do
lots of messing around to get the theme branch in and/or loose the
theme commit history in the process.

What I would like to do is to be able to merge branch B into branch A
but ONLY stuff that concerns the theme directory. I don't think this
is possible. I'm reluctant to keep themes in a completely separate
repo as that just makes testing them more problematic.

Does anybody have any thoughts or advice (assuming this all makes
sense)? =A0Cheers!
