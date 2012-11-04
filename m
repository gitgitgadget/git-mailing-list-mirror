From: Rotem Yaari <vmalloc@gmail.com>
Subject: git-archive submodule support
Date: Sun, 4 Nov 2012 16:53:07 +0200
Message-ID: <CADyFpa7t_iCr6B8ns8QqkySRXfYtaJ8W0iseHWGz6jv62s_vzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 15:53:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TV1a4-0007XF-F6
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 15:53:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754509Ab2KDOxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2012 09:53:30 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:34135 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754545Ab2KDOx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2012 09:53:29 -0500
Received: by mail-ee0-f46.google.com with SMTP id b15so2519533eek.19
        for <git@vger.kernel.org>; Sun, 04 Nov 2012 06:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=SH+9GYDI5JERTrYxrFCDrEFbB1GOrv7joxwYMfZAr04=;
        b=keO/ncL2SG7J+2zTRSFaHIHHBiQBr3xdBzXPBRK1jfEkjMSFJnqVWanG0p9reK7Wrq
         nR7ufvi/N5kBEWzUWyvhCKBcurYzfrQ7gY9ubVjt3l1MY/gnUN8MXsm9b48Yf1/Ltcha
         CTzCSDqbGTDmAI7v18xJq0ifHpwEa8H6PZADd9KkT0iTlAajSQtU+Sw4SJmdBLTc72jS
         4GneXp7rX0KoQkPFl/AyVzp5N1KjpXel+BVz8flMgYvVVTN7hOBIoLSxWvKiLEgyXhG8
         yZX0dhxOydSFEp9NY6bCWBXxrS0ivClnVAVu+m3zwupyluAEY2ggo+GtO5iP//4+BmTO
         5oIw==
Received: by 10.14.200.134 with SMTP id z6mr26898853een.33.1352040807912; Sun,
 04 Nov 2012 06:53:27 -0800 (PST)
Received: by 10.223.86.206 with HTTP; Sun, 4 Nov 2012 06:53:07 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209031>

Hi,

I was wondering if there are any plans to support inclusion of
submodules in git-archive. This is very useful for quickly preparing
ready-to-deploy archives of "unstable" branches etc., without the
users' need to clone submodule dependencies each time.

Is this planned at some point? Such a change would be greatly appreciated.


Thanks,

--
Rotem
