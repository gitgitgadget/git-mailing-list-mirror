From: Brent Goodrick <bgoodr@gmail.com>
Subject: How can I force git to recognize a change change in file modes?
Date: Fri, 27 Feb 2009 17:17:14 -0800
Message-ID: <e38bce640902271717s46cf47f9i7c6bf5aac0d5f273@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 28 02:18:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdDqn-0007tQ-21
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 02:18:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753601AbZB1BRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 20:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753262AbZB1BRR
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 20:17:17 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:38152 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739AbZB1BRR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 20:17:17 -0500
Received: by gxk22 with SMTP id 22so3269750gxk.13
        for <git@vger.kernel.org>; Fri, 27 Feb 2009 17:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=3/Hdfm4Ol+QE7uQB04vyyDMaKRGwLiskDuH7v9/WiTY=;
        b=omO8EhKjV89ZWowb1DMbq8hV+rO8X4eGKQYr4TStpT5VXqxoc6ZzLQ7O9LY0RCmhU3
         G+J3Y1nI0V12/4MU69ZYD4nmupcqHP+58qe2IS5UdK+w4jPI4wFVHqHNBgW7wWdjyW8P
         2d3dHxHrHQDrB0dJWVeVLb5UTuomWFXWnoqao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=LJTqNfYbBlqzVfD59ASiMg+x0oWA0wlbNQFc3zRFSgRom6ndRLfYicYDFb3G09Pg95
         QLFyCp0AyqxhTd0PyGfNuGtCmlHiFv1sAMvUgLynDhNFsN0X1bV765059yDNpA6unb58
         a4AYPamfS/Dmkamdya3bis2k3J6gba44wydeU=
Received: by 10.90.65.5 with SMTP id n5mr1607616aga.68.1235783834983; Fri, 27 
	Feb 2009 17:17:14 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111734>

Hi,

I checked in a slew of scripts, only to realize that the file
permissions were too open (I want them to be chmod 700, not chmod
755).  Somehow I thought that git was tracking those permission bits,
but simply using "chmod 700 <fileset>; git add <fileset>" did not add
the change of file modes, well, at least git status output doesn't
show it. Is there a way to do this?

Thanks,
Brent
