From: Henry Huang <henry.s.huang@gmail.com>
Subject: [SoC RFC] about "restartable clone"
Date: Fri, 13 Feb 2009 21:38:41 -0500
Message-ID: <1dacb48d0902131838i3a717ec9r96d8ae8224f7bc66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 14 03:40:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYARu-0001lC-P1
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 03:40:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753457AbZBNCin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 21:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752999AbZBNCin
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 21:38:43 -0500
Received: from qb-out-0506.google.com ([72.14.204.236]:30551 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899AbZBNCim (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 21:38:42 -0500
Received: by qb-out-0506.google.com with SMTP id q18so1155058qba.17
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 18:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=HJ0uS41Ws9Qmt6i45sY+3CkjKascq/nBcSg3eTwdpts=;
        b=Orxn6r0TGh/j4c6b0umM68pa3uyIlPWxVCJ1r3HoMoNQ0kwdyNkUnI77Vh733K86/G
         vh/sGTNdd9SaZ1nWwfFkCOdAgBkUwLu2k2Dz8ulRuQ8f2Wbu/b20sx7XsUfA6gxMVMlF
         ESSdB4tORdVUE+KO11wFDaF4s+AmCmlQHJHlg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=XvzWLyCvF2NbM63IQfEVaOw/GPEIqp0EWbN8lRPQTiUiaInsB9TUosUdg713akiM9G
         sgMVRCakca8GNgMwThEgqoyBTadNzFUTQxKIOexg6u3ilCIHsM36kEtDWGe0vAAg503l
         Tr0h3YPJ2SNKWUlpPlxmYuniKS4Mn5jzS8ygw=
Received: by 10.115.92.2 with SMTP id u2mr1091338wal.228.1234579121337; Fri, 
	13 Feb 2009 18:38:41 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109807>

Hello Git Team,

I'm a student interested participating in restartable clone project
for this year.
To this time, I have used mainly SVN as version control.
Recently i began to try git -- it is so exciting! :)
When i saw this project in Soc2009Ideas,
i feel it is a appropriate project for me, as this problem i have
experienced a lot:(
-- "Users need to start over from the beginning and try again when the
clone is interrupted in the middle."
i am eager to solve it with my passion and work.

Now i have several problems:

1) Less familiar with git source code
2) Less experience in Open Source Development
3) No proposal for this project

My questions:

1) Are there any documents for git's internals ?-- (.git/ structure,
data structures: DAG of objects,
branches, tags, index etc.) and workflow of main operations
2) Could anyone give me some hints -- where to begin with this project?

At the end, few words about me, what you could expect:
I'm a MSc undergraduate at Nanjing University of Posts & Teles (China).
My main areas of interests are software engineering.
C and Python are my "main" Languages.
so I can analyze existing git implementation.
I have worked on some smaller projects related with protocol
implementation in small teams.
It seems to be great experience if I can join git community:)

Thank you for your attention,
I'd appreciate any comments, expectations or information!

BTW: i have enough free time for doing research and programming on
this project from Feb to Sep.

Any suggestion would be appreciated.

Thanks,
Henry Huang
