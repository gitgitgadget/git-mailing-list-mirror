From: Bradley Wagner <bradley.wagner@hannonhill.com>
Subject: SVN to Git: trunk moved during repository history
Date: Mon, 19 Apr 2010 17:18:16 -0400
Message-ID: <o2i2f0f6ced1004191418i6a144652sd9ac38b07fb7b661@mail.gmail.com>
References: <l2x2f0f6ced1004191416jd8db7d5eyf8fc7a55f5efa2cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 19 23:18:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3yMI-00070Y-QK
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 23:18:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066Ab0DSVSR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Apr 2010 17:18:17 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:57609 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721Ab0DSVSR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Apr 2010 17:18:17 -0400
Received: by pva18 with SMTP id 18so3469279pva.19
        for <git@vger.kernel.org>; Mon, 19 Apr 2010 14:18:16 -0700 (PDT)
Received: by 10.231.4.141 with HTTP; Mon, 19 Apr 2010 14:18:16 -0700 (PDT)
In-Reply-To: <l2x2f0f6ced1004191416jd8db7d5eyf8fc7a55f5efa2cc@mail.gmail.com>
Received: by 10.115.116.5 with SMTP id t5mr4788414wam.77.1271711896192; Mon, 
	19 Apr 2010 14:18:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145331>

I'm trying to port an SVN project to Git. We have gone through
multiple layouts for our SVN repository. It started off with just a
mainline branch in the root folder. Then we went to the standard
layout (branches, trunk, tags).

The problem is that when I do a "git svn clone --stdlayout"=A0of the
repository, it's not picking up any of the revisions from when the
trunk previously resided in the root directory.
Is there any way to specify that the trunk had multiple paths the way
you can specify multiple branch folders with -b flag? What would be
the best course of action for reporting an SVN repo who's layout had
changed during its history?

Thanks,
Bradley
