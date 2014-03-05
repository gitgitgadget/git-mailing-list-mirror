From: Vincenzo di Cicco <enzodicicco@gmail.com>
Subject: fnmatch vs regex
Date: Wed, 5 Mar 2014 20:55:05 +0100
Message-ID: <CAKOJyXc2dezciw=x=-Gw3qjt3Sd=V=2Dy_ARZ25kmjYHULT5_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 05 20:55:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLHuM-0004aa-Pk
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 20:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752946AbaCETzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 14:55:07 -0500
Received: from mail-vc0-f173.google.com ([209.85.220.173]:41276 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbaCETzG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 14:55:06 -0500
Received: by mail-vc0-f173.google.com with SMTP id ld13so1524660vcb.4
        for <git@vger.kernel.org>; Wed, 05 Mar 2014 11:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=h94HeqQi9+vAQMLWRtQov4doIJ7/crFZ2X9lkKj6EL4=;
        b=HZVQUz+E93jcSUYVFcfdnWic27R+VPTQFQAOzUrRsJTk4QU/grmQ/au3XFxT6Ii3FM
         mYv3SlcDPuqkeULYIXUUotUy5Q3J6GA5QzKRxYmSk5gQZl9N9MNrB3rNDEACeybf1Qty
         U9A5F0L1YuOinb9/uXfeTK/b4ntw0fhAUkDrAXdTfGwONvXb4V0WR7mU6iHZPV7f7LTd
         vK29hlw0vq4AOFxroA6n5YqopsB6mNN39TBVGfJHBgS19wsW9AU8jLuW8JSvVjCIii/3
         pNPQDSkU0Hb1zTU1zDaQ8yrrdBLOCasIUFjlqs+wws+OeKiaJkufDMR+AqzBSSwxtv+O
         Ak4A==
X-Received: by 10.220.250.203 with SMTP id mp11mr1470558vcb.2.1394049305708;
 Wed, 05 Mar 2014 11:55:05 -0800 (PST)
Received: by 10.220.67.16 with HTTP; Wed, 5 Mar 2014 11:55:05 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243474>

Hi there, I'm NaN.
Recently I enrolled to this mailing list thanks to the GSoC.
I've looked the Ideas Page but -unfortunately- some projects are very
difficult for me.
I've looked the source code and I've seen that to perform a search
with a pattern to the branches list (and other commands) git uses
fnmatch() and so supports the glob pattern.
I haven't never massively used the branches or the tags to have the
necessity to filter in a particolar way the results, and the asterisk
has always worked very well.
But: why the decision to support the Blob Pattern instead of the
Regular Expressions?
With your experiences can a patch like this improve this side?

Thanks for the awesome work,
NaN
