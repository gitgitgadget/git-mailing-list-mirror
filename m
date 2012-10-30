From: Francis Moreau <francis.moro@gmail.com>
Subject: Why does git-commit --template want the template to be modified ?
Date: Tue, 30 Oct 2012 11:53:08 +0100
Message-ID: <CAC9WiBjeuy8dpSnp5Jq55hs1-CJUzwpH70GZ1ZGOF2dAAeypaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 11:53:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TT9Rj-00028R-Od
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 11:53:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759167Ab2J3KxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 06:53:10 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:56467 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758897Ab2J3KxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 06:53:09 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so93358obb.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 03:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=su+zhHU/0yjflQ32eD2/edYQqiEdUHrLLktHDVsGjEI=;
        b=pnG1qJbLFJpCIZr7KL0Hs35HABKE3+NwYPn3CEPe52ZiaftUUQpUhCEEgNHA+ocJBx
         QFdSl/wRsqSGqc4gnilF7i5mw+jfga6hhStPre53fWr7Y4SU1uuSNqbONZ9evjdOPSHA
         EEJi9CNIxdqCM9q5AeTe42NQ8xJXYRHqAVdSrrSPHbrhdSWoogiBrctrGur1RtW28h4t
         JvSou6D4MioyCo5RiBqraKfnwzDyfsYlGXNKk7cFyf7USHyR8jPVDi+6UYrK1/QcY7P2
         DCZtj0tBxQYzbiTaE3sJ2zKc44lZdlEndMuMrM19lvVKRn9MFbt6au5o2mz7eZbe0xlc
         heOQ==
Received: by 10.182.64.101 with SMTP id n5mr26917292obs.11.1351594388449; Tue,
 30 Oct 2012 03:53:08 -0700 (PDT)
Received: by 10.60.93.163 with HTTP; Tue, 30 Oct 2012 03:53:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208694>

Hi,

I'm using git-commit with the --template option. The template I'm
given is self sufficient for my purpose but as stated in the
documentation, git-commit wants the template to be edited otherwise it
aborts the operation.

Is it possible to change this ?

Thanks
-- 
Francis
