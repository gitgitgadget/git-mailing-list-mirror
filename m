From: Khawaja Shams <kshams@usc.edu>
Subject: Multiple clients accessing git over NFS
Date: Sun, 14 Nov 2010 13:24:01 -0800
Message-ID: <AANLkTimyFkVFAw4s2fiWKZFPvnx15K6U6GbxmRgznx7Z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 14 22:24:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHk3V-0005vD-39
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 22:24:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755867Ab0KNVYE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Nov 2010 16:24:04 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57917 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753583Ab0KNVYC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Nov 2010 16:24:02 -0500
Received: by fxm6 with SMTP id 6so1326765fxm.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 13:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=gGx0JTK7VUTlJa582osT1bEZZZAVV0KFco5bOEsiUvo=;
        b=bPZ4qb1ruYTdzi8WCqeNpij/i2LQ7GJOgxQYkLJc7XYk8z1hmTnZ6JA9Y6UNPb4wZr
         mpqkrgiNpCGQ3ZmdsGJ4tkOjDtNKHnYEKhgcgdK4r9Go/8ZBarC1mCRWSFPCW95HbKzw
         fWguidxjtZ+ONyoRwKAoK/4OuLXC5uRk9RRPs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        b=LAVJeCdA6cE+7AAa3PRAJFeMjwwwBQ8/1BhAIIjvonZ2JRjlOt9000G4TOzZ8TVLvM
         zC6ptJ4zD23ILUhf/GykUZ6Ug2v14INfqCNXym3cgXuF7A2UQpmq0jw35jwhofcaihvI
         K6DE5N1Gxzlgd46l/b8njlEMNg/ERLu9qu6vU=
Received: by 10.223.78.139 with SMTP id l11mr3855603fak.31.1289769841313; Sun,
 14 Nov 2010 13:24:01 -0800 (PST)
Received: by 10.223.86.205 with HTTP; Sun, 14 Nov 2010 13:24:01 -0800 (PST)
X-Google-Sender-Auth: 32NS2NEgMmp7IZ6lP7pDHV0m_U8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161443>

=A0=A0Is it a recommended practice to share a repository over NFS, wher=
e
multiple clients can be pushing changes simultaneously?=A0 In our
production environment, we have a Git repository setup behind
git-http-backend. We would like to place multiple Apache servers
behind a load balancer to maximize availability and performance.
Before we proceed, we wanted to check to see if this practice has a
potential to cause repository corruption. If there are other ways
others have solved this problem, we would be very interested in
learning about those as well. Thank you.
