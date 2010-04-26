From: Paul Richards <paul.richards@gmail.com>
Subject: Alter parent ID of existing commit object
Date: Mon, 26 Apr 2010 11:13:53 +0100
Message-ID: <n2xa1138db31004260313jcd22b2ebw403ca2bd547e784b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 26 12:14:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6LKG-0006QI-5K
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 12:14:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981Ab0DZKN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 06:13:58 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:34336 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396Ab0DZKN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 06:13:57 -0400
Received: by wwb22 with SMTP id 22so280525wwb.19
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 03:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=Vr/pAWuMzEHIeog27at85tVb8yQC+aZLzf/yUjUVyS0=;
        b=fFB05s90Y23EG/HCkUFmCwzBMgrE8dDaIxdBpjdI2HHGrWqMlSvNDHXqcPwbGvvgOh
         LDBpBjzbqHJfk8gyghKW460dpmM9VU6mfRd5gfZwbneC7yWk+aoCNuXtmJkBQQEs8H2w
         9NqanN8Mid7i6YPcw8gwF/5XUYsSqb2boLIbU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=UzuUNh8cGPfEGWpTDHp/b47XbOlvhIUNqQLFIbQVNeobp3uaSFyykYvpPWPperOwOz
         JzUz++o8ia8nvZEY7KToRD4T4N/H7qssOzgAFYPuY7yCxm9duHyMQLLGVM8qCTqVEdLD
         c0gsxLF26D+wDiVM7SWnxxbHPCzOcrervidLc=
Received: by 10.216.86.142 with SMTP id w14mr4288137wee.33.1272276833929; Mon, 
	26 Apr 2010 03:13:53 -0700 (PDT)
Received: by 10.216.81.75 with HTTP; Mon, 26 Apr 2010 03:13:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145806>

Hi,
Is it possible to edit an old commit object and only alter the ID of
the parent commit but otherwise leave all the other information intact
(tree, message, authors, date, etc).

I'd expect such a command to return the new hash of the modified commit.



-- 
Paul Richards
