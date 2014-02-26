From: Jacopo Notarstefano <jacopo.notarstefano@gmail.com>
Subject: An idea for "git bisect" and a GSoC enquiry
Date: Wed, 26 Feb 2014 09:28:32 +0100
Message-ID: <CAL0uuq0=Zo0X8mYRD6q-Q+QAcZhfmxOwKiRegDrRm3O_i0Q+EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 26 09:28:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIZr5-0006sR-KI
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 09:28:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbaBZI2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 03:28:33 -0500
Received: from mail-ve0-f179.google.com ([209.85.128.179]:46897 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbaBZI2d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 03:28:33 -0500
Received: by mail-ve0-f179.google.com with SMTP id oz11so1832315veb.10
        for <git@vger.kernel.org>; Wed, 26 Feb 2014 00:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=d5rPaN/C+OjKMXIGJ9jGO8GPD6ayJ1NDC2eZsduLSq4=;
        b=NnTq2ESGAOA4i1zdZXMLNxXKHytyjdSti3WurDty6f0oYvGD/OGVjUppl3FjKpiM6m
         o/376uQfxRX1fRpNvgag8WorRYBoKNFKuVw1hh9SPMZxgLWUxsIARzbT0PKvDG4I4kRm
         dYRc6jwmpSzrsnLl2LCDX7/ELXoNH96jq3pgAYp6I7Rdp3OKJ71qPq5OpBDT+ZAiVot2
         nRqzQuVz9mgE6iM9hohUULtNkGZpynuSsLU4cBAh17/zbYiyA7Ar2oiXnIFMpdX4nWTd
         haLh0PHANWwveaFslHehy8Jq527G1yhtHoRmpgI+oktEUFBh32Fgg2VBZBRxZNwscD9E
         br0A==
X-Received: by 10.58.59.100 with SMTP id y4mr4906079veq.4.1393403312183; Wed,
 26 Feb 2014 00:28:32 -0800 (PST)
Received: by 10.52.73.161 with HTTP; Wed, 26 Feb 2014 00:28:32 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242703>

Hey everyone,

my name is Jacopo, a student developer from Italy, and I'm interested
in applying to this years' Google Summer of Code. I set my eyes on the
project called "git-bisect improvements", in particular the subtask
about swapping the "good" and "bad" labels when looking for a
bug-fixing release.

I have a very simple proposal for that: add a new "mark" subcommand.
Here is an example of how it should work:

1) A developer wants to find in which commit a past regression was
fixed. She start bisecting as usual with "git bisect start".
2) The current HEAD has the bugfix, so she marks it as fixed with "git
bisect mark fixed".
3) She knows that HEAD~100 had the regression, so she marks it as
unfixed with "git bisect mark unfixed".
4) Now that git knows what the two labels are, it starts bisecting as usual.

For compatibility with already written scripts, "git bisect good" and
"git bisect bad" will alias to "git bisect mark good" and "git bisect
mark bad" respectively.

Does this make sense? Did I overlook some details?

There were already several proposals on this topic, among which those
listed at https://git.wiki.kernel.org/index.php/SmallProjectsIdeas#git_bisect_fix.2Funfixed.
I'm interested in contacting the prospective mentor, Christian Couder,
to go over these. What's the proper way to ask for an introduction? I
tried asking on IRC, but had no success.

Cheers,
Jacopo Notarstefano
