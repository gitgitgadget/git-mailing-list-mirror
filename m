From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: How to force explicit user info
Date: Wed, 5 Mar 2008 14:39:20 +0100
Message-ID: <8aa486160803050539p4c443302nc322241d59fe9374@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 05 14:41:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWtqs-0001pX-HV
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 14:40:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbYCENjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 08:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbYCENjZ
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 08:39:25 -0500
Received: from ti-out-0910.google.com ([209.85.142.184]:60614 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbYCENjY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 08:39:24 -0500
Received: by ti-out-0910.google.com with SMTP id 28so1882749tif.23
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 05:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=a1ZICfsQO9Fn8p8UvnSbZsoogvGmo1kUVlI80XSIXKA=;
        b=M9R0bBrJ6vTcuV4isMIpfLNkS+8iySUkhzxyP5vXopgugldHtFq6sdAVRihe9sve87nwlT1xREGbfGQTK+eJtOX620lGmqlQXFWNRT//ejwDztigle6nhNy+qsKFsZiFJnCqdqYB+7jFyg8I8ibaUJL4sIYUz6KlxZPOLSLQnyk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=oDB5MDQKZ6RTnW70DI9/YQi5M8xebhNBv2V4NpDna39Vw7RJVWzYdxn7j8F8kAKuWApo+Y/VWwfBekNIX2HWpBpNE6EttTnzZgVTJP+NBiW8rhRH75IkiQl7g9E1cDcmM4xZag2NR8/Hbi/X3Ez4S8AkOM0nh+xW5K/IPa6SXcg=
Received: by 10.150.205.13 with SMTP id c13mr1169520ybg.132.1204724360982;
        Wed, 05 Mar 2008 05:39:20 -0800 (PST)
Received: by 10.150.199.9 with HTTP; Wed, 5 Mar 2008 05:39:20 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76214>

Hi  *,


  how can I forbid the gecos info and always force git to ask for an
explicit user.name and user.email?

  I use a different email for personal projects and for work projects,
using the same machine. So I set user.email locally in each
repository. But when I forget setting this I get
userid@hostname.(none) as the email. Is there a way to just die and
ask for this info (maybe user.AlwaysExplicit or something like that)?

  Thanks

  Santi
