From: Chase Brammer <cbrammer@gmail.com>
Subject: StandardInput Not Continuing Process
Date: Wed, 8 Dec 2010 10:25:25 -0700
Message-ID: <AANLkTikBdOLjzJxikXCwTs52RByfNZzKamK+F-JhY0mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 08 18:25:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQNlk-0000dy-LI
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 18:25:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755122Ab0LHRZ1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Dec 2010 12:25:27 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43209 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754912Ab0LHRZ1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Dec 2010 12:25:27 -0500
Received: by wwa36 with SMTP id 36so1414403wwa.1
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 09:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        bh=E5YrIMqsTDm46pxV/ogHgKbvyEti5EDkVWJtrUZvVmA=;
        b=kWTaHGZ3aOIMt1yVwaxGJExBJ0H8X51gmJTQBR1Ira+j6D74bETZlJROFYJuTenPWE
         ljoK90CDduLT1kpgcopPfA1uK7G6wgZwFfav1VaO9CVgC9xavCt2aPmy42B6WNmG/84M
         1M07n/iZPDlJHNaSsI7GfM+S8JGhzCztYQ/nc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=tHjh8hB0YhBVqh1IaRB0dxh+ASfoRJbc+dNo5nQAXVBTCXrg8obbUk6n+fFGtLeeux
         tfjOgyJP4mqOUByxs6UTYQhkhgEH5eNNKsoqpKphWLtVi8tIb5/VI+uM0/uRdHCWk0Vg
         aln3MY1YeMeD7InL1O1gTGLUFUPzSuA9TS28I=
Received: by 10.216.171.74 with SMTP id q52mr240640wel.45.1291829125839; Wed,
 08 Dec 2010 09:25:25 -0800 (PST)
Received: by 10.216.175.130 with HTTP; Wed, 8 Dec 2010 09:25:25 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163206>

I am try to directly interact with Git by using only stdin, stdout,
and stderr.  So
not going through a terminal at all, but calling Git directly.  =A0I am
having an issue
with being able to continue a process that requires input.

=46or example, doing a clone from a HTTPS server may require a username=
/password.
I writing the password as utf, and also tried just UTF byes (ie no
prepended 16-bit int)
but am unable to get the process to continue and start the clone proces=
s.

Is there some signal, or trick to getting the process to continue?  I
thought that sending a
"\n" would work, but that doesn't seem to be working either.

Thanks for any help!

Chase
